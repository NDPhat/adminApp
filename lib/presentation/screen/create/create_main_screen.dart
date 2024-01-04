import 'package:admin/data/event_local/update_pre_now.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/api/api/pre_hw_repo.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../main.dart';
import '../../widget/bg_listview_item.dart';
import '../../widget/rounded_button.dart';

class CreateMainScreen extends StatelessWidget {
  const CreateMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> showPreHWDialog(PreHWAPIModel data) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'review this week home work'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.pushNamed(context, Routers.detailPre, arguments: data);
        },
      ).show();
    }

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
                height: 25.h,
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
                        height: 15.h,
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
                height: 50.h,
                content: 'home work'.tr(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: RoundedButton(
                            press: () async {
                              Navigator.pushNamed(context, Routers.createPre);
                            },
                            color: colorSystemWhite,
                            colorBorder: colorMainTealPri,
                            width: 80.w,
                            height: 15.h,
                            child: Text(
                              'create'.tr(),
                              style: s20GgBarColorMainTeal,
                            )),
                      ),
                      FutureBuilder<List<PreHWAPIModel>?>(
                          future: instance
                              .get<PreHWAPIRepo>()
                              .getOnGoingPreHW(instance.get<UserGlobal>().lop!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 5.h,
                                width: 50.w,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: colorMainBlue,
                                    strokeWidth: 5,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData != null && snapshot.data!.isNotEmpty) {
                              return RoundedButton(
                                  press: () async {
                                    PreEventLocal.updatePreGlobal(snapshot.data!.first);
                                    showPreHWDialog(snapshot.data!.first);
                                  },
                                  color: colorSystemWhite,
                                  colorBorder: colorMainTealPri,
                                  width: 80.w,
                                  height: 15.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'update'.tr(),
                                        style: s20GgBarColorMainTeal,
                                      ),
                                      Text(
                                          "${"week".tr()} ${snapshot.data!.first.week}",
                                          style: s20GgBarColorMainTeal),
                                    ],
                                  ));
                            }
                            return Container();
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
