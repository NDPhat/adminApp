import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';



class RoundedButton extends StatelessWidget {
  final VoidCallback press;
  final double width;
  final double height;
  final Color color;
  final Widget child;
  RoundedButton(
      {Key? key,
        required this.press,
        required this.color,
        required this.width,
        required this.height,
        required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 200),
      onPressed: press,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(50))),
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
