import 'package:admin/application/cons/color.dart';
import 'package:admin/application/cons/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ItemFillter extends StatelessWidget {
  ItemFillter(
      {Key? key,
      required this.name,
      required this.onTap,
      required this.onChoose})
      : super(key: key);
  final String name;
  bool onChoose = false;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 20.w,
        height: 5.h,
        child: Card(
          color: onChoose == true ? colorErrorPrimary : colorMainBlue,
          child: Center(
              child: Text(
            name,
            style: s16f500ColorSysWhite,
          )),
        ),
      ),
    );
  }
}
