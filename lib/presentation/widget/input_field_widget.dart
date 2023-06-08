import 'package:flutter/material.dart';

import '../../application/cons/color.dart';
import '../../application/cons/text_style.dart';
import 'input_field_container.dart';

class InputFieldWidget extends StatelessWidget {
  String? hintText;
  double width, height;
  String? validateText;
  bool? isHidden;
  Icon? icon;
  int? maxLength;
  Widget? iconRight;
  ValueChanged<String>? onChanged;
  bool? showValue;
  TextEditingController? controller;
  TextInputType? typeText;
  bool? readOnly;
  InputFieldWidget(
      {Key? key,
        this.hintText,
        required this.width,
        required this.height,
        this.validateText,
        this.isHidden,
        this.icon,
        this.readOnly,
        this.typeText,
        this.maxLength,
        this.onChanged,
        this.iconRight,
        this.controller,
        this.showValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputFieldContainer(
        width: width,
        height: height,
        validateText: validateText == null ? '' : validateText!,
        isHidden: isHidden == null ? false : isHidden!,
        child: TextField(
          readOnly: readOnly == null ? false : readOnly!,
          textInputAction: TextInputAction.next,
          style: s16f700ColorGreyTe,
          controller: controller != null ? controller : null,
          keyboardType: typeText == null ? null : typeText,
          maxLength: maxLength == null ? null : maxLength,
          obscureText: showValue ?? false,
          decoration: InputDecoration(
            prefixIcon: icon ?? null,
            labelText: hintText ?? "",
            counterText: "",
            suffixIcon: iconRight ?? null,
            fillColor: colorBGInput,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.black)),
            filled: true,
            contentPadding: const EdgeInsets.only(
                bottom: 40.0, left: 25.0, right: 15, top: 40),
          ),
          onChanged: onChanged,
        ));
  }
}
