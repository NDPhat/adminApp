import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';

class DotPageIndicator extends StatelessWidget {
  const DotPageIndicator(
      {Key? key,
        required this.icon,
        required this.onTap,
        required this.colorBorder})
      : super(key: key);
  final Widget icon;
  final Color colorBorder;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 8.w,
        height: 4.h,
        decoration: BoxDecoration(
            color: colorSystemWhite,
            border: Border.all(color: colorBorder),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(child: icon),
      ),
    );
  }
}
