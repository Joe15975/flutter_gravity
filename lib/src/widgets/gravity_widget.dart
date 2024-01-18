import 'package:flutter/material.dart';
import 'package:flutter_gravity/src/garvity/position_calculator.dart';

class GravityWidget extends StatelessWidget {

  final Widget widget;
  final Gravity? gravity;

  factory GravityWidget({
    required Widget widget,
    Gravity? gravity,
  }) {
    gravity ??= Gravity();
    gravity.float();
    return GravityWidget._(
      widget: widget,
      gravity: gravity,
    );
  }

  const GravityWidget._({
    required this.widget,
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
      child: widget,
    );
  }
}
