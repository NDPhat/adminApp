import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/local/models/chart_data.dart';
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
