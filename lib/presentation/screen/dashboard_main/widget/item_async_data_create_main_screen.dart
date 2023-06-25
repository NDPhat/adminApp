import 'package:flutter/material.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemAsyncDataCreatePageHome extends StatelessWidget {
  const ItemAsyncDataCreatePageHome({
    Key? key,
    required this.size,
    required this.textTitle,
    required this.signList,
    required this.childRight,
    required this.timeJoin,
    required this.onTap,
  }) : super(key: key);
  final Size size;
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
          padding: EdgeInsets.only(
              left: size.width * 0.02,
              right: size.width * 0.02,
              top: size.height * 0.01,
              bottom: size.height * 0.01),
          width: size.width * 0.9,
          height: size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textTitle,
                        style: s16f500ColorGreyTe,
                      ),
                    ),  Container(
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
                      height: size.height * 0.05,
                      child: Text(
                        timeJoin,
                        style: s12f400ColorGreyTe,
                      ),
                    ),
                    SizedBox(height: size.height * 0.13, child: childRight)
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
