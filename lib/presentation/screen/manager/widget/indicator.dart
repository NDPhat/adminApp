import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator(
      {Key? key,
      required this.pageIndex,
      required this.colorBorder,
      required this.totalPage})
      : super(key: key);
  final String pageIndex;
  final String totalPage;
  final Color colorBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.w,
      height: 5.h,
      decoration: BoxDecoration(
          color: colorSystemWhite,
          border: Border.all(color: colorBorder),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: Text(
          "$pageIndex / $totalPage",
          style: GoogleFonts.abel(
              color: colorBorder, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
