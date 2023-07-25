import 'package:admin/application/cons/text_style.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/utils/find_average/get_sign.dart';
import '../../../data/local/models/chart_data_week.dart';
import '../../../data/remote/models/quiz_hw_res.dart';
import '../../../main.dart';
import '../../widget/anwser_widget.dart';
import '../../widget/app_bar_widget.dart';

class DetailResultHWItemScreen extends StatelessWidget {
  const DetailResultHWItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResultQuizHWAPIModel data =
        ModalRoute.of(context)!.settings.arguments as ResultQuizHWAPIModel;
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(onBack: () {
            Navigator.pop(context);
          }),
          Container(
            padding:
                EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  child: Column(
                    children: [
                      FutureBuilder<List<QuizHWAPIModel>?>(
                          future: instance
                              .get<TeacherAPIRepo>()
                              .getAllQuizHWByResultID(data.key.toString()),
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
                                int sign =
                                    getSign(quiz: snapshotChild.data![i].quiz!);
                                if (snapshotChild.data![i].infoQuiz == true) {
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
                                ChartDataWeek("+", signAddTrue, signAddFalse),
                                ChartDataWeek("-", signSubTrue, signSubFalse),
                                ChartDataWeek("x", signMulTrue, signMulFalse),
                                ChartDataWeek("/", signDiviTrue, signDiviFalse),
                              ];
                              return SfCartesianChart(
                                  plotAreaBorderColor: colorMainBlue,
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    //Hide the axis line of x-axis
                                  ),
                                  primaryYAxis: NumericAxis(
                                    //Hide the gridlines of y-axis
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    //Hide the axis line of y-axis
                                  ),
                                  series: <CartesianSeries<ChartDataWeek,
                                      String>>[
                                    ColumnSeries<ChartDataWeek, String>(
                                      color: colorMainBlue,
                                      dataSource: dataList,
                                      xValueMapper: (ChartDataWeek chart, _) =>
                                          chart.x,
                                      yValueMapper: (ChartDataWeek chart, _) =>
                                          chart.y,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              color: colorMainBlue,
                                              textStyle:
                                                  TextStyle(fontSize: 2)),
                                    ),
                                    ColumnSeries<ChartDataWeek, String>(
                                      color: colorErrorPrimary,
                                      dataSource: dataList,
                                      xValueMapper: (ChartDataWeek chart, _) =>
                                          chart.x,
                                      yValueMapper: (ChartDataWeek chart, _) =>
                                          chart.y1,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              color: colorMainBlue,
                                              textStyle:
                                                  TextStyle(fontSize: 2)),
                                    ),
                                  ]);
                            } else {
                              return Container();
                            }
                          }),
                      Center(
                        child: Text(
                          'data detail'.tr().toString(),
                          style: s14f500ColorMainTe,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 40.h,
                    child: FutureBuilder<List<QuizHWAPIModel>?>(
                        future: instance
                            .get<TeacherAPIRepo>()
                            .getAllQuizHWByResultID(data.key.toString()),
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
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return AnswerWidget(
                                    quiz: snapshot.data![index].quiz.toString(),
                                    answer:
                                        snapshot.data![index].answer.toString(),
                                    answerSelect: snapshot
                                        .data![index].answerSelect
                                        .toString(),
                                    quizInfo: snapshot.data![index].infoQuiz!,
                                  );
                                });
                          } else {
                            return Container();
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
