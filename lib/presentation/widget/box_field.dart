import 'package:flutter/material.dart';

import '../../application/cons/color.dart';
import 'box_container.dart';

class BoxField extends StatelessWidget {
  String hintText;
  String nameTitle;
  double size;
  Icon icon;
  final VoidCallback onTapped;
  BoxField(
      {Key? key,
        required this.hintText,
        required this.nameTitle,
        required this.size,
        required this.icon,
        required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapped,
        child: BoxFieldContainer(
          size: size,
          nameTitle: nameTitle,
          child: Container(
            padding:
            EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 10),
            decoration: BoxDecoration(
                border: Border.all(color: colorGreyTetiary),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(hintText),
                ),
                icon
              ],
            ),
          ),
        ));
  }
}
