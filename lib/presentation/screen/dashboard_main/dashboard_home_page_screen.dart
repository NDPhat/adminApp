import 'package:flutter/material.dart';

import '../../../application/cons/text_style.dart';
import '../../widget/bg_home_screen.dart';

class DashBoardHomePageScreen extends StatelessWidget {
  DashBoardHomePageScreen({Key? key, required this.size});
  Size size;

  @override
  Widget build(BuildContext context) {
    return BGHomeScreen(
        textNow: 'Home',
        size: size,
        child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: size.height * 0.01),
                          padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              bottom: size.height * 0.02,
                              right: size.height * 0.03,
                              left: size.height * 0.03),
                          height: size.height * 0.2,
                          width: size.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  AssetImage("assets/images/home_page/bg_card_home.png"),
                                  fit: BoxFit.fill)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Always remember :",
                                      style: s18f700ColorWhiteSys)),
                              Container(
                                  padding: EdgeInsets.only(top: size.height * 0.02),
                                  width: size.width,
                                  child: const Text("Teaching is more than imparting knowledge.\nit is inspiring change.\n"
                                      "Learning is more than absorbing facts.\nIt is acquiring understanding.",
                                      style: s14f500colorSysWhite)),
                            ],
                          )),
                      LineContentItem(
                        size: size,
                        title: 'Home works',
                        icon: const Icon(Icons.book),
                      ),
                      LineContentItem(
                        size: size,
                        title: 'Practices',
                        icon: const Icon(Icons.dashboard),
                      ),

                    ],
                  ),
                ],
              ),
            )));
  }
}

class LineContentItem extends StatelessWidget {
  const LineContentItem({
    super.key,
    required this.size,
    required this.title,
    required this.icon,
  });

  final Size size;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(top: size.height * 0.01),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: s18f700ColorGreyPri,
          ),
          icon
        ],
      ),
    );
  }
}
