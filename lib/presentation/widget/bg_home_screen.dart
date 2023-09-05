import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/text_style.dart';
import '../../application/cons/color.dart';
import '../../data/local/models/user_global.dart';
import '../../main.dart';

class BGHomeScreen extends StatelessWidget {
  BGHomeScreen({
    Key? key,
    required this.child,
    this.homeIcon,
    required this.textNow,
    required this.onBack,
    this.onPressHome,
    required this.colorTextAndIcon,
  }) : super(key: key);
  Widget child;
  String textNow;
  Widget? homeIcon;
  VoidCallback? onPressHome;
  VoidCallback onBack;
  Color colorTextAndIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.h,
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 100.w,
                child: IconButton(
                    onPressed: onBack,
                    icon: Icon(
                      Icons.keyboard_backspace,
                      size: 30,
                      color: colorTextAndIcon,
                    )),
              ),
              Container(
                width: 100.w,
                alignment: Alignment.center,
                child: Text(textNow,
                    style: TextStyle(
                        color: colorTextAndIcon,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
              GestureDetector(
                onTap: onPressHome,
                child: Container(
                    alignment: Alignment.centerRight,
                    width: 100.w,
                    child: homeIcon),
              )
            ],
          ),
        ),
        child,
      ],
    );
  }
}
