import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/chart_hw_season.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/chart_sign_season.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/child_right_create_week.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/child_right_hw_week.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/item_async_data_create_main_screen.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/item_async_data_hw_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../data/remote/models/result_hw_res.dart';
import '../../../main.dart';
import '../../widget/bg_home_screen.dart';
import '../../widget/line_content_item_widget.dart';

class DashBoardHomePageScreen extends StatelessWidget {
  const DashBoardHomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
          textNow: 'Home',
          colorTextAndIcon: Colors.black,
          child: Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
              child: Column(
                children: [
                  const Center(
                    child: LineContentItem(
                      colorBG: colorMainBlue,
                      title: 'Home works',
                      icon: Icon(Icons.book),
                    ),
                  ),
                  const ChartHWSeason(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Center(
                    child: LineContentItem(
                      title: 'Homework by week',
                      colorBG: colorMainBlue,
                      icon: Icon(Icons.calendar_view_week),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 30.h,
                      child: ListView.builder(
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          return FutureBuilder<List<ResultQuizHWAPIModel>?>(
                              future: instance
                                  .get<TeacherAPIRepo>()
                                  .getAllResultQuizHWByWeekAndLop(
                                    (index + 1).toString(),
                                    instance.get<UserGlobal>().lop.toString(),
                                  ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: colorMainBlue,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  int totalJ = 0;
                                  int score = 0;
                                  for (var element in snapshot.data!) {
                                    totalJ = totalJ + element.numQ!;
                                    score = score + element.score!;
                                  }
                                  return ItemAsyncDataHWPageHome(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routers
                                              .detailResultHWByWeakMainScreen,
                                          arguments: snapshot.data![index]);
                                    },
                                    textTitle: 'WEEK ${index + 1}',
                                    totalUserJoin:
                                        snapshot.data!.length.toString(),
                                    scoreAvg: ((score / totalJ) * 10)
                                        .toStringAsFixed(2),
                                    childRight: ChildRightHWByWeek(
                                      week: (index + 1).toString(),
                                    ),
                                    timeNow: DateFormat.yMMMEd()
                                        .format(DateTime.now()),
                                  );
                                }
                                return Container();
                              });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const LineContentItem(
                    colorBG: colorMainBlue,
                    title: 'Create',
                    icon: Icon(Icons.dashboard),
                  ),
                  const ChartCreateSeason(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Center(
                    child: LineContentItem(
                      colorBG: colorMainBlue,
                      title: 'Sign by week',
                      icon: Icon(Icons.calendar_view_week),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 30.h,
                      child: ListView.builder(
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          return FutureBuilder<PreHWResModel?>(
                              future: instance
                                  .get<TeacherAPIRepo>()
                                  .getPreHWByWeek((index + 1).toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: colorMainBlue,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  return ItemAsyncDataCreatePageHome(
                                    onTap: () {},
                                    textTitle: 'WEEK ${index + 1}',
                                    childRight: ChildRightCreateByWeek(
                                      week: (index + 1).toString(),
                                    ),
                                    timeJoin: DateFormat.yMMMEd()
                                        .format(DateTime.now()),
                                    signList: snapshot.data!.sign!,
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
