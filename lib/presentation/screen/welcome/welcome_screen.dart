import 'package:admin/presentation/navigation/routers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  void handleNavigationLoadApp() async {

  }
  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, Routers.login);
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
