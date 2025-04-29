import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_page.dart';

class ScientistHistoryScreen extends StatefulWidget {
  const ScientistHistoryScreen({super.key});

  @override
  _ScientistHistoryScreenState createState() => _ScientistHistoryScreenState();
}

class ScientistPageView extends StatefulWidget {
  const ScientistPageView({super.key});

  @override
  State<ScientistPageView> createState() => _ScientistPageViewState();
}

class _ScientistPageViewState extends State<ScientistPageView> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(), // this is fine
        onPageChanged: (int page) {
          setState(() => _currentPage = page);
        },
        children: const [
          AboutPage(),
          ScientistHistoryScreen(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) => _buildIndicator(index)),
      ),
    );
  }


  /// 🔹 Page Indicator (for About and Scientist Dashboard)
  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: _currentPage == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}


class _ScientistHistoryScreenState extends State<ScientistHistoryScreen> {
  List<String> hiddenFarmerIds = [];
  Map<String, TextEditingController> responseControllers = {};
  List<Map<String, dynamic>> mergedData = [];

  @override
  void initState() {
    super.initState();
    _clearHiddenFarmers().then((_) {
      _loadHiddenFarmers().then((_) {
        _fetchMergedData();
      });
    });
  }

  // 🧹 Optional clear method for debugging
  Future<void> _clearHiddenFarmers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hiddenFarmers');
    hiddenFarmerIds.clear();
    print("🧹 Hidden farmers cleared");
  }

  Future<void> _loadHiddenFarmers() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hiddenFarmerIds = prefs.getStringList('hiddenFarmers') ?? [];
    });
    print("🔒 Hidden farmer IDs: $hiddenFarmerIds");
  }

  Future<void> _hideFarmer(String farmerId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hiddenFarmerIds.add(farmerId);
      mergedData.removeWhere((data) => data['farmerId'] == farmerId);
    });
    await prefs.setStringList('hiddenFarmers', hiddenFarmerIds);
    print("❌ Farmer hidden: $farmerId");
  }

  Future<void> _updateResponse(String queryId, String response) async {
    if (response.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('queries').doc(queryId).update({
        'response': response,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        for (var data in mergedData) {
          if (data['queryId'] == queryId) {
            data['response'] = response;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Response submitted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error submitting response!")),
      );
    }
  }

  Future<void> _fetchMergedData() async {
    try {
      var queriesSnapshot = await FirebaseFirestore.instance
          .collection('queries')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> tempData = [];

      for (var queryDoc in queriesSnapshot.docs) {
        var queryData = queryDoc.data();
        String farmerId = queryData['farmerId']?.toString() ?? '';
        if (farmerId.isEmpty || hiddenFarmerIds.contains(farmerId)) continue;

        String farmerName = queryData['farmerName'] ?? 'Unknown';
        String disease = queryData['detectedDisease'] ?? 'Not detected';
        Timestamp? loginTime = queryData['login_time'];
        String queryId = queryDoc.id;
        String responseText = queryData['response']?.toString() ?? '';

        if (!responseControllers.containsKey(queryId)) {
          final controller = TextEditingController(text: responseText);
          controller.addListener(() => setState(() {}));
          responseControllers[queryId] = controller;
        }

        tempData.add({
          'farmerId': farmerId,
          'name': farmerName,
          'disease': disease,
          'login_time': loginTime,
          'query': queryData['question']?.toString() ?? '',
          'queryId': queryId,
          'response': responseText,
          'controller': responseControllers[queryId],
          'timestamp': queryData['timestamp'],
        });
      }

      tempData.sort((a, b) {
        var timeA = a['timestamp'] as Timestamp?;
        var timeB = b['timestamp'] as Timestamp?;
        return (timeB?.compareTo(timeA ?? Timestamp(0, 0)) ?? 0);
      });

      setState(() {
        mergedData = tempData;
      });
    } catch (e) {
      print("❌ Error fetching merged data: $e");
    }
  }


  Widget _buildCombinedList({required bool pendingOnly}) {
    List<Map<String, dynamic>> filtered = mergedData.where((data) {
      if (pendingOnly) {
        return data['query'] != null &&
            (data['response'] == null || data['response'].isEmpty);
      } else {
        return data['query'] != null &&
            data['response'] != null &&
            data['response'].isNotEmpty;
      }
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          pendingOnly ? "No pending queries." : "No responded queries yet.",
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemBuilder: (context, index) {
        var data = filtered[index];
        var farmerId = data['farmerId'];

        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("👨‍🌾 Name: ${data['name']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("🦠 Disease: ${data['disease']}"),
                Text(
                  "⏰ Login Time: ${data['login_time'] is Timestamp ? DateFormat('dd-MM-yyyy HH:mm').format((data['login_time'] as Timestamp).toDate()) : "No time recorded"}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                if (data['query'] != null)
                  Text("📩 Query: ${data['query']}", style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                if (pendingOnly)
                  Column(
                    children: [
                      TextField(
                        controller: data['controller'],
                        decoration: InputDecoration(
                          labelText: "Enter Response",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: data['controller'].text.trim().isNotEmpty
                          ? () {
                              _updateResponse(data['queryId'], data['controller'].text.trim());
                            }
                          : null,
                        icon: const Icon(Icons.send),
                        label: const Text("Submit Response"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  )
                else
                  Text("✅ Response: ${data['response']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _hideFarmer(farmerId),
                    tooltip: 'Hide Farmer',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Scientist Dashboard"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchMergedData,
              tooltip: 'Refresh Data',
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: '🕒 Pending'),
              Tab(text: '✅ Responded'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildCombinedList(pendingOnly: true),
                    _buildCombinedList(pendingOnly: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
    
  }
}