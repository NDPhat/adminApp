import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/local/models/on_board.dart';
import '../../navigation/routers.dart';
import '../../widget/rounded_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;
  final List<Onboard> listOnboard = <Onboard>[];

  String titlePageIntro1 = 'About teacher';
  String titlePageIntro2 = 'About math';
  String titlePageIntro3 = 'Our application';
  String bodyPageIntro1 =
      "A teacher's job is to take a bunch of live wires and see that they are well-grounded.";
  String bodyPageIntro2 =
      'Without mathematics,there’s nothing you can do.Everything around you is mathematics.Everything around you is numbers.';
  String bodyPageIntro3 = 'Our application fully meets these requirements.';
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    listOnboard.add(Onboard(
        "assets/images/intro/intro1.png", titlePageIntro1, bodyPageIntro1));
    listOnboard.add(Onboard(
        "assets/images/intro/intro2.png", titlePageIntro2, bodyPageIntro2));
    listOnboard.add(Onboard(
        "assets/images/intro/intro3.png", titlePageIntro3, bodyPageIntro3));
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: 7.h,
          left: 4.w,
          right: 4.w,
          bottom: 1.h,
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 5.5.w,
              ),
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: Text(
                  'skip'.tr().toString(),
                  style: s16f700ColorMainTealPri,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routers.welCome);
                },
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5.h),
                  height: 80.h,
                  width: 100.w,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: listOnboard.length,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) => IntroBody(
                            pathImage: listOnboard[index].pathImage,
                            title: listOnboard[index].title,
                            subtitle: listOnboard[index].bodyTitle,
                          )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      ...List.generate(
                          listOnboard.length,
                          (index) => Padding(
                                padding: EdgeInsets.only(
                                  right: 1.w,
                                ),
                                child: DotIndicator(
                                  isActive: index == _pageIndex,
                                ),
                              )),
                    ]),
                    RoundedButton(
                      press: () {
                        if (_pageIndex == 2) {
                          Navigator.pushNamed(context, Routers.welCome);
                        } else {
                          _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                      colorBorder: colorSystemYeloow,
                      color: colorSystemWhite,
                      width: 36.w,
                      height: 5.h,
                      child:
                          Text("go".tr().toString(), style: s16f700ColorSysYel),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 7.w : 5.w,
      height: 1.h,
      decoration: BoxDecoration(
          color: isActive ? colorWaringText : colorMainTealPri,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}

class IntroBody extends StatelessWidget {
  const IntroBody({
    Key? key,
    required this.pathImage,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String pathImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Center(
            child: Image.asset(
              pathImage,
              height: 35.h,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          width: 87.5.w,
          height: 8.h,
          child: Stack(
            children: [
              Container(
                height: 4.h,
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 1.7.h,
                  color: colorMainTealPri,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 4.h,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: colorWaringText,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorWaringText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
