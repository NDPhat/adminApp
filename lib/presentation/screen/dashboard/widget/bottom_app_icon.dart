
import 'package:flutter/material.dart';

import '../../../../application/cons/color.dart';

class BottomAppIcon extends StatelessWidget {
  const BottomAppIcon({Key? key,
    required this.pathImage,
    required this.text,
    required this.size, required this.color,
  })
      : super(key: key);
  final Size size;
  final String pathImage;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 4,
      height:size.height * 0.06,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding:  EdgeInsets.only(top:size.height*0.01),
            child: Image.asset(
              pathImage,
              height: size.height*0.03,
              color:color,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
