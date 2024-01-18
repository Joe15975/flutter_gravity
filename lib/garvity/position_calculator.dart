
// this class returns position of floating widget making it floats
// and affect floating when window position or size changed
// simulating physics

import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gravity/garvity/math_utils.dart';
import 'package:window_manager/window_manager.dart';

import '../models/min_max.dart';

class Gravity {
  static double gravity = 9.8;

  static double timeSlowDownFactor = 500;

  static double maxPosLossRatio = 0.2;

  double get time => DateTime.now().millisecondsSinceEpoch / timeSlowDownFactor;

  MinMax minMaxY = MinMax(100, -100);
  MinMax minMaxX = MinMax(100, -100);

  ValueNotifier<Offset> position = ValueNotifier<Offset>(Offset.zero);

  ValueNotifier<Offset> windowOffset = ValueNotifier<Offset>(Offset.zero);

  ValueNotifier<Offset> vector = ValueNotifier<Offset>(Offset.zero);

  ValueNotifier<double> velocity = ValueNotifier<double>(3);

  ValueNotifier<double> acceleration = ValueNotifier<double>(0.2);


  void float() {
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      updatePosition();
      WindowManager.instance.getPosition().then((value) {
        // print('position: ${value.toString()}');
        // if (value == windowOffset.value) {
        //   return;
        // }

        setVector = Offset.lerp(
            vector.value,
            Offset(
              value.dx - windowOffset.value.dx,
              value.dy - windowOffset.value.dy,
            ),
            .01
        )!;

        if (vector.value != Offset.zero) {
          print('vector: ${vector.value.toString()}');
        }

        windowOffset.value = value;
      });
    });
  }

  void updatePosition() {

    // double yValue = 50 * yEquation(time);
    double yValue = 0;

    // Offset newPosition = Offset(
    //   lerpDouble(position.value.dx, vector.value.dx * -200, 0.001) ?? 0,
    //   /*yValue +*/ ((lerpDouble(yValue, vector.value.dy * -200, 0.01) ?? 0) ),
    // );

    Offset newPosition = Offset.lerp(
        position.value,
        vector.value * -50,
        .01
    )!;

    position.value = newPosition;
  }

  double getCalculateMaxY() {
    double appliedLoss = minMaxY.max * maxPosLossRatio;
    return appliedLoss;
  }

  double yEquation(double time) {
    return sin(
        MathUtils.calculateSigma(-1, 1, (n) => sin(time))
            *
            MathUtils.calculateSigma(-0.03, 0.03, (n) => sin(0.6 * 15.5))
    );
  }

  double vectorPower(){
    double result = sqrt(pow(vector.value.dx, 2) + pow(vector.value.dy, 2));
    // print('vector power: $result');
    return result;
  }

  set setVector(Offset offset) {
    double multiplier = 1;
    vector.value = Offset(offset.dx * multiplier, offset.dy * multiplier);
  }


}