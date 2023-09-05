import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'dart:math' as math;

import '../../../../application/cons/color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.childCenter,
      required this.colorBorder,
      required this.onTap,
      required this.childRight})
      : super(key: key);
  final Widget childCenter;
  final Widget childRight;
  final Color colorBorder;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: colorBorder),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        height: 12.h,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 60.w,
              child: childCenter,
            ),
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.5, color: colorBorder),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 25.w,
              height: 8.h,
              child: childRight,
            ),
          ],
        ),
      ),
    );
  }
}
