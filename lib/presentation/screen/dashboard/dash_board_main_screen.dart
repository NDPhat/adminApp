import 'package:admin/presentation/screen/dashboard/widget/body_dash_board.dart';
import 'package:admin/presentation/screen/dashboard/widget/bottom_app_icon.dart';
import 'package:flutter/material.dart';
import '../../../application/cons/color.dart';

class DashBoardMainScreen extends StatefulWidget {
  const DashBoardMainScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardMainScreen> createState() => DashBoardMainScreenState();
}

class DashBoardMainScreenState extends State<DashBoardMainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageController _myPage = PageController(initialPage: 0);
    return Scaffold(
      backgroundColor: colorSystemWhite,
      body: BodyDashBoard(
        myPage: _myPage,
        size: size,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: BottomAppIcon(
                pathImage: "assets/images/dashboard/home.png",
                text: 'Home',
                size: size,
                color: _selectedIndex == 0 ? colorMainBlue : colorGrayBG,
              ),
              onTap: () {
                _onItemTapped(0);
                _myPage.jumpToPage(0);
              },
            ),
            GestureDetector(
              child: BottomAppIcon(
                  pathImage: "assets/images/dashboard/create.png",
                  text: 'Create',
                  size: size,
                  color: _selectedIndex == 1 ? colorMainBlue : colorGrayBG),
              onTap: () {
                _onItemTapped(1);
                _myPage.jumpToPage(1);
              },
            ),
            GestureDetector(
              child: BottomAppIcon(
                  pathImage: "assets/images/dashboard/mark.png",
                  text: 'Mark',
                  size: size,
                  color: _selectedIndex == 2 ? colorMainBlue : colorGrayBG),
              onTap: () {
                _onItemTapped(2);
                _myPage.jumpToPage(2);
              },
            ),
            GestureDetector(
              child: BottomAppIcon(
                  pathImage: "assets/images/dashboard/profile.png",
                  text: 'Profile',
                  size: size,
                  color: _selectedIndex == 3 ? colorMainBlue : colorGrayBG),
              onTap: () {
                _onItemTapped(3);
                _myPage.jumpToPage(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
