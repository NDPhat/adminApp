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
      child: FutureBuilder<List<ResultQuizHWAPIModel>?>(
          future: instance.get<TeacherAPIRepo>().getAllResultQuizHWByLop(
              instance.get<UserGlobal>().lop.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<ChartDataHWWeekMainScreen> dataList = [
                ChartDataHWWeekMainScreen(1, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(2, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(3, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(4, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(5, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(6, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(7, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(8, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(9, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(10, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(11, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(12, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(13, 0, 0, 0, 0),
                ChartDataHWWeekMainScreen(14, 0, 0, 0, 0),
              ];
              int sY = 0;
              int sTB = 0;
              int sK = 0;
              int sG = 0;
              int week = 0;
              for (int i = 0; i < snapshot.data!.length; i++) {
                week = int.parse(snapshot.data![i].week.toString());
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
              dataList[week - 1].y = sY;
              dataList[week - 1].y1 = sTB;
              dataList[week - 1].y2 = sK;
              dataList[week - 1].y3 = sG;
              return Column(
                children: [
                  SizedBox(
                    width:100.w,
                    height:30.h,
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
                  const Center(
                    child: Text(
                      'Data homework by season ',
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
