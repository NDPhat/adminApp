import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/find_average/find_average_score.dart';
import '../../../../data/local/models/chart_hw_main_screen.dart';
import '../../../../data/local/models/user_global.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../data/remote/models/result_hw_res.dart';
import '../../../../main.dart';

class ChartHWSeason extends StatelessWidget {
  const ChartHWSeason({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 32.h,
      child: FutureBuilder<List<ResultQuizHWAPIModel>?>(
          future: instance.get<TeacherAPIRepo>().getAllResultQuizHWByLop(
              instance.get<UserGlobal>().lop.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<ChartDataHWWeekMainScreen> dataList = [];
              snapshot.data!.sort(
                  (a, b) => int.parse(a.week!).compareTo(int.parse(a.week!)));
              for (int i = 1; i <= int.parse(snapshot.data!.last.week!); i++) {
                dataList.add(ChartDataHWWeekMainScreen(i, 0, 0, 0, 0));
              }
              for (int i = 0; i < snapshot.data!.length; i++) {
                int week = int.parse(snapshot.data![i].week.toString());
                String dataBack = findAveScore(snapshot.data![i].score!);
                if (dataBack == "YEU") {
                  dataList[week - 1].y++;
                } else if (dataBack == "TRUNG BINH") {
                  dataList[week - 1].y1++;
                } else if (dataBack == "KHA") {
                  dataList[week - 1].y2++;
                } else {
                  dataList[week - 1].y3++;
                }
              }

              return Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 30.h,
                    child: SfCartesianChart(
                        plotAreaBorderColor: colorMainBlue,
                        plotAreaBorderWidth: 0,
                        legend: Legend(isVisible: true, width: '20'),
                        tooltipBehavior: TooltipBehavior(),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          //Hide the axis line of x-axis
                        ),
                        primaryYAxis: NumericAxis(
                          //Hide the gridlines of y-axis
                          majorGridLines: const MajorGridLines(width: 0),
                          //Hide the axis line of y-axis
                        ),
                        series: <ChartSeries<ChartDataHWWeekMainScreen,
                            String>>[
                          ColumnSeries<ChartDataHWWeekMainScreen, String>(
                            color: colorErrorPrimary,
                            isVisible: true,
                            name: "D",
                            dataSource: dataList,
                            xValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.x.toString(),
                            yValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) => chart.y,
                            width: 1,
                            // Spacing between the columns
                            spacing: 0.2,
                            dataLabelSettings: const DataLabelSettings(
                                color: colorErrorPrimary,
                                textStyle: TextStyle(fontSize: 2)),
                          ),
                          ColumnSeries<ChartDataHWWeekMainScreen, String>(
                            color: colorSystemYeloow,
                            isVisible: true,
                            name: "C",
                            dataSource: dataList,
                            xValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.x.toString(),
                            yValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.y1,
                            width: 1,
                            // Spacing between the columns
                            spacing: 0.2,
                            dataLabelSettings: const DataLabelSettings(
                                color: colorSystemYeloow,
                                textStyle: TextStyle(fontSize: 2)),
                          ),
                          ColumnSeries<ChartDataHWWeekMainScreen, String>(
                            color: Colors.green,
                            isVisible: true,
                            name: "B",
                            dataSource: dataList,
                            xValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.x.toString(),
                            yValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.y2,
                            width: 1,
                            // Spacing between the columns
                            spacing: 0.2,
                            dataLabelSettings: const DataLabelSettings(
                                color: Colors.green,
                                textStyle: TextStyle(fontSize: 2)),
                          ),
                          ColumnSeries<ChartDataHWWeekMainScreen, String>(
                            color: colorMainBlue,
                            isVisible: true,
                            dataSource: dataList,
                            name: "A",
                            xValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.x.toString(),
                            yValueMapper:
                                (ChartDataHWWeekMainScreen chart, _) =>
                                    chart.y3,
                            width: 1,
                            // Spacing between the columns
                            spacing: 0.2,
                            dataLabelSettings: const DataLabelSettings(
                                color: colorMainBlue,
                                textStyle: TextStyle(fontSize: 2)),
                          ),
                        ]),
                  ),
                  Container(
                    width: 100.w,
                    height: 2.h,
                    alignment: Alignment.center,
                    child:  Text(
                      "detailed homework data".tr(),
                      style: s12f400ColorGreyTe,
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
