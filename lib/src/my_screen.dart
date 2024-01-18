
import 'package:animated_theme_changing/animated_theme_changing.dart';
import 'package:flutter/material.dart';

import 'garvity/position_calculator.dart';
import 'main.dart';


class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  Gravity gravity = Gravity(
  );

  @override
  void initState() {
    super.initState();
    gravity.float();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedThemeChangerScaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text('Flutter - Gravity'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isDarkMode.value = !isDarkMode.value;
        },
        child: const Icon(Icons.lightbulb_outline),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: gravity.position,
          builder: (context, value, child) {
            return Transform.translate(
              offset: gravity.position.value,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.5),
                ),
                child: const Center(
                  child: Text(
                    'Gravity Ball',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ),
      isDarkMode: isDarkMode,
    );
  }
}
