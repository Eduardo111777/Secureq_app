import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantumPasswordGenerator extends StatefulWidget {
  const QuantumPasswordGenerator({super.key});

  @override
  State<QuantumPasswordGenerator> createState() => _QuantumPasswordGeneratorState();
}

class _QuantumPasswordGeneratorState extends State<QuantumPasswordGenerator> {
  int bitLength = 128; // Total bits generated for simulation
  String password = ''; // Final secure password output
  List<int> aliceBits = []; // Random bits generated by Alice
  List<String> aliceBases = []; // Random bases chosen by Alice (+ or ×)
  List<String> bobBases = []; // Random bases chosen by Bob (+ or ×)
  List<int> sharedKey = []; // Bits where Alice's and Bob's bases match
  bool showPassword = false; // Toggle to display/hide password
  int passwordLength = 24; // Desired password length (characters)

  @override
  void initState() {
    super.initState();
    generatePassword(); // Automatically generate on screen load
  }

  // Simulates BB84 key exchange: generate bits and bases for Alice and Bob,
  // then extract shared key using basis alignment.
  void generatePassword() {
    final rand = Random.secure();
    aliceBits = List.generate(bitLength, (_) => rand.nextInt(2));
    aliceBases = List.generate(bitLength, (_) => rand.nextBool() ? '+' : '×');
    bobBases = List.generate(bitLength, (_) => rand.nextBool() ? '+' : '×');

    sharedKey = [];
    for (int i = 0; i < bitLength; i++) {
      if (aliceBases[i] == bobBases[i]) {
        sharedKey.add(aliceBits[i]); // Keep bit only if bases match
      }
    }

    password = convertToSecurePassword(sharedKey, passwordLength);
    setState(() {});
  }

  // Converts binary key into a secure password using 6-bit chunking
  // and mapping to a fixed charset (64+ characters).
  String convertToSecurePassword(List<int> bits, int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';
    String result = '';
    int i = 0;
    final rand = Random.secure();

    while (result.length < length) {
      int chunk = 0;
      for (int j = 0; j < 6; j++) {
        if (i + j < bits.length) {
          chunk = (chunk << 1) | bits[i + j];
        } else {
          chunk = (chunk << 1) | rand.nextInt(2); // Fallback random bits
        }
      }
      result += charset[chunk % charset.length];
      i += 6;
    }

    return result;
  }

  // Returns a base-specific color for chip avatars (for visualization only)
  Color baseColor(String base) {
    return base == '+' ? Colors.blue : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')), // Title styling handled by theme
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(''),
            DropdownButton<int>(
              value: passwordLength,
              onChanged: (value) {
                if (value != null) {
                  passwordLength = value;
                  generatePassword();
                }
              },
              items: [16, 24, 32, 40]
                  .map((length) => DropdownMenuItem(value: length, child: Text('$length Characters')))
                  .toList(),
            ),
            Row(
              children: [
                const Text(''),
                Expanded(
                  child: LinearProgressIndicator(
                    value: passwordLength / 40.0, // Visual password strength meter
                  ),
                ),
                const SizedBox(width: 10),
                Text('$passwordLength chars'),
              ],
            ),
            if (showPassword)
              SelectableText(password), // Show/hide final password
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => showPassword = !showPassword),
                  child: Text(showPassword ? 'Hide Password' : 'Show Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: password));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password copied to clipboard')),
                    );
                  },
                  child: const Text('Copy'),
                ),
                ElevatedButton(
                  onPressed: generatePassword,
                  child: const Text('New Password'),
                ),
              ],
            ),
            const Divider(),
            const Text(''),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(bitLength, (i) {
                final match = aliceBases[i] == bobBases[i];
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: match ? Colors.green : baseColor(aliceBases[i]),
                    child: Text(aliceBases[i]),
                  ),
                  label: Text('${aliceBits[i]}'),
                  backgroundColor: match ? Colors.green.shade100 : Colors.grey.shade200,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
