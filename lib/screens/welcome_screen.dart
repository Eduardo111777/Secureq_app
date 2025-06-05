import 'package:flutter/material.dart';

// This widget defines the welcome screen of the app.
// It displays a centered layout with an icon, welcome message, subtitle, and navigation button.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The entire screen uses a centered layout
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Adds spacing around the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Vertically centers all children
            children: [
              // Lock icon representing security
              const Icon(Icons.lock_outline),
              const SizedBox(height: 20), // Space between icon and title

              // Main title text
              Text(
                'Welcome to SecureQ',
                style: Theme.of(context).textTheme.headlineMedium, // Uses theme-defined style
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10), // Space between title and subtitle

              // Subtitle text describing the app's purpose
              Text(
                'Hybrid Quantum-Classical Password Generator',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30), // Space before the button

              // Button that navigates to the main generator screen
              ElevatedButton.icon(
                onPressed: () {
                  // Replaces the current screen with the main menu ("/" route)
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.arrow_forward), // Forward arrow icon
                label: const Text('Enter Generator'), // Button label
              ),
            ],
          ),
        ),
      ),
    );
  }
}
