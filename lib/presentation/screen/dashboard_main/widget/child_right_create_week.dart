import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../application/cons/color.dart';
import '../../../../data/local/models/chart_data.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../data/remote/models/pre_hw_res.dart';
import '../../../../main.dart';

class ChildRightCreateByWeek extends StatelessWidget {
  ChildRightCreateByWeek({
    Key? key,
    required this.week,
  }) : super(key: key);
  String week;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50.w,
        height: 10.h,
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
