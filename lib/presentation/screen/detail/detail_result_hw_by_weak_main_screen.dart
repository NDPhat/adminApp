import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/presentation/screen/detail/widget/item_detailresult_hw_main.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/constants.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_average/get_sign.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/chart_data_week.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../data/remote/models/result_hw_pagi_res.dart';
import '../../../data/remote/models/result_hw_res.dart';
import '../../../main.dart';
import '../../widget/line_content_item_widget.dart';
import '../manager/widget/dot_page_indicator.dart';
import '../manager/widget/indicator.dart';

class DetailResultHWByWeakMainScreen extends StatefulWidget {
  const DetailResultHWByWeakMainScreen({Key? key}) : super(key: key);
  @override
  State<DetailResultHWByWeakMainScreen> createState() =>
      DetailResultHWByWeakMainScreenState();
}

class DetailResultHWByWeakMainScreenState
    extends State<DetailResultHWByWeakMainScreen> {
  int page = 1;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  List<ResultHWPagiModel>? posts = [];
  ResultHWPagiAPI? data;
  String week = "1";
  int length = 1;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      week = ModalRoute.of(context)!.settings.arguments as String;
    });
    firstLoad();
    super.initState();
  }

  void getMore() async {
    posts!.clear();
    data = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), page);
    final List<ResultHWPagiModel>? fetchedPosts = data!.data;
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
    data = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), page);
    final List<ResultHWPagiModel>? fetchedPosts = data!.data;
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

  Color getColorColumn(int x) {
    if (x < 5) {
      return colorErrorPrimary;
    } else if (x >= 5 && x <= 7) {
      return colorSystemYeloow;
    } else {
      return colorMainTealPri;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
        textNow: "Detail",
        colorTextAndIcon: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
          child: Column(
            children: [
              SizedBox(
                height: 36.h,
                child: FutureBuilder<List<ResultQuizHWAPIModel>?>(
                    future: instance
                        .get<TeacherAPIRepo>()
                        .getAllResultQuizHWByWeekAndLop(week.toString(),
                            instance.get<UserGlobal>().lop.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ChartData> dataList = [];
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          dataList.add(ChartData(snapshot.data![i].name!,
                              snapshot.data![i].score!));
                        }
                        return SfCartesianChart(
                            plotAreaBorderColor: colorMainBlue,
                            plotAreaBorderWidth: 0,
                            tooltipBehavior: TooltipBehavior(),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              //Hide the axis line of x-axis
                            ),
                            primaryYAxis: NumericAxis(
                              maximum: 10,
                              //Hide the gridlines of y-axis
                              majorGridLines: const MajorGridLines(width: 0),
                              //Hide the axis line of y-axis
                            ),
                            series: <ChartSeries<ChartData, String>>[
                              ColumnSeries<ChartData, String>(
                                isVisible: true,
                                dataSource: dataList,
                                xValueMapper: (ChartData chart, _) =>
                                    chart.x.toString(),
                                yValueMapper: (ChartData chart, _) => chart.y,
                                pointColorMapper: (ChartData chart, _) =>
                                    getColorColumn(chart.y),
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
                    }),
              ),
              const Center(
                child: Text(
                  'Data homework by week ',
                  style: s12f400ColorGreyTe,
                ),
              ),
              LineContentItem(
                colorBG: colorMainBlue,
                title: 'data detail'.tr().toString(),
                icon: const Icon(Icons.details_outlined),
              ),
              SizedBox(
                height: 38.h,
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
                        height: 38.h,
                        width: 90.w,
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              childCount: posts!.length,
                              (context, index) {
                                posts!
                                    .sort((a, b) => a.week!.compareTo(b.week!));
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, bottom: 0.5.h),
                                  child: ItemDetailRSHWMainScreen(
                                    colorBorder: colorMainBlue,
                                    score: '${posts![index].score}',
                                    week: '${posts![index].week}',
                                    name: '${posts![index].name}',
                                    childRight: SizedBox(
                                      width: 45.w,
                                      child: FutureBuilder<
                                              List<QuizHWAPIModel>?>(
                                          future: instance
                                              .get<TeacherAPIRepo>()
                                              .getAllQuizHWByResultID(
                                                  posts![index].key.toString()),
                                          builder: (context, snapshotChild) {
                                            if (snapshotChild.hasData) {
                                              int signAddTrue = 0;
                                              int signSubTrue = 0;
                                              int signMulTrue = 0;
                                              int signDiviTrue = 0;
                                              int signAddFalse = 0;
                                              int signSubFalse = 0;
                                              int signMulFalse = 0;
                                              int signDiviFalse = 0;
                                              for (int i = 0;
                                                  i <
                                                      snapshotChild
                                                          .data!.length;
                                                  i++) {
                                                int sign = getSign(
                                                    quiz: snapshotChild
                                                        .data![i].quiz!);
                                                if (snapshotChild
                                                        .data![i].infoQuiz ==
                                                    true) {
                                                  switch (sign) {
                                                    case 0:
                                                      signAddTrue++;
                                                      break;
                                                    case 1:
                                                      signSubTrue++;
                                                      break;
                                                    case 2:
                                                      signMulTrue++;
                                                      break;
                                                    case 3:
                                                      signDiviTrue++;
                                                      break;
                                                  }
                                                } else {
                                                  switch (sign) {
                                                    case 0:
                                                      signAddFalse++;
                                                      break;
                                                    case 1:
                                                      signSubFalse++;
                                                      break;
                                                    case 2:
                                                      signMulFalse++;
                                                      break;
                                                    case 3:
                                                      signDiviFalse++;
                                                      break;
                                                  }
                                                }
                                              }
                                              List<ChartDataWeek> dataList = [
                                                ChartDataWeek("+", signAddTrue,
                                                    signAddFalse),
                                                ChartDataWeek("-", signSubTrue,
                                                    signSubFalse),
                                                ChartDataWeek("x", signMulTrue,
                                                    signMulFalse),
                                                ChartDataWeek("/", signDiviTrue,
                                                    signDiviFalse),
                                              ];
                                              return SfCartesianChart(
                                                  plotAreaBorderColor:
                                                      colorMainBlue,
                                                  plotAreaBorderWidth: 0,
                                                  primaryXAxis: CategoryAxis(
                                                    majorGridLines:
                                                        const MajorGridLines(
                                                            width: 0),
                                                    //Hide the axis line of x-axis
                                                  ),
                                                  primaryYAxis: NumericAxis(
                                                    //Hide the gridlines of y-axis
                                                    majorGridLines:
                                                        const MajorGridLines(
                                                            width: 0),
                                                    //Hide the axis line of y-axis
                                                  ),
                                                  series: <CartesianSeries<
                                                      ChartDataWeek, String>>[
                                                    ColumnSeries<ChartDataWeek,
                                                        String>(
                                                      color: colorMainBlue,
                                                      dataSource: dataList,
                                                      xValueMapper:
                                                          (ChartDataWeek chart,
                                                                  _) =>
                                                              chart.x,
                                                      yValueMapper:
                                                          (ChartDataWeek chart,
                                                                  _) =>
                                                              chart.y,
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                              color:
                                                                  colorMainBlue,
                                                              textStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          2)),
                                                    ),
                                                    ColumnSeries<ChartDataWeek,
                                                        String>(
                                                      color: colorErrorPrimary,
                                                      dataSource: dataList,
                                                      xValueMapper:
                                                          (ChartDataWeek chart,
                                                                  _) =>
                                                              chart.x,
                                                      yValueMapper:
                                                          (ChartDataWeek chart,
                                                                  _) =>
                                                              chart.y1,
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                              color:
                                                                  colorMainBlue,
                                                              textStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          2)),
                                                    ),
                                                  ]);
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ),
                                  ),
                                );
                              },
                            ))
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
      ),
    );
  }
}
