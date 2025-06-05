import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_PhotonRain> _photons = [];

  @override
  void initState() {
    super.initState();

    // Animation controller for continuous movement
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Generate randomized falling beams
    final random = Random();
    for (int i = 0; i < 25; i++) {
      _photons.add(
        _PhotonRain(
          startTop: -100.0,
          endTop: 900.0,
          left: random.nextDouble(), // normalized horizontal position
          height: 2.0,
          color: const Color.fromARGB(255, 200, 160, 20).withOpacity(0.5), // soft gold
          speedFactor: 0.5 + random.nextDouble() * 1.5,
        ),
      );
    }

    // Automatically navigate to main screen after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainMenu()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Falling photon effects across full width
              ..._photons.map((photon) {
                final progress = (_controller.value * photon.speedFactor) % 1.0;
                final top = lerpDouble(photon.startTop, photon.endTop, progress)!;
                return Positioned(
                  top: top,
                  left: photon.left * screenWidth,
                  child: Container(
                    width: 2.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          photon.color.withOpacity(0.0),
                          photon.color,
                          photon.color.withOpacity(0.0),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),

              // Center title and progress bar
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SecureQ',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 194, 7), // bright gold
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 180,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: const Color.fromARGB(255, 255, 194, 7),
                        minHeight: 1.5, // slim progress line
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Represents a falling quantum particle beam
class _PhotonRain {
  final double startTop;
  final double endTop;
  final double left;
  final double height;
  final Color color;
  final double speedFactor;

  _PhotonRain({
    required this.startTop,
    required this.endTop,
    required this.left,
    required this.height,
    required this.color,
    required this.speedFactor,
  });
}
