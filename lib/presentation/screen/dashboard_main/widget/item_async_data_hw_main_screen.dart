import 'package:flutter/material.dart';
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
    required this.timeNow,
    required this.onTap,
  }) : super(key: key);
  final String textTitle;
  final String totalUserJoin;
  final String timeNow;
  final String scoreAvg;
  final Widget childRight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: colorBGInput,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding:
              EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
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
                        textTitle,
                        style: s16f500ColorGreyTe,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Join : $totalUserJoin',
                        style: s16f500ColorError,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Average : $scoreAvg',
                        style: s14f500ColorMainTe,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 5.h,
                      child: Text(
                        timeNow,
                        style: s12f400ColorGreyTe,
                      ),
                    ),
                    SizedBox(height: 13.h, child: childRight)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
