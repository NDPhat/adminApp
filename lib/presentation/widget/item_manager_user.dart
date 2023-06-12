import 'package:admin/application/cons/color.dart';
import 'package:admin/application/cons/text_style.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ItemManagerUser extends StatelessWidget {
  const ItemManagerUser(
      {Key? key, required this.size, required this.lop, required this.ten, required this.onTap})
      : super(key: key);
  final Size size;
  final String lop, ten;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: colorErrorPrimary,
        child: SizedBox(
          height: size.height * 0.15,
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: Column(
                  children: [
                    Image.asset("assets/images/icon_app.png"),
                    Text(
                      lop,
                      style: s16f500ColorSysWhite,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: const Divider(
                    color: colorSystemWhite,
                    height: 50,
                    thickness: 2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.3,
                child: Text(
                  ten,
                  style: s16f500ColorSysWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
