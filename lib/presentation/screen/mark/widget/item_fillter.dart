import 'package:admin/application/cons/color.dart';
import 'package:admin/application/cons/text_style.dart';
import 'package:flutter/material.dart';

class ItemFillter extends StatelessWidget {
  ItemFillter(
      {Key? key,
      required this.size,
      required this.name,
      required this.onTap,
      required this.onChoose})
      : super(key: key);
  final Size size;
  final String name;
  bool onChoose = false;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width * 0.2,
        height: size.height * 0.05,
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
