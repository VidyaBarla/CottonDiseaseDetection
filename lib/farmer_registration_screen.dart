import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_type_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  const FarmerRegistrationScreen({super.key});

  @override
  _FarmerRegistrationScreenState createState() => _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  /// ✅ Register or log in the farmer using Firebase UID (farmerId == uid)
  Future<void> _registerFarmer() async {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name and phone number"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ Check if the phone number already exists
      QuerySnapshot farmerSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();

      if (farmerSnapshot.docs.isNotEmpty) {
        String existingUid = farmerSnapshot.docs.first.id;

        // ✅ Ensure farmerId == uid
        final doc = farmerSnapshot.docs.first;
        if (doc['farmerId'] != existingUid) {
          await doc.reference.update({'farmerId': existingUid});
          print("🔁 Updated old farmerId to match UID: $existingUid");
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('farmerId', existingUid);

        print("✅ Farmer exists. Logging in with UID: $existingUid");

        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          '/upload',
          arguments: {'uid': existingUid, 'farmerName': doc['name'] ?? name},
        );

        return;
      }

      // ✅ New farmer - register anonymously and save data
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('farmers').doc(uid).set({
        'uid': uid,
        'farmerId': uid,
        'name': name,
        'phone': phone,
        'role': 'farmer',
        'login_time': FieldValue.serverTimestamp(),
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('farmerId', uid);

      print("✅ New Farmer registered with UID: $uid");

      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        '/upload',
        arguments: {'uid': uid, 'farmerName': name},
      );

    } catch (e) {
      print("❌ Error registering farmer: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserTypeSelectionScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset('assets/logo_nobg.png', height: 120),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to CottonShield",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please enter your details to continue",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your name",
                      prefixIcon: const Icon(Icons.person, color: Colors.green),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your phone number",
                      prefixIcon: const Icon(Icons.phone, color: Colors.green),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _registerFarmer,
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      label: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Continue"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
