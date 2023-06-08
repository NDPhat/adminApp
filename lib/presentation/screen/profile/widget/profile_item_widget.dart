import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../application/cons/color.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget(
      {Key? key,
        required this.title,
        required this.icon,
        required this.onPress,
        this.textColor,
        required this.size})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final Color? textColor;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? colorSystemYeloow : colorBlueQuaternery;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorSystemYeloow),
        ),
        width: size.width * 0.8,
        height: size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: iconColor.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: colorMainBlue),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.apply(color: textColor)),
                  ],
                )),
            const Icon(LineAwesomeIcons.angle_right,
                size: 30.0, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
