import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/presentation/screen/detail/widget/item_detailresult_hw_main.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../application/cons/color.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../application/utils/find_average/get_sign.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/chart_data_week.dart';
import '../../../domain/bloc/detail_homework/detail_result_hw_cubit.dart';
import '../../../main.dart';
import '../../widget/rounded_button.dart';
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
  late String week;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      week = ModalRoute.of(context)!.settings.arguments as String;
      initPageData();
    });
  }

  void initPageData() {
    context.read<DetailResultHWCubit>().initPage(week);
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
        onBack: () {
          Navigator.pop(context);
        },
        textNow: "detailed homework data".tr(),
        colorTextAndIcon: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
          child: Column(
            children: [
              SizedBox(
                  height: 36.h,
                  child: BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                      buildWhen: (pre, now) {
                    return pre.dataListChart != now.dataListChart;
                  }, builder: (context, state) {
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
                            dataSource: state.dataListChart!,
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
                  })),

              ///
              SizedBox(
                height: 5.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          renderSortText(),
                          BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                              buildWhen: (pre, now) {
                            return pre.scoreChoose != now.scoreChoose;
                          }, builder: (context, state) {
                            return renderScoreChoose(context, state);
                          }),
                          BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                              buildWhen: (pre, now) {
                            return pre.nameChoose != now.nameChoose;
                          }, builder: (context, state) {
                            return renderNameChoose(context, state);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                  buildWhen: (pre, now) {
                return pre.pageNow != now.pageNow ||
                    pre.posts != now.posts ||
                    pre.nameChoose != now.nameChoose ||
                    pre.scoreChoose != now.scoreChoose;
              }, builder: (context, state) {
                return SizedBox(
                  height: 42.h,
                  child: state.posts!.isEmpty
                      ? SizedBox(
                          height: 30.h,
                          width: 80.w,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: colorMainBlue,
                              strokeWidth: 5,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 42.h,
                          width: 90.w,
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                childCount: state.posts!.length,
                                (context, index) {
                                  state.posts!.sort(
                                      (a, b) => a.week!.compareTo(b.week!));
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.5.h, bottom: 0.5.h),
                                    child: ItemDetailRSHWMainScreen(
                                      colorBorder: colorMainBlue,
                                      score: '${state.posts![index].score}',
                                      week: '${state.posts![index].week}',
                                      name: '${state.posts![index].name}',
                                      childRight: SizedBox(
                                        width: 45.w,
                                        child: FutureBuilder<
                                                List<QuizHWAPIModel>?>(
                                            future: instance
                                                .get<ResultHWAPIRepo>()
                                                .getAllQuizHWByResultID(state
                                                    .posts![index].key
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
                                                  ChartDataWeek(
                                                      "+",
                                                      signAddTrue,
                                                      signAddFalse),
                                                  ChartDataWeek(
                                                      "-",
                                                      signSubTrue,
                                                      signSubFalse),
                                                  ChartDataWeek(
                                                      "x",
                                                      signMulTrue,
                                                      signMulFalse),
                                                  ChartDataWeek(
                                                      "/",
                                                      signDiviTrue,
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
                                                      ColumnSeries<
                                                          ChartDataWeek,
                                                          String>(
                                                        color: colorMainBlue,
                                                        dataSource: dataList,
                                                        xValueMapper:
                                                            (ChartDataWeek
                                                                        chart,
                                                                    _) =>
                                                                chart.x,
                                                        yValueMapper:
                                                            (ChartDataWeek
                                                                        chart,
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
                                                      ColumnSeries<
                                                          ChartDataWeek,
                                                          String>(
                                                        color:
                                                            colorErrorPrimary,
                                                        dataSource: dataList,
                                                        xValueMapper:
                                                            (ChartDataWeek
                                                                        chart,
                                                                    _) =>
                                                                chart.x,
                                                        yValueMapper:
                                                            (ChartDataWeek
                                                                        chart,
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
                );
              }),
              Container(
                height: 4.h,
                padding: EdgeInsets.only(right: 5.w),
                width: 100.w,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  /// MINUS
                  BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                      buildWhen: (pre, now) {
                    return pre.pageNow != now.pageNow;
                  }, builder: (context, state) {
                    return renderMinusPage(context);
                  }),
                  SizedBox(
                    width: 2.w,
                  ),

                  /// VALUE
                  BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                      buildWhen: (pre, now) {
                    return pre.pageNow != now.pageNow || pre.posts != now.posts;
                  }, builder: (context, state) {
                    return renderPageValue(state);
                  }),
                  SizedBox(
                    width: 2.w,
                  ),

                  ///PLUS
                  BlocBuilder<DetailResultHWCubit, DetailResultHWState>(
                      buildWhen: (pre, now) {
                    return pre.pageNow != now.pageNow;
                  }, builder: (context, state) {
                    return renderPlusPage(context);
                  }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox renderSortText() {
    return SizedBox(
      width: 18.w,
      height: 5.h,
      child: Center(
        child: Text(
          "${"sort".tr()}  :",
          style: GoogleFonts.aclonica(
            color: colorSystemYeloow,
            decorationColor: colorSystemYeloow,
            decorationThickness: 7,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  DotPageIndicator renderPlusPage(BuildContext context) {
    return DotPageIndicator(
      colorBorder: colorMainBlue,
      icon: SvgPicture.asset(
        "assets/icon/next.svg",
        color: colorMainBlue,
        fit: BoxFit.cover,
      ),
      onTap: () {
        context.read<DetailResultHWCubit>().pagePlus(week);
      },
    );
  }

  DotIndicator renderPageValue(DetailResultHWState state) {
    return DotIndicator(
      totalPage: findLength(state.lengthNow).toString(),
      colorBorder: colorErrorPrimary,
      pageIndex: state.pageNow.toString(),
    );
  }

  DotPageIndicator renderMinusPage(BuildContext context) {
    return DotPageIndicator(
      colorBorder: colorMainBlue,
      icon: SvgPicture.asset(
        "assets/icon/back.svg",
        color: colorMainBlue,
        fit: BoxFit.cover,
      ),
      onTap: () {
        context.read<DetailResultHWCubit>().pageMinus(week);
      },
    );
  }

  Center renderNameChoose(BuildContext context, DetailResultHWState state) {
    return Center(
      child: RoundedButton(
        press: () {
          context.read<DetailResultHWCubit>().nameChoose(week);
        },
        colorBorder: state.nameChoose ? colorErrorPrimary : colorSystemYeloow,
        color: colorSystemWhite,
        width: 15.w,
        height: 3.h,
        child: Text(
          "name".tr(),
          style: GoogleFonts.cabin(
            color: state.nameChoose ? colorErrorPrimary : colorSystemYeloow,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Center renderScoreChoose(BuildContext context, DetailResultHWState state) {
    return Center(
      child: RoundedButton(
        press: () {
          context.read<DetailResultHWCubit>().scoreChoose(week);
        },
        colorBorder: state.scoreChoose ? colorErrorPrimary : colorSystemYeloow,
        color: colorSystemWhite,
        width: 15.w,
        height: 3.h,
        child: Text(
          "score".tr(),
          style: GoogleFonts.cabin(
            color: state.scoreChoose ? colorErrorPrimary : colorSystemYeloow,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
