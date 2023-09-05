import 'package:admin/domain/bloc/data_sheet/data_sheet_cubit.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/chart_hw_season.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/child_right_hw_week.dart';
import 'package:admin/presentation/screen/dashboard_main/widget/item_async_data_hw_main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../domain/bloc/detail_homework/detail_result_hw_cubit.dart';
import '../../widget/bg_home_screen.dart';
import '../../widget/line_content_item_widget.dart';
import '../manager/widget/dot_page_indicator.dart';
import '../manager/widget/indicator.dart';

class DataSheetMainScreen extends StatefulWidget {
  const DataSheetMainScreen({Key? key}) : super(key: key);
  @override
  State<DataSheetMainScreen> createState() => DataSheetMainScreenState();
}

class DataSheetMainScreenState extends State<DataSheetMainScreen> {
  @override
  void initState() {
    super.initState();
    initPageData();
  }

  void initPageData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DataSheetCubit>().initPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
          onBack: () {
            Navigator.pushNamed(context, Routers.home);
          },
          textNow: 'data sheet'.tr(),
          colorTextAndIcon: Colors.black,
          child: Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
              child: Column(
                children: [
                  const ChartHWSeason(),
                  SizedBox(
                    height: 2.h,
                  ),
                  LineContentItem(
                      colorBG: colorMainBlue,
                      title: 'detailed data'.tr().toString(),
                      icon: const Icon(Icons.home_work)),
                  BlocBuilder<DataSheetCubit, DataSheetState>(
                      buildWhen: (pre, now) {
                    return pre.pageNow != now.pageNow || pre.posts != now.posts;
                  }, builder: (context, state) {
                    return SingleChildScrollView(
                        child: SizedBox(
                            height: 43.h,
                            child: state.posts!.isNotEmpty
                                ? CustomScrollView(slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount: state.posts!.length,
                                        (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.5.h, bottom: 0.5.h),
                                            child: ItemAsyncDataHWPageHome(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    Routers
                                                        .detailResultHWByWeakMainScreen,
                                                    arguments:
                                                        (index + 1).toString());
                                              },
                                              textTitle:
                                                  'WEEK ${state.posts!.firstWhere((element) => element.week == (index + 1).toString()).week}',
                                              totalUserJoin: state.posts!
                                                  .firstWhere((element) =>
                                                      element.week ==
                                                      (index + 1).toString())
                                                  .totalJoin
                                                  .toString(),
                                              scoreAvg: state.posts!
                                                  .firstWhere((element) =>
                                                      element.week ==
                                                      (index + 1).toString())
                                                  .scoreAvg!,
                                              childRight: ChildRightHWByWeek(
                                                week: (index + 1).toString(),
                                              ),
                                              timeSave: state.posts!
                                                  .firstWhere((element) =>
                                                      element.week ==
                                                      (index + 1).toString())
                                                  .time!,
                                              colorBorder: colorMainBlue,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ])
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: colorMainBlue,
                                      strokeWidth: 3,
                                    ),
                                  )));
                  }),
                  Container(
                    height: 4.h,
                    padding: EdgeInsets.only(right: 5.w),
                    width: 100.w,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// MINUS
                          BlocBuilder<DataSheetCubit, DataSheetState>(
                              buildWhen: (pre, now) {
                            return pre.pageNow != now.pageNow;
                          }, builder: (context, state) {
                            return renderMinusPage(context);
                          }),
                          SizedBox(
                            width: 2.w,
                          ),

                          /// VALUE
                          BlocBuilder<DataSheetCubit, DataSheetState>(
                              buildWhen: (pre, now) {
                            return pre.pageNow != now.pageNow ||
                                pre.posts != now.posts;
                          }, builder: (context, state) {
                            return renderPageValue(state);
                          }),
                          SizedBox(
                            width: 2.w,
                          ),

                          ///PLUS
                          BlocBuilder<DataSheetCubit, DataSheetState>(
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
          ))),
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
        context.read<DataSheetCubit>().pagePlus();
      },
    );
  }

  DotIndicator renderPageValue(DataSheetState state) {
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
        context.read<DataSheetCubit>().pageMinus();
      },
    );
  }
}
