import 'package:flutter/material.dart';
import 'package:flutter_gravity/src/garvity/position_calculator.dart';

class GravityWidget extends StatelessWidget {

  final Widget child;
  final Gravity? gravity;

  factory GravityWidget({
    required Widget widget,
    Gravity? gravity,
  }) {
    gravity ??= Gravity();
    gravity.float();
    return GravityWidget._(
      gravity: gravity,
      child: widget,
    );
  }

  const GravityWidget._({
    required this.child,
    this.gravity,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: gravity!.position,
        builder: (context, Offset offset, child) {
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
      child: child,
    );
  }
}
