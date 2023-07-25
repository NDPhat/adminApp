import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemDetailRSHWMainScreen extends StatelessWidget {
  const ItemDetailRSHWMainScreen({
    Key? key,
    required this.week,
    required this.name,
    required this.childRight,
  }) : super(key: key);
  final String week;
  final String name;
  final Widget childRight;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorBGInput,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.only(left: 2.h, right: 2.w, top: 1.h, bottom: 1.h),
        width: 90.w,
        height: 20.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' Week : $week',
                      style: s16f500ColorGreyTe,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name : $name',
                      style: s14f500ColorMainTe,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [SizedBox(height: 18.h, child: childRight)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
