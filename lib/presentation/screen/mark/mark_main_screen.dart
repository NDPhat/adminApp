import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:flutter/material.dart';

import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../data/remote/models/result_hw_res.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../dashboard_main/dashboard_home_page_screen.dart';

class MarkMainScreen extends StatelessWidget {
  const MarkMainScreen({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    Future<void> showDetailResultHWDialog(PreHWResModel data) {
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
            title: FittedBox(
              child: Text('ENTER HOME WORK WEEK ${data.week}?',
                  textAlign: TextAlign.center, style: s30f700colorSysWhite),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routers.detailAllResultHW,
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
        textNow: 'Mark',
        size: size,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.02, right: size.width * 0.02),
          child: Column(
            children: [
              Column(
                children: [
                  LineContentItem(
                      size: size, title: 'DONE', icon: const Icon(Icons.check)),
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.4,
                  child: FutureBuilder<List<PreHWResModel>?>(
                      future: instance.get<TeacherAPIRepo>().getALlDonePreHW(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: size.height * 0.3,
                            width: size.width * 0.3,
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
                                  showDetailResultHWDialog(
                                      snapshot.data![index]);
                                },
                                size: size,
                                backgroundColor: colorMainBlue,
                                childRight: const Center(
                                    child: Text(
                                  'DONE',
                                  style: s20f700ColorSysWhite,
                                )),
                                childCenter: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "WEEK ${snapshot.data![index].week}",
                                      style: s16f500ColorSysWhite,
                                    ),
                                    Text(
                                      "SIGN : ${snapshot.data![index].sign}",
                                      style: s16f500ColorSysWhite,
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
            ],
          ),
        ));
  }
}
