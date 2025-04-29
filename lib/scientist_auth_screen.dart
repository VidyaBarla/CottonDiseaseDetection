import 'package:flutter/material.dart';
import 'user_type_selection_screen.dart'; // Import the selection screen
import 'scientist_history_screen.dart';

class ScientistAuthScreen extends StatefulWidget {
  const ScientistAuthScreen({super.key});

  @override
  _ScientistAuthScreenState createState() => _ScientistAuthScreenState();
}

class _ScientistAuthScreenState extends State<ScientistAuthScreen> {
  final TextEditingController _nameController = TextEditingController();

  /// 🟢 Method to Handle Scientist Authentication
  void _authenticateScientist() {
    String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      // ✅ Navigate to History Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScientistPageView()),
      );
    } else {
      // ❌ Show Error if Name is Empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // ✅ Navigate back to UserTypeSelectionScreen when back button is pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserTypeSelectionScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ App Logo
              Image.asset('assets/logo_nobg.png', height: 120), 
              const SizedBox(height: 20),

              const Text(
                "Welcome Scientist",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              const Text(
                "Please enter your name to continue",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ✅ Name Input Field
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
                  prefixIcon: const Icon(Icons.person, color: Colors.blue),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              // ✅ Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _authenticateScientist,
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
    );
  }
}