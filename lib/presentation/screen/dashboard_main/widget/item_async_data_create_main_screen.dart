import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemAsyncDataCreatePageHome extends StatelessWidget {
  const ItemAsyncDataCreatePageHome({
    Key? key,
    required this.textTitle,
    required this.signList,
    required this.childRight,
    required this.timeJoin,
    required this.onTap,
  }) : super(key: key);
  final String textTitle;
  final List<String> signList;
  final String timeJoin;
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
              EdgeInsets.only(left: 2.h, right: 2.w, top: 1.h, bottom: 1.h),
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
                        'Sign :$signList',
                        style: s16f500ColorGreyTe,
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
                        timeJoin,
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
