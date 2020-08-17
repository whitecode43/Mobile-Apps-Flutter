import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});
  double _bmi;
  final int height;
  final int weight;

  String calculateBmi() {
    _bmi = weight / (pow(height / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi > 25)
      return 'overweight';
    else if (_bmi > 19)
      return 'Normal';
    else
      return 'Underweight';
  }

  String getInterpolation() {
    if (_bmi > 25)
      return 'You need to do sport You are too fat';
    else if (_bmi > 19)
      return 'Woo keep it that way';
    else
      return 'Eat more, You need to eat more';
  }
}
