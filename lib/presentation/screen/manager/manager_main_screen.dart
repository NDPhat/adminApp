import 'package:admin/application/cons/constants.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/screen/manager/widget/dot_page_indicator.dart';
import 'package:admin/presentation/screen/manager/widget/indicator.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/event_local/update_pre_now.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../data/remote/models/pre_hw_res_pagi.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../../widget/line_content_item_widget.dart';

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({Key? key}) : super(key: key);
  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  int page = 1;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  int length = 1;
  List<PreHWResModel>? posts = [];
  PreHWResPagiAPI? data;

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

  void getMore() async {
    posts!.clear();
    data = await instance.get<TeacherAPIRepo>().getALlDonePreHWWithPagi(page);
    final List<PreHWResModel>? fetchedPosts = data!.data;
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
    data = await instance.get<TeacherAPIRepo>().getALlDonePreHWWithPagi(page);
    final List<PreHWResModel>? fetchedPosts = data!.data;
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

  @override
  Widget build(BuildContext context) {
    Future<void> showPreHWDialog(PreHWResModel data) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'review this week home work'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.pushNamed(context, Routers.detailPre, arguments: data);
        },
      ).show();
    }

    return Scaffold(
      body: BGHomeScreen(
          onBack: () {
            Navigator.pushNamed(context, Routers.home);
          },
          textNow: 'management'.tr().toString(),
          colorTextAndIcon: Colors.black,
          child: Container(
            height: 90.h,
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(
              children: [
                ///LINE
                LineContentItem(
                  title: 'student'.tr().toString(),
                  icon: const Icon(LineAwesomeIcons.user),
                  colorBG: colorMainBlue,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routers.managerUser);
                    },
                    child: Container(
                      width: 100.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorMainBlue),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          "${"class".tr()} ${instance.get<UserGlobal>().lop}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              color: colorMainBlue, fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                LineContentItem(
                    colorBG: colorErrorPrimary,
                    title: 'home work'.tr().toString(),
                    icon: const Icon(Icons.home_work)),
                SizedBox(
                    height: 28.h,
                    child: isFirstLoadRunning
                        ? SizedBox(
                            height: 25.h,
                            width: 25.w,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: colorMainBlue,
                                strokeWidth: 5,
                              ),
                            ),
                          )
                        : CustomScrollView(slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              childCount: posts!.length,
                              (context, index) {
                                posts!
                                    .sort((a, b) => a.week!.compareTo(b.week!));
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, bottom: 0.5.h),
                                  child: ItemCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routers.detailAllResultHW,
                                          arguments: posts![index].week);
                                    },
                                    colorBorder: colorErrorPrimary,
                                    childRight: Center(
                                        child: Text(
                                      'done'.tr().toString(),
                                      style: GoogleFonts.aboreto(
                                          color: colorErrorPrimary,
                                          fontSize: 20),
                                    )),
                                    childCenter: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${"week".tr()} ${posts![index].week}",
                                          style: GoogleFonts.aboreto(
                                              color: colorErrorPrimary,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "${"sign".tr()} : ${posts![index].sign}",
                                          style: GoogleFonts.aboreto(
                                              color: colorErrorPrimary,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))
                          ])),
                Container(
                  height: 4.h,
                  padding: EdgeInsets.only(right: 5.w),
                  width: 100.w,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      totalPage: length.toString(),
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
                ),
                sizedBox,
                LineContentItem(
                    colorBG: colorMainBlue,
                    title: "on schedule".tr(),
                    icon: const Icon(Icons.school)),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 25.h,
                      width: 90.w,
                      child: FutureBuilder<List<PreHWResModel>?>(
                          future:
                              instance.get<TeacherAPIRepo>().getOnGoingPreHW(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 10.h,
                                width: 50.w,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: colorMainBlue,
                                    strokeWidth: 5,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  // update thong tin pre global
                                  PreEventLocal.updatePreGlobal(
                                      snapshot.data![index]);
                                  return ItemCard(
                                    colorBorder:
                                        findColor(snapshot.data![index].color!),
                                    childCenter: Text(
                                      "${"week".tr()} ${snapshot.data![index].week}",
                                      style: GoogleFonts.aboreto(
                                          color: findColor(
                                              snapshot.data![index].color!),
                                          fontSize: 20),
                                    ),
                                    onTap: () {
                                      showPreHWDialog(snapshot.data![index]);
                                    },
                                    childRight: Text(
                                      "${snapshot.data![index].status}",
                                      style: GoogleFonts.aboreto(
                                          color: findColor(
                                              snapshot.data![index].color!),
                                          fontSize: 20),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          })),
                ),
              ],
            ),
          )),
    );
  }
}
