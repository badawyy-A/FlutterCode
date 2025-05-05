

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:morshd/features/home/ui/home_screen.dart';

class EmergencyServices extends StatelessWidget {
  const EmergencyServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Services'),
        backgroundColor: const Color(0xffCEA16E), // Match HomeScreen app bar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(), // Redirect to HomeScreen
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            // Police Button
            SizedBox(
              width: 250, // Set a fixed width for all buttons
              child: EmergencyButton(
                icon: Icons.local_police,
                label: 'Call Police',
                phoneNumber: '122', // Replace with your country's police number
              ),
            ),
            const SizedBox(height: 20), // Add spacing between buttons
            // Ambulance Button
            SizedBox(
              width: 250, // Set a fixed width for all buttons
              child: EmergencyButton(
                icon: Icons.medical_services,
                label: 'Call Ambulance',
                phoneNumber: '123', // Replace with your country's ambulance number
              ),
            ),
            const SizedBox(height: 20), // Add spacing between buttons
            // Firefighter Button
            SizedBox(
              width: 250, // Set a fixed width for all buttons
              child: EmergencyButton(
                icon: Icons.fire_truck,
                label: 'Call Firefighter',
                phoneNumber: '180', // Replace with your country's firefighter number
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Button Widget
class EmergencyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String phoneNumber;

  const EmergencyButton({
    super.key,
    required this.icon,
    required this.label,
    required this.phoneNumber,
  });

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    // Show the phone number in a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling $phoneNumber...'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Make the phone call
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }

    // Redirect to HomeScreen after the call

  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 30),
      label: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: () => _makePhoneCall(context, phoneNumber),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        backgroundColor: const Color(0xffCEA16E), // Match HomeScreen primary color
        foregroundColor: Colors.white, // White text for better contrast
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}