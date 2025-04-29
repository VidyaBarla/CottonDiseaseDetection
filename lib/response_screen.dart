import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueriesAndResponsesScreen extends StatefulWidget {
  const QueriesAndResponsesScreen({super.key});

  @override
  _QueriesAndResponsesScreenState createState() => _QueriesAndResponsesScreenState();
}

class _QueriesAndResponsesScreenState extends State<QueriesAndResponsesScreen> {
  String? farmerId;
  List<QueryDocumentSnapshot> queries = [];
  List<String> deletedQueryIds = [];

  @override
  void initState() {
    super.initState();
    _loadFarmerId();
    _loadDeletedQueryIds();
  }

  void _loadFarmerId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('farmerId');
    print('DEBUG: Loaded Farmer ID: $id');

    if (id != null) {
      setState(() => farmerId = id);
    } else {
      print("❌ farmerId not found in SharedPreferences.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login again."), backgroundColor: Colors.red),
      );
      Navigator.pop(context);
    }
  }

  _loadDeletedQueryIds() async {
    final prefs = await SharedPreferences.getInstance();
    final deletedIds = prefs.getStringList('deleted_queries') ?? [];
    print('DEBUG: Loaded deleted query IDs: $deletedIds');
    setState(() => deletedQueryIds = deletedIds);
  }

  _saveDeletedQueryIds() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('deleted_queries', deletedQueryIds);
  }

  // 🔧 Format Firestore timestamp to readable string
  String _formatTimestamp(dynamic timestamp) {
  if (timestamp is Timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
  return "Invalid date";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Responses from Scientist",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF66BB6A), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: farmerId == null
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('queries')
                    .where('farmerId', isEqualTo: farmerId)
                    .orderBy('timestamp', descending: true) // ✅ Sort by newest first
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No queries yet.",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  queries = snapshot.data!.docs
                      .where((query) => !deletedQueryIds.contains(query.id))
                      .toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: queries.length,
                    itemBuilder: (context, index) {
                      var queryData = queries[index].data() as Map<String, dynamic>;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.question_answer, color: Colors.blueAccent, size: 24),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Query: ${queryData['question'] ?? 'No question'}",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          deletedQueryIds.add(queries[index].id);
                                          _saveDeletedQueryIds();
                                          queries.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.grey, thickness: 0.5, height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      queryData['response'] != null && queryData['response'].toString().isNotEmpty
                                          ? Icons.check_circle
                                          : Icons.pending_actions,
                                      color: queryData['response'] != null && queryData['response'].toString().isNotEmpty
                                          ? Colors.green
                                          : Colors.redAccent,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            queryData['response'] != null && queryData['response'].toString().isNotEmpty
                                                ? "Response: ${queryData['response']}"
                                                : "No response yet.",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: queryData['response'] != null &&
                                                      queryData['response'].toString().isNotEmpty
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          if (queryData['responseTime'] != null && queryData['responseTime'] is Timestamp)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 6.0),
                                              child: Text(
                                                "Responded on: ${_formatTimestamp(queryData['responseTime'])}",
                                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
