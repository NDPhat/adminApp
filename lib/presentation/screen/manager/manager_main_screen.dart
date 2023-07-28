import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/event_local/update_pre_now.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../../widget/line_content_item_widget.dart';

class ManagerMainScreen extends StatelessWidget {
  const ManagerMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> showPreViewDialog(PreHWResModel data) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              25,
            )),
            backgroundColor: const Color(0xff1542bf),
            title: const FittedBox(
              child: Text('REVIEW YOUR PRE HOME WORK?',
                  textAlign: TextAlign.center, style: s30f700colorSysWhite),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, Routers.detailPre,
                      arguments: data);
                },
                child: const Text('GO', style: s16f700ColorError),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('EXIT', style: s15f700ColorYellow),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: BGHomeScreen(
          textNow: 'manager'.tr().toString(),
          colorTextAndIcon: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(
              children: [
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
                          "Lop ${instance.get<UserGlobal>().lop}",
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
                SingleChildScrollView(
                  child: SizedBox(
                    height: 30.h,
                    child: FutureBuilder<List<PreHWResModel>?>(
                        future:
                            instance.get<TeacherAPIRepo>().getALlDonePreHW(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: 30.w,
                              width: 30.h,
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
                                snapshot.data!
                                    .sort((a, b) => a.week!.compareTo(b.week!));
                                return ItemCard(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routers.detailAllResultHW,
                                        arguments: snapshot.data![index].week);
                                  },
                                  colorBorder: colorErrorPrimary,
                                  childRight: Center(
                                      child: Text(
                                    'done'.tr().toString(),
                                    style: GoogleFonts.aboreto(
                                        color: colorErrorPrimary, fontSize: 20),
                                  )),
                                  childCenter: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${"week".tr()} ${snapshot.data![index].week}",
                                        style: GoogleFonts.aboreto(
                                            color: colorErrorPrimary,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        "SIGN : ${snapshot.data![index].sign}",
                                        style: GoogleFonts.aboreto(
                                            color: colorErrorPrimary,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }

                          return Container();
                        }),
                  ),
                ),
                LineContentItem(
                    colorBG: colorMainBlue,
                    title: 'create'.tr().toString(),
                    icon: const Icon(Icons.home_work)),
                const LineContentItem(
                    colorBG: colorErrorPrimary,
                    title: 'ON SCHEDULE',
                    icon: Icon(LineAwesomeIcons.school)),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 15.h,
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
                                      "WEEK ${snapshot.data![index].week}",
                                      style: s16f500ColorSysWhite,
                                    ),
                                    onTap: () {
                                      showPreViewDialog(snapshot.data![index]);
                                    },
                                    childRight: Text(
                                      "${snapshot.data![index].status}",
                                      style: s16f500ColorSysWhite,
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
