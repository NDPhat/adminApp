import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../application/cons/color.dart';
import '../../application/cons/text_style.dart';

class InputFieldContainer extends StatelessWidget {
  final Widget child;
  final double width, height;
  final String? validateText;
  final bool? isHidden;
  final String? nameTitle;

  const InputFieldContainer({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
    this.validateText,
    this.nameTitle,
    this.isHidden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
            width: width,
            child: Text(
              nameTitle ?? "",
              style: s15f700ColorBlueMa,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: height, width: width, child: child),
          Visibility(
            visible: isHidden == null ? false : isHidden!,
            child: SizedBox(
              height: 2.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/login/error_validate.png")),
                  Text(
                    validateText ?? "",
                    style: s14f400ColorErrorPro,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
