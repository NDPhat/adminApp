import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

import '../../application/cons/text_style.dart';

class BackGroundListView extends StatelessWidget {
  const BackGroundListView(
      {Key? key,
      required this.child,
      required this.colorBG,
      required this.width,
      required this.height,
      required this.content})
      : super(key: key);

  final Color colorBG;
  final Widget child;
  final double width, height;
  final String content;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorBG, width: 2),
        ),
        width: width,
        height: height,
        child: Stack(
          children: [
            QuarterCircle(
              width: width * 0.5,
              height: height * 0.3,
              color: colorBG,
              circleAlignment: CircleAlignment.topLeft,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: colorBG),
                ),
              ),
              alignment: Alignment.centerRight,
              width: 100.w,
              height: 5.h,
              child: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Text(
                  content,
                  style: TextStyle(
                      color: colorBG,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}

enum CircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class QuarterCircle extends StatelessWidget {
  final CircleAlignment circleAlignment;
  final Color color;
  const QuarterCircle({
    Key? key,
    required this.circleAlignment,
    required this.color,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: CustomPaint(
          painter: QuarterCirclePainter(
            circleAlignment: circleAlignment,
            color: color,
          ),
        ),
      ),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter(
      {required this.circleAlignment, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height, size.width);
    final offset = circleAlignment == CircleAlignment.topLeft
        ? const Offset(.0, .0)
        : circleAlignment == CircleAlignment.topRight
            ? Offset(size.width, .0)
            : circleAlignment == CircleAlignment.bottomLeft
                ? Offset(.0, size.height)
                : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}
