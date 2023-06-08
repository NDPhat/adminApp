import 'package:flutter/material.dart';

import '../../application/cons/color.dart';
import '../../application/cons/text_style.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {Key? key,
        required this.size,
        required this.onBack,
        this.textTitle,
        this.childSetting})
      : super(key: key);
  final Size size;
  String? textTitle;
  final VoidCallback onBack;
  Widget? childSetting;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBlue,
      width: size.width,
      height: size.height * 0.1,
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Stack(
        children: [
          Container(
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              textTitle ?? "",
              style: s20f700ColorSysWhite,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: GestureDetector(
                onTap: onBack,
                child: const Icon(
                  Icons.keyboard_backspace,
                  color: colorSystemWhite,
                  size: 30,
                )),
          ),
        ],
      ),
    );
  }
}
