import 'package:admin/application/cons/color.dart';
import 'package:flutter/material.dart';

Color findColor(String color) {
  switch (color) {
    case "yellow":
      return colorSystemYeloow;
    case "red":
      return colorErrorPrimary;
    case "blue":
      return colorMainBlue;
  }
  return colorMainBlue;
}

Color findColorByScore(String text) {
  switch (text) {
    case "KHA":
      return colorMainBlue;
    case "TRUNG BINH":
      return colorSystemYeloow;
    case "YEU":
      return colorErrorPrimary;
    case "GIOI":
      return colorMainTealPri;
  }
  return colorMainBlue;
}
