import 'package:admin/application/utils/extension/notify_ex.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/constants.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../data/local/models/task_notify.dart';
import '../../../../data/local/repo/notify_task/notoify_task_repo.dart';
import '../../../../domain/bloc/notify_main/notify_main_cubit.dart';
import '../../../../main.dart';
import '../../../navigation/routers.dart';
import '../../../widget/rounded_button.dart';

class LocalNotifyMainScreen extends StatelessWidget {
  const LocalNotifyMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showInfoDialog(int id) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        desc: "choose".tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnOkText: "done".tr(),
        btnCancelText: "delete".tr(),
        btnOkOnPress: () {
          context.read<NotifyMainCubit>().completeNotifyTask(id);
        },
        btnCancelOnPress: () {
          context.read<NotifyMainCubit>().delete(id);
        },
      ).show();
    }

    return Scaffold(
        body: BGHomeScreen(
            textNow: 'local notify'.tr(),
            onBack: () {
              Navigator.pushNamed(context, Routers.home);
            },
            colorTextAndIcon: Colors.black,
            child: Container(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Column(children: [
                Center(
                  child: RoundedButton(
                      press: () {
                        Navigator.pushNamed(context, Routers.addNotify);
                      },
                      color: colorMainBlue,
                      width: 80.w,
                      height: 8.h,
                      child: Text(
                        'create'.tr(),
                        style: s30f500colorSysWhite,
                      )),
                ),
                Container(
                  height: 2.h,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2, color: colorGrayBG),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 5.h,
                  child: Center(
                    child: Text(
                      "history".tr(),
                      style: s20GgBarColorMainTeal,
                    ),
                  ),
                ),
                sizedBox,
                Container(
                  padding: EdgeInsets.only(
                    left: 3.w,
                  ),
                  height: 5.h,
                  width: 100.w,
                  child: BlocBuilder<NotifyMainCubit, NotifyMainState>(
                      buildWhen: (previousState, state) {
                    return previousState.timeNow != state.timeNow;
                  }, builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'day'.tr(),
                          style: GoogleFonts.abel(
                              color: colorMainTealPri, fontSize: 18),
                        ),
                        SizedBox(
                          child: Text(
                            state.timeNow,
                            style: GoogleFonts.abel(
                                color: colorMainTealPri, fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                ///BLOC DAY
                BlocBuilder<NotifyMainCubit, NotifyMainState>(
                    builder: (context, state) {
                  return DatePicker(
                    DateTime.now().subtract(const Duration(days: 6)),
                    height: 10.h,
                    width: 11.5.w,
                    dateTextStyle: const TextStyle(fontSize: 12),
                    dayTextStyle: const TextStyle(fontSize: 10),
                    monthTextStyle: const TextStyle(fontSize: 12),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: colorMainTealPri,
                    onDateChange: (date) {
                      context.read<NotifyMainCubit>().dayChange(date);
                    },
                  );
                }),
                sizedBox,
                SingleChildScrollView(
                    child: BlocBuilder<NotifyMainCubit, NotifyMainState>(
                        buildWhen: (previousState, state) {
                  return previousState.timeNow != state.timeNow;
                }, builder: (context, state) {
                  return SizedBox(
                      height: 50.h,
                      width: 100.w,
                      child: StreamBuilder(
                          stream: instance
                              .get<NotifyTaskLocalRepo>()
                              .getAllTaskByDay(state.timeNow),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 10.h,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: colorSystemWhite,
                                    strokeWidth: 3,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              return CustomScrollView(slivers: [
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        childCount: snapshot.data!.length,
                                        (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.5.h, bottom: 0.5.h),
                                    child: GestureDetector(
                                        onTap: () {
                                          showInfoDialog(
                                              snapshot.data![index].id);
                                        },
                                        child: TaskTile(snapshot.data![index]
                                            .toGetNotifyTask())),
                                  );
                                }))
                              ]);
                            } else {
                              return Center(
                                child: Text(
                                  'NOTHING ADDED !!'.tr(),
                                  style: GoogleFonts.abel(
                                      color: colorMainBlue, fontSize: 20),
                                ),
                              );
                            }
                          }));
                }))
              ]),
            )));
  }
}

class TaskTile extends StatelessWidget {
  final TaskNotify? task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 100.w,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? "blue"),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  task?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 10.h,
            width: 1.w,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "ON PROGRESS",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(String color) {
    switch (color) {
      case "blue":
        return colorMainBlue;
      case "red":
        return colorErrorPrimary;
      case "yellow":
        return colorSystemYeloow;
      default:
        return colorMainBlue;
    }
  }
}
