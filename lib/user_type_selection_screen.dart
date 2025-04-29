import 'package:flutter/material.dart';
import 'farmer_registration_screen.dart';
import 'scientist_auth_screen.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to CottonShield",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Are you a Farmer or a Scientist?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              
              // Farmer Button
              _buildUserOption(
                context,
                imagePath: "assets/farmer.png",
                label: "I am a Farmer",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const FarmerRegistrationScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Scientist Button
              _buildUserOption(
                context,
                imagePath: "assets/scientist.png",
                label: "I am a Scientist",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ScientistAuthScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserOption(BuildContext context, {required String imagePath, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 80), // Image of farmer or scientist
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}