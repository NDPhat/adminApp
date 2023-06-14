import 'package:admin/presentation/screen/profile/widget/profile_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../application/cons/color.dart';
import '../../../data/local/authen/authen_repo.dart';
import '../../../data/local/models/user_global.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../../widget/bg_home_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.size});
  Size size;

  @override
  Widget build(BuildContext context) {
    return BGHomeScreen(
        textNow: 'Profile',
        size: size,
        child: Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: size.width * 0.22,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          border: Border.all(color: colorSystemYeloow),
                          color: colorSystemWhite),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8), // Border radius
                          child: ClipOval(
                              child: Image.asset(
                            "assets/images/dashboard/profile.png",
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
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
              SizedBox(height: size.height * 0.01),
              Text('Mr.P', style: Theme.of(context).textTheme.headline4),
              Text('Coding is my life',
                  style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: size.height * 0.02),

              /// -- MENU
              SingleChildScrollView(
                child: ProfileItemWidget(
                  title: "My account",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {},
                  size: size,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              ProfileItemWidget(
                title: "Setting",
                icon: LineAwesomeIcons.cog,
                onPress: () {},
                size: size,
              ),
              SizedBox(height: size.height * 0.02),

              ProfileItemWidget(
                title: "Local Notification",
                icon: LineAwesomeIcons.bell,
                onPress: () {},
                size: size,
              ),
              SizedBox(height: size.height * 0.02),
              ProfileItemWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                onPress: () {
                  instance.get<AuthenRepository>().handleAutoLoginApp(false);
                  instance.get<AuthenRepository>().handleMailLoginApp("");
                  instance.get<UserGlobal>().onLogin = false;
                  Navigator.pushNamed(context, Routers.welCome);
                },
                size: size,
              ),
            ],
          ),
        )));
  }
}
