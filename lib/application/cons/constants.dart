import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const kColorizeAnimationColors = [
  Colors.lightGreenAccent,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.cyanAccent,
];

const kGradientColors = [Color(0xff1542bf), Color(0xff51a8ff)];

const kAnimationTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Lobster',
);

const kTimerTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 36,
  fontFamily: 'Lobster',
);

const KTapToStartTextStyle = TextStyle(fontSize: 25, color: Colors.white);

const kScoreLabelTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.orangeAccent,
  fontFamily: 'Press_Start_2P',
);

const kScoreIndicatorTextStyle = TextStyle(
  fontSize: 42,
  color: Colors.black,
  fontFamily: 'Chakra_Petch',
  fontWeight: FontWeight.bold,
);

const kQuizTextStyle = TextStyle(
  fontSize: 30,
  color: Colors.white60,
  fontWeight: FontWeight.bold,
);

const kButtonTextStyle = TextStyle(
  fontSize: 40,
  fontFamily: 'Press_Start_2P',
);

const kTitleTS = TextStyle(
  fontSize: 32,
  color: Colors.orangeAccent,
  fontFamily: 'Press_Start_2P',
);
const kTitleTSBold = TextStyle(
    fontSize: 44,
    color: Colors.blueAccent,
    fontFamily: 'Press_Start_2P',
    fontWeight: FontWeight.bold);
const kTitleTSBold1 = TextStyle(
    fontSize: 44,
    color: Colors.orangeAccent,
    fontFamily: 'Press_Start_2P',
    fontWeight: FontWeight.bold);
const kTitleTSBold2 = TextStyle(
    fontSize: 44,
    color: Colors.redAccent,
    fontFamily: 'Press_Start_2P',
    fontWeight: FontWeight.bold);

const kContentTS = TextStyle(
  fontSize: 24,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kDialogButtonsTS = TextStyle(
  fontSize: 18,
  color: Colors.white60,
);

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

const kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight:
      Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  bottomLeft:
      Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);


//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
