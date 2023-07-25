import 'package:admin/presentation/screen/home/widget/teacher_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/constants.dart';

import '../../../../main.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/local/authen/authen_repo.dart';
import '../../../data/local/models/user_global.dart';
import '../../navigation/routers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBlueChart,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TeacherName(),
                        kHalfSizedBox,
                        Row(
                          children: [
                            TeacherClass(teacherClass: 'Class 1A'),
                            kHalfSizedBox,
                            TeacherYear(teacherYear: '2023-2024'),
                          ],
                        )
                      ],
                    ),
                    kHalfSizedBox,
                    TeacherPicture(
                      picAddress: 'assets/images/profile.png',
                    ),
                  ],
                ),
                sizedBox,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TeacherDataCard(
                      title: 'Attendance',
                      value: '90.02%',
                    ),
                    TeacherDataCard(
                      title: 'Score',
                      value: 'B',
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
                          onPress: () {
                            Navigator.pushNamed(
                                context, Routers.createMainScreen);
                          },
                          icon: 'assets/icon/quiz.svg',
                          title: 'create'.tr().toString(),
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, Routers.managerMainScreen);
                          },
                          icon: 'assets/icon/gallery.svg',
                          title: 'manager'.tr().toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, Routers.dashboard);
                          },
                          icon: 'assets/icon/datesheet.svg',
                          title: 'data sheet'.tr().toString(),
                        ),
                        HomeCard(
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
                          onPress: () {
                            Navigator.pushNamed(context, Routers.setting);
                          },
                          icon: 'assets/icon/event.svg',
                          title: 'setting'.tr().toString(),
                        ),
                        HomeCard(
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
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 15.h,
        decoration: BoxDecoration(
          color: colorMainBlueChart,
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
              color: colorSystemWhite,
            ),
            Text(title,
                textAlign: TextAlign.center, style: s14f500colorSysWhite),
          ],
        ),
      ),
    );
  }
}
