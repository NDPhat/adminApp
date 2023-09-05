import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:sizer/sizer.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback press;
  final double width;
  final double height;
  final Color color;
  Color? colorBorder;
  final Widget child;
  RoundedButton(
      {Key? key,
      required this.press,
      required this.color,
      required this.width,
      this.colorBorder,
      required this.height,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onPressed: press,
      child: Container(
        decoration: colorBorder != null
            ? BoxDecoration(
                border: Border.all(color: colorBorder!, width: 2),
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10.w)))
            : BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10.w))),
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
