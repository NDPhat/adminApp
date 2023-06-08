import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../application/cons/text_style.dart';

class BGHomeScreen extends StatelessWidget {
  BGHomeScreen(
      {Key? key,
        required this.child,
        required this.textNow,
        required this.size})
      : super(key: key);
  Widget child;
  String textNow;
  Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.75,
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.1),
                  child: Image.asset(
                    "assets/images/icon_app.png",
                  ),
                ),
                Text(textNow, style: s26f700ColorGreyPri),
              ]),
            ),

          ],
        ),
        child
      ],
    );
  }
}
