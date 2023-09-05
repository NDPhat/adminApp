import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../widget/bg_listview_item.dart';
import '../../widget/line_content_item_widget.dart';
import '../../widget/rounded_button.dart';

class CreateMainScreen extends StatelessWidget {
  const CreateMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
        onBack: () {
          Navigator.pushNamed(context, Routers.home);
        },
        textNow: 'create'.tr(),
        colorTextAndIcon: Colors.black,
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
          child: Column(
            children: [
              BackGroundListView(
                colorBG: colorErrorPrimary,
                width: 90.w,
                height: 35.h,
                content: 'student'.tr(),
                child: SizedBox(
                  width: 100.w,
                  child: Center(
                    child: RoundedButton(
                        press: () async {
                          Navigator.pushNamed(context, Routers.createUser);
                        },
                        color: colorSystemWhite,
                        colorBorder: colorErrorPrimary,
                        width: 80.w,
                        height: 14.h,
                        child: Text(
                          'create'.tr(),
                          style: s20GgBarColorErrorPri,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BackGroundListView(
                colorBG: colorMainTealPri,
                width: 90.w,
                height: 35.h,
                content: 'home work'.tr(),
                child: Center(
                  child: RoundedButton(
                      press: () async {
                        Navigator.pushNamed(context, Routers.createPre);
                      },
                      color: colorSystemWhite,
                      colorBorder: colorMainTealPri,
                      width: 80.w,
                      height: 14.h,
                      child: Text(
                        'create'.tr(),
                        style: s20GgBarColorMainTeal,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
