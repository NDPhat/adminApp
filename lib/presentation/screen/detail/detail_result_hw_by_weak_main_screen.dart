import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/presentation/screen/detail/widget/item_detailresult_hw_main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_average/get_sign.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/chart_data_week.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../data/remote/models/result_hw_res.dart';
import '../../../main.dart';
import '../../widget/app_bar_widget.dart';
import '../dashboard_main/dashboard_home_page_screen.dart';

class DetailResultHWByWeakMainScreen extends StatelessWidget {
  const DetailResultHWByWeakMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResultQuizHWAPIModel data =
        ModalRoute.of(context)!.settings.arguments as ResultQuizHWAPIModel;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            size: size,
            onBack: () {
              Navigator.pop(context);
            },
            textTitle: 'Detail Home works weak ${data.week}',
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.02),
            child: Column(
              children: [
                FutureBuilder<List<ResultQuizHWAPIModel>?>(
                    future: instance
                        .get<TeacherAPIRepo>()
                        .getAllResultQuizHWByWeekAndLop(data.week!.toString(),
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
                                color: colorMainTealPri,
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
                    }),
                const Center(
                  child: Text(
                    'Data homework by week ',
                    style: s12f400ColorGreyTe,
                  ),
                ),
                LineContentItem(
                  size: size,
                  title: 'Detail',
                  icon: const Icon(Icons.details_outlined),
                ),
                SizedBox(
                  height: size.height * 0.4,
                  child: FutureBuilder<List<ResultQuizHWAPIModel>?>(
                      future: instance
                          .get<TeacherAPIRepo>()
                          .getAllResultQuizHWByWeekAndLop(data.week!.toString(),
                              instance.get<UserGlobal>().lop.toString()),
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
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              snapshot.data!
                                  .sort((a, b) => a.week!.compareTo(b.week!));
                              return ItemDetailRSHWMainScreen(
                                size: size,
                                week: '${snapshot.data![index].week}',
                                name: '${snapshot.data![index].name}',
                                childRight: SizedBox(
                                  width: size.width * 0.45,
                                  child: FutureBuilder<List<QuizHWAPIModel>?>(
                                      future: instance
                                          .get<TeacherAPIRepo>()
                                          .getAllQuizHWByResultID(snapshot
                                              .data![index].key
                                              .toString()),
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
                                              i < snapshotChild.data!.length;
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
                                            ChartDataWeek(
                                                "+", signAddTrue, signAddFalse),
                                            ChartDataWeek(
                                                "-", signSubTrue, signSubFalse),
                                            ChartDataWeek(
                                                "x", signMulTrue, signMulFalse),
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
                                                          color: colorMainBlue,
                                                          textStyle: TextStyle(
                                                              fontSize: 2)),
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
                                                          color: colorMainBlue,
                                                          textStyle: TextStyle(
                                                              fontSize: 2)),
                                                ),
                                              ]);
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
