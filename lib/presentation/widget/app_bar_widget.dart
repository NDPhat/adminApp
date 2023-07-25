import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../application/cons/color.dart';
import '../../application/cons/text_style.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {Key? key,
        required this.onBack,
        this.textTitle,
        this.bgColor,
        this.onSetting,
        this.childSetting})
      : super(key: key);
  String? textTitle;
  final VoidCallback onBack;
  final Color? bgColor;
  VoidCallback? onSetting;
  Widget? childSetting;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor == null ? colorMainBlue : bgColor,
      width: 100.w,
      height: 10.h,
      padding: EdgeInsets.only(top: 2.h),
      child: Stack(
        children: [
          Container(
            width: 100.w,
            alignment: Alignment.center,
            child: Text(
              textTitle ?? "",
              style: s20f700ColorSysWhite,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left:6.w),
            child: GestureDetector(
                onTap: onBack,
                child: const Icon(
                  Icons.keyboard_backspace,
                  color: colorSystemYeloow,
                  size: 30,
                )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 6.w),
            child: GestureDetector(
                onTap: onSetting, child: childSetting ?? Container()),
          )
        ],
      ),
    );
  }
}
