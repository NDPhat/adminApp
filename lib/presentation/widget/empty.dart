import 'package:admin/application/cons/color.dart';
import 'package:admin/application/cons/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorSystemWhite,
          border: Border.all(color:colorBGInput)
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("empty data".tr().trim(),style: s20f700ColorMBlue),
        ),
      ),
    );
  }
}