
import 'package:flutter/material.dart';
import 'package:flutter_gravity/flutter_gravity.dart';
import 'package:flutter_gravity/src/widgets/gravity_widget.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text('Flutter - Gravity'),
      ),
      body: Center(
        child: GravityWidget(
          gravity: Gravity(
            multiplier: -15,
            gravityOnly: true,
          ),
          widget: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.5),
            ),
            child: const Center(
              child: Text(
                'Gravity',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
