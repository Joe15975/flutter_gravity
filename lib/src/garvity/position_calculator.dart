
// this class returns position of floating widget making it floats
// and affect floating when window position or size changed
// simulating physics

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gravity/src/extensions.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:window_manager/window_manager.dart';

import '../models/min_max.dart';
import 'math_utils.dart';

class Gravity {

  factory Gravity({
    MinMax? sigma1,
    MinMax? sigma2,
    double? timeSlowDownFactor,
    double threshold = 15.5,
    double lerpTime = 0.01,
    double multiplier = -50,
    bool floatOnly = false,
    bool gravityOnly = false,
  }) {
    return Gravity._(
      sigma1 ?? const MinMax(-1, 1),
      sigma2 ?? const MinMax(-0.03, 0.03),
      timeSlowDownFactor ?? 500,
      threshold,
      lerpTime,
      multiplier,
      floatOnly,
      gravityOnly,
    );
  }

  Gravity._(this.sigma1, this.sigma2, this.timeSlowDownFactor,
      this.threshold, this.lerpTime, this.multiplier, this.floatOnly, this.gravityOnly);

  MinMax sigma1;
  MinMax sigma2;
  double threshold;

  double timeSlowDownFactor;

  double lerpTime;

  double multiplier;

  bool floatOnly;
  bool gravityOnly;

  bool isFloating = false;


  double get time => DateTime.now().millisecondsSinceEpoch / timeSlowDownFactor;


  ValueNotifier<Offset> position = ValueNotifier<Offset>(Offset.zero);

  ValueNotifier<Offset> windowOffset = ValueNotifier<Offset>(Offset.zero);
  ValueNotifier<Offset> accelerometerOffset = ValueNotifier<Offset>(Offset.zero);

  ValueNotifier<Offset> vector = ValueNotifier<Offset>(Offset.zero);


  Future<void> float() async {
    if (isFloating) return;

    isFloating = true;
    if (Platform.isAndroid || Platform.isIOS){
      calcForMobile();
    }
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      updatePositionAll();
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS){
        calcForDesktop();
      }
    });
  }


  // windows/ mac/ linux
  void calcForDesktop(){
    WindowManager.instance.getPosition().then((value) {

      setVector = Offset.lerp(
          vector.value,
          Offset(
            value.dx - windowOffset.value.dx,
            value.dy - windowOffset.value.dy,
          ),
          lerpTime
      )!;

      windowOffset.value = value;
    });
  }
  // android/ ios
  void calcForMobile(){
    gyroscopeEventStream().listen((event) {
      setVector = Offset.lerp(
          vector.value,
          // had to swap x and y because of gyroscope values
          Offset(
            event.y - accelerometerOffset.value.dy,
            event.x - accelerometerOffset.value.dx,
          ).multiply(multiplier),
          lerpTime
      )!;
      accelerometerOffset.value = Offset(event.x, event.y);
      print('gyroscope: ${event.x}, ${event.y}');
    });
  }

  void updatePositionAll() {

    double yValue = yEquation(time);

    // Offset newPosition = Offset(
    //   lerpDouble(position.value.dx, vector.value.dx * -200, 0.001) ?? 0,
    //   /*yValue +*/ ((lerpDouble(yValue, vector.value.dy * -200, 0.01) ?? 0) ),
    // );

    Offset newPosition;

    if (!floatOnly && !gravityOnly){
      newPosition = Offset.lerp(
          position.value,
          vector.value.addToY(yValue) * multiplier,
          lerpTime
      )!;
    } else if (floatOnly && !gravityOnly){
      newPosition = Offset(
        0,
        yValue * multiplier,
      );
    } else if (!floatOnly && gravityOnly){
      newPosition = Offset.lerp(
          position.value,
          vector.value * multiplier,
          lerpTime
      )!;
    } else {
      newPosition = Offset.zero;
    }

    position.value = newPosition;
  }

  double yEquation(double time) {
    return sin(
        MathUtils.calculateSigma(sigma1.min, sigma1.max, (n) => sin(time))
            *
        MathUtils.calculateSigma(sigma2.min, sigma2.max, (n) => sin(0.6 * threshold))
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