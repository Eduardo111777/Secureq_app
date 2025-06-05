import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  // Constructor with optional title override
  const CustomAppBar({super.key, this.title});

  // Define AppBar height
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? 'Hybrid Quantum-Classical Password Generator',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Return to Home',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ],
    );
  }
}
