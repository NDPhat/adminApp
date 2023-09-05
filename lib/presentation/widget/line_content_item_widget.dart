import 'package:admin/application/cons/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../application/cons/text_style.dart';
class LineContentItem extends StatelessWidget {
  const LineContentItem({
    super.key,
    required this.title,
    required this.icon,
    required this.colorBG,
  });
  final Color colorBG;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(color: colorBG),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.w, bottom: 2.w, left: 2.w),
            child: Text(
              title,
              style: GoogleFonts.aBeeZee(color: colorSystemWhite,fontSize: 16),
            ),
          ),
          icon
        ],
      ),
    );
  }
}
