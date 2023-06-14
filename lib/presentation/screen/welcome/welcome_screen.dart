import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/constants.dart';
import '../../../data/local/authen/authen_repo.dart';
import '../../../data/local/models/user_global.dart';
import '../../../main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  void handleNavigationLoadApp() async {}
  @override
  Widget build(BuildContext context) {
    void handleNavigationLoadApp() async {
      bool isUserSignIn =
          await instance.get<AuthenRepository>().loadHandleAutoLoginApp();
      instance.get<UserGlobal>().onLogin = isUserSignIn;
      // lan dau login -->completeProfile
      if (isUserSignIn == true) {
        String email =
            await instance.get<AuthenRepository>().getMailHandleAutoLoginApp();
        await instance.get<TeacherAPIRepo>().getUserByEmail(email);
        Navigator.pushNamed(context, Routers.dashboard);
      } else {
        Navigator.pushNamed(context, Routers.login);
      }
    }

    return Scaffold(
      backgroundColor: colorSystemWhite,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 5,
              child: Center(
                child: Image.asset(
                  'assets/images/welcome/welcome.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Flexible(
              flex: 2,
              child: AnimatedTextKit(
                  onTap: () {
                    handleNavigationLoadApp();
                  },
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'TAP TO START',
                      textAlign: TextAlign.center,
                      textStyle: kAnimationTextStyle,
                      colors: kColorizeAnimationColors,
                    )
                  ],
                  repeatForever: true),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
