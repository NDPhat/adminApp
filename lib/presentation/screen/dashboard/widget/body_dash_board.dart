import 'package:admin/presentation/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../create/create_main_screen.dart';
import '../../dashboard_main/dashboard_home_page_screen.dart';
import '../../manager/manager_main_screen.dart';

class BodyDashBoard extends StatelessWidget {
  BodyDashBoard({Key? key, required this.myPage, required this.size})
      : super(key: key);
  final PageController myPage;
  Size size;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.height * 0.05),
      child: PageView(
          controller: myPage,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            DashBoardHomePageScreen(
              size: size,
            ),
            CreateMainScreen(size: size),
            ManagerMainScreen(size: size),
            ProfileScreen(size: size)
          ]),
    ); // Comment this if you need to use Swipe.
  }
}
