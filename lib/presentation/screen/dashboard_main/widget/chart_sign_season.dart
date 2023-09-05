import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../data/local/models/chart_data.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../main.dart';

class ChartCreateSeason extends StatelessWidget {
  const ChartCreateSeason({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<List<PreHWResModel>?>(
            future: instance.get<TeacherAPIRepo>().getALlDonePreHW(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                int signAddTrue = 0;
                int signSubTrue = 0;
                int signMulTrue = 0;
                int signDiviTrue = 0;
                for (int i = 0; i < snapshot.data!.length; i++) {
                  List<String> sign = snapshot.data![i].sign!;
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
                return Column(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: SfCartesianChart(
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
                          ]),
                    ),
                     Center(
                      child: Text(
                        "detailed sign data".trim(),
                        style: s12f400ColorGreyTe,
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }));
  }
}
