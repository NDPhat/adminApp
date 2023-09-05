import 'package:admin/application/cons/color.dart';
import 'package:flutter/material.dart';

String findAveScore(int score) {
  if (score < 5) {
    return "YEU";
  } else if (score > 5 && score < 7) {
    return "TRUNG BINH";
  } else if (score > 7 && score < 8) {
    return "KHA";
  } else if (score > 8) {
    return "GIOI";
  }
  return "KHA";
}

int findLength(int length) {
  if (length % 5 > 0) {
    length = length ~/ 5 + 1;
  } else {
    length = length ~/ 5;
  }
  return length;
}
