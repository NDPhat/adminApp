import 'package:admin/application/utils/find_average/find_average_score.dart';
import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/chart_hw_season.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/chart_sign_season.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/item_async_data_create_main_screen.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/item_async_data_hw_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/chart_hw_by_week_main_screen.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../data/remote/models/result_hw_res.dart';
import '../../../main.dart';
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
                              image: AssetImage(
                                  "assets/images/home_page/bg_card_home.png"),
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
                              child: const Text(
                                  "Teaching is more than imparting knowledge.\nit is inspiring change.\n"
                                  "Learning is more than absorbing facts.\nIt is acquiring understanding.",
                                  style: s14f500colorSysWhite)),
                        ],
                      )),
                  Center(
                    child: LineContentItem(
                      size: size,
                      title: 'Home works',
                      icon: const Icon(Icons.book),
                    ),
                  ),
                  ChartHWSeason(
                    size: size,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: LineContentItem(
                      size: size,
                      title: 'Homework by week',
                      icon: const Icon(Icons.calendar_view_week),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * 0.3,
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
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  int totalJ = 0;
                                  int score = 0;
                                  for (var element in snapshot.data!) {
                                    totalJ = totalJ + element.numQ!;
                                    score = score + element.score!;
                                  }
                                  return ItemAsyncDataHWPageHome(
                                    size: size,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routers
                                              .detailResultHWByWeakMainScreen,
                                          arguments: snapshot!.data![index]);
                                    },
                                    textTitle: 'WEEK ${index + 1}',
                                    totalUserJoin:
                                        snapshot!.data!.length.toString(),
                                    scoreAvg: ((score / totalJ) * 10)
                                        .toStringAsFixed(2),
                                    childRight: ChildRightHWByWeek(
                                      size: size,
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
                    height: size.height * 0.02,
                  ),
                  LineContentItem(
                    size: size,
                    title: 'Create',
                    icon: const Icon(Icons.dashboard),
                  ),
                  ChartCreateSeason(
                    size: size,
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: LineContentItem(
                      size: size,
                      title: 'Sign by week',
                      icon: const Icon(Icons.calendar_view_week),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * 0.3,
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
                                else if (snapshot.hasData) {
                                  return ItemAsyncDataCreatePageHome(
                                    size: size,
                                    onTap: () {},
                                    textTitle: 'WEEK ${index + 1}',
                                    childRight: ChildRightCreateByWeek(
                                      size: size,
                                      week: (index + 1).toString(),
                                    ),
                                    timeJoin: DateFormat.yMMMEd()
                                        .format(DateTime.now()), signList: snapshot.data!.sign!,
                                  );
                                }
                                else {
                                  return Container();
                                }
                              });
                        },
                      ),
                    ),
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
      padding: EdgeInsets.only(top: size.height * 0.01),
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

class ChildRightHWByWeek extends StatelessWidget {
  ChildRightHWByWeek({
    Key? key,
    required this.size,
    required this.week,
    this.deTail,
  }) : super(key: key);
  final Size size;
  bool? deTail;
  String week;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: deTail == null ? size.width * 0.5 : size.width,
        height: deTail == null ? size.height * 0.1 : size.height * 0.3,
        child: FutureBuilder<List<ResultQuizHWAPIModel>?>(
            future: instance
                .get<TeacherAPIRepo>()
                .getAllResultQuizHWByWeekAndLop(
                    week, instance.get<UserGlobal>().lop.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int sY = 0;
                int sTB = 0;
                int sK = 0;
                int sG = 0;
                for (int i = 0; i < snapshot.data!.length; i++) {
                  String dataBack = findAveScore(snapshot.data![i].score!);
                  if (dataBack == "YEU") {
                    sY++;
                  } else if (dataBack == "KHA") {
                    sK++;
                  } else if (dataBack == "TRUNG BINH") {
                    sTB++;
                  } else {
                    sG++;
                  }
                }
                List<ChartDataMSByWeek> dataList = [
                  ChartDataMSByWeek("D", sY),
                  ChartDataMSByWeek("C", sTB),
                  ChartDataMSByWeek("B", sK),
                  ChartDataMSByWeek("A", sG),
                ];
                return SfCartesianChart(
                    plotAreaBorderColor: colorMainBlue,
                    plotAreaBorderWidth: 0,
                    tooltipBehavior:
                        TooltipBehavior(enable: deTail == null ? false : true),
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      //Hide the axis line of x-axis
                    ),
                    primaryYAxis: NumericAxis(
                      //Hide the gridlines of y-axis
                      majorGridLines: const MajorGridLines(width: 0),
                      //Hide the axis line of y-axis
                    ),
                    series: <ChartSeries<ChartDataMSByWeek, String>>[
                      ColumnSeries<ChartDataMSByWeek, String>(
                        color: colorErrorPrimary,
                        isVisible: true,
                        dataSource: dataList,
                        xValueMapper: (ChartDataMSByWeek chart, _) =>
                            chart.x.toString(),
                        yValueMapper: (ChartDataMSByWeek chart, _) => chart.y,
                        width: 1,
                        // Spacing between the columns
                        spacing: 0.2,
                        dataLabelSettings: const DataLabelSettings(
                            color: colorErrorPrimary,
                            textStyle: TextStyle(fontSize: 2)),
                      ),
                    ]);
              } else {
                return Container();
              }
            }));
  }
}

class ChildRightCreateByWeek extends StatelessWidget {
  ChildRightCreateByWeek({
    Key? key,
    required this.size,
    required this.week,
  }) : super(key: key);
  final Size size;
  String week;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width * 0.5,
        height: size.height * 0.1,
        child: FutureBuilder<PreHWResModel?>(
            future: instance.get<TeacherAPIRepo>().getPreHWByWeek(week),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int signAddTrue = 0;
                int signSubTrue = 0;
                int signMulTrue = 0;
                int signDiviTrue = 0;
                List<String> sign = snapshot.data!.sign!;
                for (int i = 0; i < sign.length; i++) {
                  switch (sign[i]) {
                    case "+":
                      signAddTrue++;
                      break;
                    case "-":
                      signSubTrue++;
                      break;
                    case "x":
                      signMulTrue++;
                      break;
                    case "/":
                      signDiviTrue++;
                      break;
                  }
                }
                List<ChartData> dataList = [
                  ChartData("+", signAddTrue),
                  ChartData(
                    "-",
                    signSubTrue,
                  ),
                  ChartData(
                    "x",
                    signMulTrue,
                  ),
                  ChartData(
                    "/",
                    signDiviTrue,
                  ),
                ];
                return SfCartesianChart(
                    plotAreaBorderColor: colorMainBlue,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      //Hide the axis line of x-axis
                    ),
                    primaryYAxis: NumericAxis(
                      //Hide the gridlines of y-axis
                      majorGridLines: const MajorGridLines(width: 0),
                      //Hide the axis line of y-axis
                    ),
                    series: <ChartSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        color: colorErrorPrimary,
                        isVisible: true,
                        dataSource: dataList,
                        xValueMapper: (ChartData chart, _) =>
                            chart.x.toString(),
                        yValueMapper: (ChartData chart, _) => chart.y,
                        width: 1,
                        // Spacing between the columns
                        spacing: 0.2,
                        dataLabelSettings: const DataLabelSettings(
                            color: colorErrorPrimary,
                            textStyle: TextStyle(fontSize: 2)),
                      ),
                    ]);
              } else {
                return Container();
              }
            }));
  }
}
