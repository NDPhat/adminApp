import 'package:admin/application/cons/color.dart';
import 'package:admin/application/cons/text_style.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

class ItemManagerUser extends StatelessWidget {
  const ItemManagerUser(
      {Key? key, required this.lop, required this.ten, required this.onTap})
      : super(key: key);
  final String lop, ten;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: colorErrorPrimary,
        child: SizedBox(
          height: 15.h,
          child: Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Column(
                  children: [
                    Image.asset("assets/images/icon_app.png"),
                    Text(
                      lop,
                      style: s16f500ColorSysWhite,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: const Divider(
                    color: colorSystemWhite,
                    height: 50,
                    thickness: 2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 30.w,
                child: Text(
                  ten,
                  style: s16f500ColorSysWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
