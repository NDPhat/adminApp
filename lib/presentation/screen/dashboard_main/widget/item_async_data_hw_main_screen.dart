import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemAsyncDataHWPageHome extends StatelessWidget {
  const ItemAsyncDataHWPageHome({
    Key? key,
    required this.textTitle,
    required this.totalUserJoin,
    required this.scoreAvg,
    required this.childRight,
    required this.timeSave,
    required this.onTap,
    required this.colorBorder,
  }) : super(key: key);
  final String textTitle;
  final String totalUserJoin;
  final String timeSave;
  final String scoreAvg;
  final Color colorBorder;
  final Widget childRight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: colorSystemWhite,
            border: Border.all(color: colorBorder),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
        width: 90.w,
        height: 20.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 18.h,
              width: 25.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textTitle,
                      style: GoogleFonts.aclonica(
                          color: colorBorder, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${'total join'.tr()} : $totalUserJoin",
                      style:
                          GoogleFonts.barlow(color: colorBorder, fontSize: 16),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${'average'.tr()} : $scoreAvg",
                      style:
                          GoogleFonts.barlow(color: colorBorder, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60.w,
              height: 16.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10.w),
                    alignment: Alignment.centerRight,
                    height: 3.w,
                    width: 65.w,
                    child: Text(
                      timeSave,
                      style:
                          GoogleFonts.arapey(color: colorBorder, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 13.h, child: childRight)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
