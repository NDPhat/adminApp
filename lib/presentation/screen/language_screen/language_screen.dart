import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/constants.dart';
import '../../../application/cons/text_style.dart';
import '../restart_app/restart_app_widget.dart';
import '../setting/widget/setting_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
        textNow: "language".tr().toString(),
        onPressHome: () {},
        colorTextAndIcon: Colors.black,
        child: Column(
          children: [
            sizedBox,
            SettingMenuWidget(
              title: "vietnamese".tr().toString(),
              widget: const Icon(
                LineAwesomeIcons.language,
                size: 30,
                color: colorSystemYeloow,
              ),
              textStyle: s16f700ColorGreyTe,
              onPress: () {
                setState(() {
                  Locale myLocale = Localizations.localeOf(context);
                  Locale localeSetting = const Locale("vi", "VI");
                  if (myLocale != localeSetting) {
                    context.setLocale(localeSetting);
                    RestartWidget.restartApp(context);
                  }
                });
              },
            ),
            sizedBox,
            SettingMenuWidget(
              title: "english".tr().toString(),
              widget: const Icon(
                LineAwesomeIcons.language,
                size: 30,
                color: colorSystemYeloow,
              ),
              textStyle: s16f700ColorGreyTe,
              onPress: () {
                Locale myLocale = Localizations.localeOf(context);
                Locale localeSetting = const Locale("en", "EN");
                if (myLocale != localeSetting) {
                  context.setLocale(localeSetting);
                  RestartWidget.restartApp(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
