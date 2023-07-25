import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class SettingMenuWidget extends StatelessWidget {
  const SettingMenuWidget({
    Key? key,
    required this.title,
    required this.widget,
    required this.onPress,
    required this.textStyle,
  }) : super(key: key);

  final String title;
  final Widget widget;
  final VoidCallback onPress;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onPressed: onPress,
      child: Container(
        padding: EdgeInsets.all(2.w),
        height: 8.h,
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 50.w,
                child: Row(
                  children: [
                    widget,
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(title, style: textStyle),
                  ],
                )),
            const Icon(LineAwesomeIcons.angle_right,
                size: 30.0, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
