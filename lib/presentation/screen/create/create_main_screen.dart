import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/event_local/update_pre_now.dart';
import '../../../main.dart';
import '../../widget/rounded_button.dart';
import '../dashboard_main/dashboard_home_page_screen.dart';

class CreateMainScreen extends StatelessWidget {
  CreateMainScreen({Key? key, required this.size}) : super(key: key);
  final Size size;
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

    Future<void> showExpiredDateDialog(PreHWResModel data) {
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
              child: Text('YOUR PRE HOME WORK EXPIRED.ONLY READ!!',
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

    return BGHomeScreen(
      textNow: 'Create',
      size: size,
      child: Column(
        children: [
          LineContentItem(
              size: size,
              title: 'User',
              icon: const Icon(LineAwesomeIcons.user)),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
            width: size.width,
            child: Center(
              child: RoundedButton(
                  press: () async {
                    Navigator.pushNamed(context, Routers.createUser);
                  },
                  color: colorMainBlue,
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  child: const Text(
                    'CREATE',
                    style: s30f500colorSysWhite,
                  )),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: 1,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: colorGrayBG),
              ),
            ),
          ),
          LineContentItem(
              size: size,
              title: 'HOME WORK',
              icon: const Icon(Icons.home_work)),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
            width: size.width,
            child: Center(
              child: RoundedButton(
                  press: () async {
                    Navigator.pushNamed(context, Routers.createPre);
                  },
                  color: colorMainBlue,
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  child: const Text(
                    'CREATE',
                    style: s30f500colorSysWhite,
                  )),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          LineContentItem(
              size: size,
              title: 'ON SCHEDULE',
              icon: const Icon(LineAwesomeIcons.school)),
          SingleChildScrollView(
            child: SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.9,
                child: FutureBuilder<List<PreHWResModel>?>(
                    future: instance.get<TeacherAPIRepo>().getOnGoingPreHW(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: size.height * 0.1,
                          width: size.width * 0.5,
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
                              size: size,
                              backgroundColor:
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
          LineContentItem(
              size: size,
              title: 'HISTORY',
              icon: const Icon(LineAwesomeIcons.history)),
          SingleChildScrollView(
            child: SizedBox(
                height: size.height * 0.25,
                width: size.width * 0.9,
                child: FutureBuilder<List<PreHWResModel>?>(
                    future: instance.get<TeacherAPIRepo>().getALlDonePreHW(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: size.height * 0.1,
                          width: size.width * 0.5,
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
                              size: size,
                              backgroundColor:
                                  findColor(snapshot.data![index].color!),
                              childCenter: Text(
                                "WEEK ${snapshot.data![index].week}",
                                style: s16f500ColorSysWhite,
                              ),
                              onTap: () {
                                showExpiredDateDialog(snapshot.data![index]);
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
    );
  }
}
