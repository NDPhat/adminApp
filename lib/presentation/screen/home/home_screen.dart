import 'package:admin/presentation/screen/home/widget/teacher_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/constants.dart';

import '../../../../main.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/authen/authen_repo.dart';
import '../../navigation/routers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSystemYeloow,
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            width: 100.w,
            height: 40.h,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TeacherName(),
                    TeacherPicture(
                      picAddress: 'assets/images/profile.png',
                    ),
                  ],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TeacherDataCard(
                      title: 'class'.tr(),
                      value: instance.get<UserGlobal>().lop!,
                    ),
                    TeacherDataCard(
                      title: 'year'.tr(),
                      value: '2023-2024',
                    ),
                  ],
                )
              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              width: 100.w,
              decoration: const BoxDecoration(
                color: colorSystemWhite,
                borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    kHalfSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          colorBorder: colorSystemPurple,
                          onPress: () {
                            Navigator.pushNamed(
                                context, Routers.createMainScreen);
                          },
                          icon: 'assets/icon/quiz.svg',
                          title: 'create'.tr().toString(),
                        ),
                        HomeCard(
                          colorBorder: colorMainTealPri,
                          onPress: () {
                            Navigator.pushNamed(
                                context, Routers.managerMainScreen);
                          },
                          icon: 'assets/icon/gallery.svg',
                          title: 'management'.tr().toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          colorBorder: colorWaringText,
                          onPress: () {
                            Navigator.pushNamed(context, Routers.dashboard);
                          },
                          icon: 'assets/icon/datesheet.svg',
                          title: 'data sheet'.tr().toString(),
                        ),
                        HomeCard(
                          colorBorder: colorMainBlue,
                          onPress: () {
                            Navigator.pushNamed(context, Routers.profile);
                          },
                          icon: 'assets/icon/resume.svg',
                          title: 'profile'.tr().toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          colorBorder: colorSystemYeloow,
                          onPress: () {
                            Navigator.pushNamed(context, Routers.setting);
                          },
                          icon: 'assets/icon/event.svg',
                          title: 'setting'.tr().toString(),
                        ),
                        HomeCard(
                          colorBorder: colorErrorPrimary,
                          onPress: () {
                            instance
                                .get<AuthenRepository>()
                                .handleAutoLoginApp(false);
                            instance.get<UserGlobal>().onLogin = false;
                            Navigator.pushNamed(context, Routers.welCome);
                          },
                          icon: 'assets/icon/logout.svg',
                          title: 'logout'.tr().toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.colorBorder})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  final Color colorBorder;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 15.h,
        decoration: BoxDecoration(
          color: colorSystemWhite,
          border: Border.all(color: colorBorder),
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: colorBorder,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: colorBorder,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
