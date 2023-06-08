import 'package:admin/application/cons/color.dart';
import 'package:flutter/material.dart';

Color findColor(String color) {
  switch (color) {
    case "yellow":
      return colorSystemYeloow;
      break;
    case "red":
      return colorErrorPrimary;
      break;
    case "blue":
      return colorMainBlue;
      break;
  }
  return colorMainBlue;
}
