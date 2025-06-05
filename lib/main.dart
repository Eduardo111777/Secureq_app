import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/quantum_password_generator.dart';
import 'screens/welcome_screen.dart';
import 'widgets/custom_appbar.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';



// Entry point: launches the root widget of the app
void main() {
  runApp(const SecureQApp());
}

// Root widget that initializes the app theme and sets the initial screen
class SecureQApp extends StatelessWidget {
  const SecureQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureQ: Hybrid Generator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      home: const SplashScreen(), // Shows splash screen first, then navigates to main menu
    );
  }
}

// Main menu that appears after splash screen; routes to the password generator
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title and description
            Text(
              'Welcome to SecureQ:\nHybrid Quantum-Classical Password Generator',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),

            // Button that opens the password generator screen
            ElevatedButton.icon(
              icon: const Icon(Icons.key),
              label: const Text('Generate Secure Password'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuantumPasswordGenerator()),
                );
              },
            ),
            const SizedBox(height: 40),

            // Informational text shown only in web builds
            if (kIsWeb)
              Text(
                'Running in Web Mode',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(color: Colors.white38),
              ),
          ],
        ),
      ),
    );
  }
}
