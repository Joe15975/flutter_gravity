
import 'package:flutter/material.dart';

import 'garvity/position_calculator.dart';


class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  Gravity gravity = Gravity(
    gravityOnly: true,
  );

  @override
  void initState() {
    super.initState();
    gravity.float();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text('Flutter - Gravity'),
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
    );
  }
}
