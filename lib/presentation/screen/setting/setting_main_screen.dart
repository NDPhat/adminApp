import 'package:admin/presentation/screen/setting/widget/setting_widget.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../navigation/routers.dart';

class SettingMainScreen extends StatelessWidget {
  const SettingMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
        onBack: () {
          Navigator.pushNamed(context, Routers.home);
        },
        colorTextAndIcon: Colors.black,
        textNow: 'setting'.tr().toString(),
        onPressHome: () {},
        child: Column(
          children: [
            SizedBox(height: 5.h),
            SettingMenuWidget(
              title: "local notification".tr().toString(),
              widget: const Icon(
                LineAwesomeIcons.bell,
                size: 30,
                color: colorErrorPrimary,
              ),
              onPress: () {
                Navigator.pushNamed(context, Routers.notifyMainScreen);
              },
              textStyle: s16f700ColorGreyTe,
            ),
            SizedBox(height: 5.h),
            SettingMenuWidget(
              title: "language".tr().toString(),
              widget: const Icon(
                LineAwesomeIcons.language,
                size: 30,
                color: colorMainBlue,
              ),
              onPress: () {
                Navigator.pushNamed(context, Routers.language);
              },
              textStyle: s16f700ColorGreyTe,
            )
          ],
        ),
      ),
    );
  }
}
