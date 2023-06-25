import 'package:flutter/material.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';

class ItemDetailRSHWMainScreen extends StatelessWidget {
  const ItemDetailRSHWMainScreen({
    Key? key,
    required this.size,
    required this.week,
    required this.name,
    required this.childRight,
  }) : super(key: key);
  final Size size;
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
                children: [
                  SizedBox(height: size.height * 0.18, child: childRight)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
