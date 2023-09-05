import 'package:admin/presentation/screen/profile/widget/profile_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../data/local/authen/authen_repo.dart';
import '../../../data/local/models/user_global.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../../widget/bg_home_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
          onBack: () {
            Navigator.pushNamed(context, Routers.home);
          },
          textNow: 'profile'.tr().toString(),
          colorTextAndIcon: Colors.black,
          child: Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h),

                Stack(
                  children: [
                    Container(
                        width: 22.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(60)),
                            border: Border.all(color: colorSystemYeloow),
                            color: colorSystemWhite),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8), // Border radius
                            child: ClipOval(
                                child: Image.network(
                              instance.get<UserGlobal>().linkImage != null
                                  ? instance.get<UserGlobal>().linkImage!
                                  : "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: colorSystemYeloow),
                        child: const Icon(
                          LineAwesomeIcons.retro_camera,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text('Mr.P', style: Theme.of(context).textTheme.headline4),
                Text('Coding is my life',
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 3.h),

                /// -- MENU
                SingleChildScrollView(
                  child: ProfileItemWidget(
                    title: "my account".tr().toString(),
                    icon: LineAwesomeIcons.user_check,
                    onPress: () {
                      Navigator.pushNamed(context, Routers.updateProfile);
                    },
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ))),
    );
  }
}
