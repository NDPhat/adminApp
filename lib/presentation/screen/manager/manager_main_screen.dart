import 'package:admin/application/cons/constants.dart';
import 'package:admin/data/remote/api/api/pre_hw_repo.dart';
import 'package:admin/domain/bloc/manage_main/manage_cubit.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/screen/manager/widget/dot_page_indicator.dart';
import 'package:admin/presentation/screen/manager/widget/indicator.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/event_local/update_pre_now.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../main.dart';
import '../../navigation/routers.dart';
import '../../widget/line_content_item_widget.dart';

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({Key? key}) : super(key: key);
  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  @override
  void initState() {
    super.initState();
    initPageData();
  }

  void initPageData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ManageCubit>().initPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showPreHWDialog(PreHWAPIModel data) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'review this week home work'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.pushNamed(context, Routers.detailPre, arguments: data);
        },
      ).show();
    }

    return Scaffold(
      body: BGHomeScreen(
          onBack: () {
            Navigator.pushNamed(context, Routers.home);
          },
          textNow: 'management'.tr().toString(),
          colorTextAndIcon: Colors.black,
          child: Container(
            height: 90.h,
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(
              children: [
                ///LINE
                LineContentItem(
                  title: 'student'.tr().toString(),
                  icon: const Icon(LineAwesomeIcons.user),
                  colorBG: colorMainBlue,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routers.managerUser);
                    },
                    child: Container(
                      width: 100.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: colorMainBlue),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: Text(
                          "${"class".tr()} ${instance.get<UserGlobal>().lop}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                              color: colorMainBlue, fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                LineContentItem(
                    colorBG: colorErrorPrimary,
                    title: 'home work'.tr().toString(),
                    icon: const Icon(Icons.home_work)),
                BlocBuilder<ManageCubit, ManageState>(buildWhen: (pre, now) {
                  return pre.pageNow != now.pageNow || pre.posts != now.posts;
                }, builder: (context, state) {
                  return SizedBox(
                      height: 28.h,
                      child: state.posts!.isEmpty
                          ? SizedBox(
                              height: 25.h,
                              width: 25.w,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: colorMainBlue,
                                  strokeWidth: 5,
                                ),
                              ),
                            )
                          : CustomScrollView(slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                childCount: state.posts!.length,
                                (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.5.h, bottom: 0.5.h),
                                    child: ItemCard(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routers.detailAllResultHW,
                                            arguments:
                                                state.posts![index].week);
                                      },
                                      colorBorder: colorErrorPrimary,
                                      childRight: Center(
                                          child: Text(
                                        'done'.tr().toString(),
                                        style: GoogleFonts.aboreto(
                                            color: colorErrorPrimary,
                                            fontSize: 20),
                                      )),
                                      childCenter: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${"week".tr()} ${state.posts![index].week}",
                                            style: GoogleFonts.aboreto(
                                                color: colorErrorPrimary,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${"sign".tr()} : ${state.posts![index].sign}",
                                            style: GoogleFonts.aboreto(
                                                color: colorErrorPrimary,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                            ]));
                }),
                Container(
                  height: 4.h,
                  padding: EdgeInsets.only(right: 5.w),
                  width: 100.w,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    BlocBuilder<ManageCubit, ManageState>(
                        buildWhen: (pre, now) {
                      return pre.pageNow != now.pageNow;
                    }, builder: (context, state) {
                      return DotPageIndicator(
                        colorBorder: colorMainBlue,
                        icon: SvgPicture.asset(
                          "assets/icon/back.svg",
                          color: colorMainBlue,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          context.read<ManageCubit>().pageMinus();
                        },
                      );
                    }),
                    SizedBox(
                      width: 2.w,
                    ),
                    BlocBuilder<ManageCubit, ManageState>(
                        buildWhen: (pre, now) {
                      return pre.pageNow != now.pageNow;
                    }, builder: (context, state) {
                      return DotIndicator(
                        totalPage: findLength(state.lengthNow).toString(),
                        colorBorder: colorErrorPrimary,
                        pageIndex: state.pageNow.toString(),
                      );
                    }),
                    SizedBox(
                      width: 2.w,
                    ),
                    BlocBuilder<ManageCubit, ManageState>(
                        buildWhen: (pre, now) {
                      return pre.pageNow != now.pageNow;
                    }, builder: (context, state) {
                      return DotPageIndicator(
                        colorBorder: colorMainBlue,
                        icon: SvgPicture.asset(
                          "assets/icon/next.svg",
                          color: colorMainBlue,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          context.read<ManageCubit>().pagePlus();
                        },
                      );
                    }),
                  ]),
                ),
                sizedBox,
                LineContentItem(
                    colorBG: colorMainBlue,
                    title: "on schedule".tr(),
                    icon: const Icon(Icons.school)),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 25.h,
                      width: 90.w,
                      child: FutureBuilder<List<PreHWAPIModel>?>(
                          future: instance
                              .get<PreHWAPIRepo>()
                              .getOnGoingPreHW(instance.get<UserGlobal>().lop!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 10.h,
                                width: 50.w,
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
                                  // update thong tin pre global
                                  PreEventLocal.updatePreGlobal(
                                      snapshot.data![index]);
                                  return ItemCard(
                                    colorBorder:
                                        findColor(snapshot.data![index].color!),
                                    childCenter: Text(
                                      "${"week".tr()} ${snapshot.data![index].week}",
                                      style: GoogleFonts.aboreto(
                                          color: findColor(
                                              snapshot.data![index].color!),
                                          fontSize: 20),
                                    ),
                                    onTap: () {
                                      showPreHWDialog(snapshot.data![index]);
                                    },
                                    childRight: Text(
                                      "${snapshot.data![index].status}",
                                      style: GoogleFonts.aboreto(
                                          color: findColor(
                                              snapshot.data![index].color!),
                                          fontSize: 20),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          })),
                ),
              ],
            ),
          )),
    );
  }
}
