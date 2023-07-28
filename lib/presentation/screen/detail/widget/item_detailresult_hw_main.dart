import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemDetailRSHWMainScreen extends StatelessWidget {
  const ItemDetailRSHWMainScreen({
    Key? key,
    required this.week,
    required this.name,
    required this.childRight,
    required this.colorBorder,
    required this.score,
  }) : super(key: key);
  final String week;
  final String name;
  final String score;
  final Widget childRight;
  final Color colorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: colorBorder),
          color: colorSystemWhite,
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
      width: 90.w,
      height: 16.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 35.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' Week : $week',
                    style:
                        GoogleFonts.fahkwang(color: colorBorder, fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name : $name',
                    style:
                        GoogleFonts.fahkwang(color: colorBorder, fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Score : $score',
                    style:
                        GoogleFonts.fahkwang(color: colorBorder, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [SizedBox(height: 13.h, child: childRight)],
            ),
          ),
        ],
      ),
    );
  }
}
