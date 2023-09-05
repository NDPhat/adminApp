import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../data/local/authen/authen_repo.dart';
import '../../../data/local/models/user_global.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handleNavigationLoadApp();
  }

  void handleNavigationLoadApp() async {
    bool isUsing =
        await instance.get<AuthenRepository>().loadHandleFirstTimeUsingApp();
    bool isUserSignIn =
        await instance.get<AuthenRepository>().loadHandleAutoLoginApp();

    //first time install app
    if (isUsing == false) {
      instance.get<AuthenRepository>().handleFirstTimeUsingApp(true);
      Navigator.pushNamed(context, Routers.intro);
    }
    // da tung xai app bo qua intro
    else {
      //handle auto log in
      instance.get<UserGlobal>().onLogin = isUserSignIn;
      //user login
      if (isUserSignIn == true) {
        String email =
            await instance.get<AuthenRepository>().getMailHandleAutoLoginApp();
        await instance.get<TeacherAPIRepo>().getUserByEmail(email);
        Navigator.pushNamed(context, Routers.home);
      } else {
        Navigator.pushNamed(context, Routers.welCome);
      }
      // user local
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        "assets/images/queen_bee_logo.png",
        height: 40.h,
        fit: BoxFit.cover,
      ),
    ));
  }
}
