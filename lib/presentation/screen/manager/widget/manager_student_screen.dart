import 'dart:math';

import 'package:admin/application/cons/constants.dart';
import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/models/user_res_with_pagi.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../main.dart';
import '../../../widget/item_manager_user.dart';
import 'dot_page_indicator.dart';
import 'indicator.dart';

class ManagerStudentScreen extends StatefulWidget {
  const ManagerStudentScreen({Key? key}) : super(key: key);

  @override
  State<ManagerStudentScreen> createState() => _ManagerStudentScreenState();
}

class _ManagerStudentScreenState extends State<ManagerStudentScreen> {
  int page = 1;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  List<UserResPagiModel>? posts = [];
  List<UserResPagiModel>? searchPosts = [];
  UserResPagiAPI? data;
  int length = 1;

  @override
  void initState() {
    firstLoad();
    searchPosts = posts;
    super.initState();
  }

  void getMore() async {
    posts!.clear();
    data = await instance.get<TeacherAPIRepo>().getAllStudentByClassWithPagi(
        instance.get<UserGlobal>().lop.toString(), page);
    final List<UserResPagiModel>? fetchedPosts = data!.data;
    if (fetchedPosts!.isNotEmpty) {
      setState(() {
        posts!.addAll(fetchedPosts);
      });
    } else {
      setState(() {
        hasNextPage = false;
      });
    }
  }

  void firstLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    data = await instance.get<TeacherAPIRepo>().getAllStudentByClassWithPagi(
        instance.get<UserGlobal>().lop.toString(), page);
    final List<UserResPagiModel>? fetchedPosts = data!.data;
    length = data!.total!;
    if (length % 5 > 0) {
      length = length ~/ 5 + 1;
    } else {
      length = length ~/ 5;
    }
    if (fetchedPosts!.isNotEmpty) {
      setState(() {
        posts!.addAll(fetchedPosts);
      });
    }
    //search list
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void onSearchChanged(String value) {
    List<UserResPagiModel>? results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = posts;
    } else {
      results = posts!
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      searchPosts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGHomeScreen(
        textNow: "Manager student",
        colorTextAndIcon: Colors.black,
        child: Column(
          children: [
            SizedBox(
              width: 90.w,
              height: 10.h,
              child: TextField(
                style: s16f700ColorGreyTe,
                decoration: InputDecoration(
                  label: Text(
                    "search".tr().toString(),
                    style: GoogleFonts.aBeeZee(
                        color: colorGreyTetiary, fontSize: 16),
                  ),
                  suffixIcon: const Icon(
                    LineAwesomeIcons.search,
                    size: 30,
                    color: colorGrayBG,
                  ),
                ),
                onChanged: (value) {
                  onSearchChanged(value);
                },
              ),
            ),
            SizedBox(
              height: 70.h,
              child: isFirstLoadRunning
                  ? SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: colorMainBlue,
                          strokeWidth: 5,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 70.h,
                      width: 90.w,
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: searchPosts!.length,
                                  (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: 0.5.h, top: 0.5.h),
                              child: ItemManagerUser(
                                  lop: searchPosts![index].lop!,
                                  ten: searchPosts![index].name!,
                                  onTap: () {},
                                  imageLink: "https://i.imgur.com/sWlI9RJ.jpg",
                                  colorBorder: Colors.teal),
                            );
                          }))
                        ],
                      ),
                    ),
            ),
            sizedBox,
            Container(
              padding: EdgeInsets.only(right: 5.w),
              width: 100.w,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                DotPageIndicator(
                  colorBorder: colorMainBlue,
                  icon: SvgPicture.asset(
                    "assets/icon/back.svg",
                    color: colorMainBlue,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    if (page == 1) {
                    } else {
                      setState(() {
                        page--;
                        getMore();
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 2.w,
                ),
                DotIndicator(
                  colorBorder: colorErrorPrimary,
                  pageIndex: page.toString(),
                ),
                SizedBox(
                  width: 2.w,
                ),
                DotPageIndicator(
                  colorBorder: colorMainBlue,
                  icon: SvgPicture.asset(
                    "assets/icon/next.svg",
                    color: colorMainBlue,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    if (page < length) {
                      setState(() {
                        page++;
                        getMore();
                      });
                    }
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
