import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/utils/find_average/find_average_score.dart';
import '../../../../data/local/models/chart_hw_by_week_main_screen.dart';
import '../../../../data/local/models/user_global.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../data/remote/models/result_hw_res.dart';
import '../../../../main.dart';

class ChildRightHWByWeek extends StatelessWidget {
  ChildRightHWByWeek({
    Key? key,
    required this.week,
    this.deTail,
  }) : super(key: key);
  bool? deTail;
  String week;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: deTail == null ? 50.w : 100.w,
        height: deTail == null ? 10.h : 30.h,
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
