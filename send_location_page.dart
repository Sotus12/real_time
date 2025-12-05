import 'package:flutter/material.dart';
import '../location_service.dart';

class SendLocationPage extends StatefulWidget {
  const SendLocationPage({super.key});

  @override
  State<SendLocationPage> createState() => _SendLocationPageState();
}

class _SendLocationPageState extends State<SendLocationPage> {
  bool isSharing = false;

  void _toggleSharing() {
    if (isSharing) {
      LocationService.stopLocationUpdates();
    } else {
      LocationService.startLocationUpdates();
    }

    setState(() {
      isSharing = !isSharing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location Sharing"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            Icon(
              isSharing ? Icons.location_on : Icons.location_disabled,
              size: 120,
              color: isSharing ? Colors.green : Colors.redAccent,
            ),

            const SizedBox(height: 20),

            Text(
              isSharing
                  ? "Location Sharing Active"
                  : "Location Sharing Inactive",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isSharing ? Colors.green : Colors.redAccent,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSharing ? Colors.red : Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _toggleSharing,
                child: Text(
                  isSharing ? "STOP SHARING" : "START SHARING",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (isSharing)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.green),
                    SizedBox(width: 12),
                    Text(
                      "Sharing live location...",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
