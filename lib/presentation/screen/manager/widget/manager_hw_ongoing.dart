import 'package:admin/application/cons/constants.dart';
import 'package:admin/application/utils/find_color/find_color.dart';
import 'package:admin/application/utils/status/manage_status.dart';
import 'package:admin/domain/bloc/manage_hw/manage_hw_cubit.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:admin/presentation/widget/empty.dart';
import 'package:admin/presentation/widget/rounded_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/find_average/find_average_score.dart';

import '../../../widget/item_manager_user.dart';
import 'dot_page_indicator.dart';
import 'indicator.dart';

class ManagerHomeWorkOnGoingScreen extends StatefulWidget {
  const ManagerHomeWorkOnGoingScreen({Key? key}) : super(key: key);

  @override
  State<ManagerHomeWorkOnGoingScreen> createState() =>
      _ManagerHomeWorkOnGoingScreenState();
}

class _ManagerHomeWorkOnGoingScreenState
    extends State<ManagerHomeWorkOnGoingScreen> {
  int page = 1;
  int length = 1;
  late String week;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      week = ModalRoute.of(context)!.settings.arguments as String;
      context.read<ManageHWCubit>().initPage(week);
    });
  }

  showErrorMarkDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      dismissOnTouchOutside: false,
      desc: '${"something wrong".tr()}',
      descTextStyle: s20f700ColorErrorPro,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
  showMarkDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      dismissOnTouchOutside: false,
      desc: "${"mark".tr()} ?",
      descTextStyle: s20f700ColorErrorPro,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        context.read<ManageHWCubit>().mark();
      },
    ).show();
  }

  showDoneMarkDialog() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      dismissOnTouchOutside: false,
      desc: "mark done".tr(),
      descTextStyle: s20f700ColorErrorPro,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        context.read<ManageHWCubit>().initPage(week);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGHomeScreen(
        onBack: () {
          Navigator.pushNamed(context, Routers.managerMainScreen);
        },
        homeIcon: const Icon(Icons.settings),
        onPressHome: () {},
        textNow: "homework management".tr(),
        colorTextAndIcon: Colors.black,
        child: Column(
          children: [
            BlocBuilder<ManageHWCubit, ManageHWState>(buildWhen: (pre, now) {
              return pre.pageNow != now.pageNow ||
                  pre.searchList != now.searchList;
            }, builder: (context, state) {
              return SizedBox(
                width: 90.w,
                height: 10.h,
                child: TextField(
                  style: s16f700ColorGreyTe,
                  decoration: InputDecoration(
                    label: Text(
                      "search".tr().toString(),
                      style: GoogleFonts.aBeeZee(
                          color: colorGreyTetiary, fontSize: 16),
                    ),
                    suffixIcon: const Icon(
                      LineAwesomeIcons.search,
                      size: 30,
                      color: colorGrayBG,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<ManageHWCubit>().onSearchChange(value);
                  },
                ),
              );
            }),
            BlocBuilder<ManageHWCubit, ManageHWState>(buildWhen: (pre, now) {
              return pre.pageNow != now.pageNow ||
                  pre.status != now.status ||
                  pre.searchList != now.searchList;
            }, builder: (context, state) {
              if (state.status == ManageStatus.success || state.status == ManageStatus.successMark) {
                return SizedBox(
                  height: 72.h,
                  width: 90.w,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: state.searchList!.length,
                              (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.5.h, top: 1.h),
                          child: ItemManager(
                              lop: state.searchList![index].lop!,
                              ten: state.searchList![index].name!,
                              childLeft: Center(
                                child: state.searchList![index].numQ != 11 ? Text(
                                  "review".tr(),
                                  style: GoogleFonts.saira(
                                      color: colorMainBlue, fontSize: 20),
                                ) :  Text(
                                  state.searchList![index].score.toString(),
                                  style: GoogleFonts.saira(
                                      color: findColorByScore(
                                          findAveScore(
                                              state.searchList![index]
                                                  .score!)), fontSize: 20),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routers.detailResultHW,
                                    arguments: state.searchList![index].key);
                              },
                              imageLink: state
                                  .imageList[state.searchList![index].userId],
                              colorBorder: colorMainTealPri),
                        );
                      }))
                    ],
                  ),
                );
              } else if (state.status == ManageStatus.onLoading) {
                return SizedBox(
                  height: 72.h,
                  width: 90.w,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorMainBlue,
                      strokeWidth: 5,
                    ),
                  ),
                );
              }
              return Container(
                alignment: Alignment.center,
                height: 72.h,
                width: 90.w,
                child: const EmptyContainer(),
              );
            }),
            sizedBox,
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocConsumer<ManageHWCubit, ManageHWState>(
                      listener: (context, state) {
                    if (state.status == ManageStatus.successMark) {
                      showDoneMarkDialog();
                    } else if (state.status == ManageStatus.errorMark) {
                      showErrorMarkDialog();
                    }
                  }, builder: (context, state) {
                    return RoundedButton(
                        press: () {
                          showMarkDialog();
                        },
                        color: colorErrorPrimary,
                        width: 40.w,
                        height: 4.h,
                        child: state.status == ManageStatus.submit
                            ? SizedBox(
                                height: 3.h,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: colorSystemYeloow,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : Text(
                                "mark".tr(),
                                style: s20f700ColorSysWhite,
                              ));
                  }),
                  SizedBox(
                    height: 4.h,
                    width: 40.w,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// MINUS
                          BlocBuilder<ManageHWCubit, ManageHWState>(
                              buildWhen: (pre, now) {
                            return pre.pageNow != now.pageNow;
                          }, builder: (context, state) {
                            return renderMinusPage(context);
                          }),
                          SizedBox(
                            width: 2.w,
                          ),

                          /// VALUE
                          BlocBuilder<ManageHWCubit, ManageHWState>(
                              buildWhen: (pre, now) {
                            return pre.pageNow != now.pageNow ||
                                pre.searchList != now.searchList;
                          }, builder: (context, state) {
                            return renderPageValue(state);
                          }),
                          SizedBox(
                            width: 2.w,
                          ),

                          ///PLUS
                          BlocBuilder<ManageHWCubit, ManageHWState>(
                              buildWhen: (pre, now) {
                            return pre.pageNow != now.pageNow;
                          }, builder: (context, state) {
                            return renderPlusPage(context);
                          }),
                        ]),
                  ),
                ],
              ),
            )
          ],
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
        context.read<ManageHWCubit>().pagePlus(week);
      },
    );
  }

  DotIndicator renderPageValue(ManageHWState state) {
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
        context.read<ManageHWCubit>().pageMinus(week);
      },
    );
  }
}
