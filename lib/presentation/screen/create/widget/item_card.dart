import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'dart:math' as math;

import '../../../../application/cons/color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.childCenter,
      required this.backgroundColor,
      required this.onTap,
      required this.childRight})
      : super(key: key);
  final Widget childCenter;
  final Widget childRight;
  final Color backgroundColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        child: SizedBox(
          height: 10.h,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 50.w,
                child: childCenter,
              ),
              Expanded(
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: const Divider(
                    color: colorSystemWhite,
                    height: 50,
                    thickness: 2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 30.w,
                child: childRight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
