import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/status/add_notify.dart';
import '../../../../application/utils/time_change/format.dart';
import '../../../../domain/bloc/add_notifi/add_notify_cubit.dart';
import '../../../navigation/routers.dart';
import '../../../widget/box_container.dart';
import '../../../widget/input_field_widget.dart';
import '../../../widget/rounded_button.dart';
import '../../../widget/scroll_date.dart';

class AddNotifyScreen extends StatelessWidget {
  AddNotifyScreen({Key? key}) : super(key: key);
  final f = DateFormat('MM/dd/yyyy');
  final l = DateFormat('hh:mm aa');
  String startTime = DateFormat('hh:mm aa').format(DateTime.now());
  final listRemind = [
    "0 minutes early",
    "5 minutes early",
    "10 minutes early",
    "15 minutes early",
    "20 minutes early",
    "25 minutes early",
    "30 minutes early",
  ];

  @override
  Widget build(BuildContext context) {
    showDoneDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        desc: "done".tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnOkOnPress: () {},
      ).show();
    }

    showErrorDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        desc: "fail".tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnOkOnPress: () {},
      ).show();
    }

    return Scaffold(
      backgroundColor: colorSystemYeloow,
      body: BGHomeScreen(
        textNow: "",
        colorTextAndIcon: colorSystemWhite,
        onBack: () {
          Navigator.pushNamed(context, Routers.notifyMainScreen);
        },
        child: Column(
          children: [
            Container(
              height: 10.h,
              color: colorSystemYeloow,
              child: const Center(
                child: Icon(
                  LineAwesomeIcons.bell,
                  color: colorSystemWhite,
                  size: 60,
                ),
              ),
            ),
            Container(
              height: 80.h,
              decoration: BoxDecoration(
                  color: colorSystemWhite,
                  border: Border.all(color: colorSystemYeloow),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w))),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 4.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<AddNotifyCubit, AddNotifyState>(
                          buildWhen: (pre, now) {
                        return pre.titleMess != now.titleMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          nameTitle: "Title",
                          hintText: 'Enter title',
                          onChanged: (value) {
                            context.read<AddNotifyCubit>().titleChanged(value);
                          },
                          validateText: state.titleMess,
                          isHidden: state.titleMess != "",
                          width: 90.w,
                          height: 8.h,
                        );
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<AddNotifyCubit, AddNotifyState>(
                          buildWhen: (pre, now) {
                        return pre.noteMess != now.noteMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          hintText: 'Enter note',
                          nameTitle: "Note",
                          onChanged: (value) {
                            context.read<AddNotifyCubit>().noteChanged(value);
                          },
                          validateText: state.noteMess,
                          isHidden: state.noteMess != "",
                          width: 90.w,
                          height: 8.h,
                        );
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<AddNotifyCubit, AddNotifyState>(
                          buildWhen: (pre, now) {
                        return pre.dateSaveTask != now.dateSaveTask;
                      }, builder: (context, state) {
                        return BoxField(
                            hintText: state.dateSaveTask,
                            nameTitle: 'Date',
                            size: 100.w,
                            icon: const Icon(Icons.calendar_month),
                            onTapped: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25)),
                                ),
                                builder: (_) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: SizedBox(
                                        height: 30.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                              child: MyScrollDatePicker(
                                                scrollViewOptions:
                                                    const DatePickerScrollViewOptions(
                                                  year: ScrollViewDetailOptions(
                                                      margin:
                                                          EdgeInsets.all(10)),
                                                  month:
                                                      ScrollViewDetailOptions(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10)),
                                                  day: ScrollViewDetailOptions(
                                                      margin:
                                                          EdgeInsets.all(10)),
                                                ),
                                                maximumDate: DateTime.now().add(
                                                    const Duration(days: 30)),
                                                selectedDate: DateTime.now(),
                                                locale: const Locale('en'),
                                                onDateTimeChanged:
                                                    (DateTime value) {
                                                  context
                                                      .read<AddNotifyCubit>()
                                                      .dateTimeChange(
                                                          formatDateInputNotify
                                                              .format(value));
                                                },
                                                widthScreen: 80.w,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RoundedButton(
                                                  press: () {
                                                    context
                                                        .read<AddNotifyCubit>()
                                                        .emitDateTimeChange(
                                                            state.dateSaveTask);
                                                    Navigator.pop(context);
                                                  },
                                                  color: colorMainBlue,
                                                  width: 90.w,
                                                  height: 8.h,
                                                  child: const Text("GO"),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                }));
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<AddNotifyCubit, AddNotifyState>(
                              buildWhen: (pre, now) {
                            return pre.timeStart != now.timeStart;
                          }, builder: (context, state) {
                            return BoxField(
                                hintText: state.timeStart,
                                nameTitle: 'Start time',
                                size: 42.w,
                                icon: const Icon(Icons.timer),
                                onTapped: () async {
                                  var timePic = await showTimePicker(
                                      initialEntryMode:
                                          TimePickerEntryMode.inputOnly,
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: int.parse(
                                              state.timeStart.split(":")[0]),
                                          minute: int.parse(state.timeStart
                                              .split(":")[1]
                                              .split(" ")[0])));
                                  context
                                      .read<AddNotifyCubit>()
                                      .emitStartTimeChange((timePic ??
                                              TimeOfDay(
                                                  hour: DateTime.now().hour,
                                                  minute:
                                                      DateTime.now().minute))
                                          .format(context));
                                });
                          }),
                          BlocBuilder<AddNotifyCubit, AddNotifyState>(
                              buildWhen: (pre, now) {
                            return pre.timeEnd != now.timeEnd;
                          }, builder: (context, state) {
                            return BoxField(
                                hintText: state.timeEnd,
                                nameTitle: 'End time',
                                size: 42.w,
                                icon: const Icon(Icons.timer),
                                onTapped: () async {
                                  var timePic = await showTimePicker(
                                      initialEntryMode:
                                          TimePickerEntryMode.inputOnly,
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: int.parse(
                                              state.timeEnd.split(":")[0]),
                                          minute: int.parse(state.timeEnd
                                              .split(":")[1]
                                              .split(" ")[0])));
                                  //compare timeEnd va timeStart
                                  if (convertTimeDayToDouble(timePic ??
                                          TimeOfDay(
                                              hour: DateTime.now().hour,
                                              minute: DateTime.now().minute)) <
                                      convertTimeDayToDouble(convertToTimeOfDay(
                                          state.timeStart))) {
                                    AlertDialog(
                                      content: const Text(
                                        "EndTime must be greater than StartTime !!",
                                        textAlign: TextAlign.center,
                                        style: s20f700ColorErrorPro,
                                      ),
                                      actions: <Widget>[
                                        RoundedButton(
                                          press: () {
                                            Navigator.pop(context);
                                          },
                                          color: colorMainBlue,
                                          width: 40.w,
                                          height: 8.h,
                                          child: Text("back".tr()),
                                        )
                                      ],
                                    );
                                    context
                                        .read<AddNotifyCubit>()
                                        .emitEndTimeChange((TimeOfDay(
                                                hour: DateTime.now().hour,
                                                minute:
                                                    DateTime.now().minute + 10))
                                            .format(context));
                                  } else {
                                    context
                                        .read<AddNotifyCubit>()
                                        .emitEndTimeChange((timePic ??
                                                TimeOfDay(
                                                    hour: DateTime.now().hour,
                                                    minute:
                                                        DateTime.now().minute))
                                            .format(context));
                                  }
                                });
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<AddNotifyCubit, AddNotifyState>(
                          buildWhen: (pre, now) {
                        return pre.remind != now.remind;
                      }, builder: (context, state) {
                        return BoxField(
                            hintText: state.remind,
                            nameTitle: 'Remind',
                            size: 100.w,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            onTapped: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  builder: (_) {
                                    return SizedBox(
                                        height: 60.h,
                                        child: BlocProvider.value(
                                            value:
                                                BlocProvider.of<AddNotifyCubit>(
                                                    context),
                                            child: DropDownRemind(
                                              listData: listRemind,
                                            )));
                                  });
                            });
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 30.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<AddNotifyCubit, AddNotifyState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<AddNotifyCubit>()
                                            .colorChange("blue");
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: colorMainBlue,
                                          radius: 15,
                                          child: state.color == "blue"
                                              ? const Icon(
                                                  (Icons.done),
                                                  color: colorSystemWhite,
                                                  size: 16,
                                                )
                                              : Container()),
                                    );
                                  }),
                                  BlocBuilder<AddNotifyCubit, AddNotifyState>(
                                      buildWhen: (pre, now) {
                                    return pre.color != now.color;
                                  }, builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<AddNotifyCubit>()
                                            .colorChange("yellow");
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: colorSystemYeloow,
                                          radius: 15,
                                          child: state.color == "yellow"
                                              ? const Icon(
                                                  (Icons.done),
                                                  color: colorSystemWhite,
                                                  size: 16,
                                                )
                                              : Container()),
                                    );
                                  }),
                                  BlocBuilder<AddNotifyCubit, AddNotifyState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<AddNotifyCubit>()
                                            .colorChange("red");
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: colorErrorPrimary,
                                          radius: 15,
                                          child: state.color == "red"
                                              ? const Icon(
                                                  (Icons.done),
                                                  color: colorSystemWhite,
                                                  size: 16,
                                                )
                                              : Container()),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            BlocListener<AddNotifyCubit, AddNotifyState>(
                                listener: (context, state) {
                                  if (state.status == AddNotifiStatus.error) {
                                    showErrorDialog();
                                    context
                                        .read<AddNotifyCubit>()
                                        .clearOldDataErrorForm();
                                  } else if (state.status ==
                                      AddNotifiStatus.success) {
                                    showDoneDialog();
                                  }
                                },
                                child: RoundedButton(
                                    press: () {
                                      context
                                          .read<AddNotifyCubit>()
                                          .saveTaskToLocal();
                                    },
                                    colorBorder: colorSystemYeloow,
                                    color: colorSystemWhite,
                                    width: 45.w,
                                    height: 6.h,
                                    child: Text(
                                      'create'.tr(),
                                      style: GoogleFonts.aBeeZee(
                                          color: colorSystemYeloow,
                                          fontSize: 20),
                                    )))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownRemind extends StatelessWidget {
  const DropDownRemind({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List<String> listData;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 50.h,
        child: ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(top: 3.h, left: 5.w, right: 5.w),
                  child: BlocBuilder<AddNotifyCubit, AddNotifyState>(
                      buildWhen: (pre, now) {
                    return pre.indexRemind != now.indexRemind;
                  }, builder: (contextBL, state) {
                    return ListTile(
                        onTap: () {
                          contextBL.read<AddNotifyCubit>().remindChange(index);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              listData[index],
                              style: GoogleFonts.aBeeZee(
                                  color: colorGreyTetiary, fontSize: 16),
                            ),
                            Visibility(
                                visible: index == state.indexRemind,
                                child: const Icon(
                                  Icons.check,
                                  color: colorMainTealPri,
                                ))
                          ],
                        ));
                  }));
            }),
      ),
      BlocBuilder<AddNotifyCubit, AddNotifyState>(builder: (context, state) {
        return RoundedButton(
          press: () {
            context
                .read<AddNotifyCubit>()
                .remindSelected(listData[state.indexRemind]);
            Navigator.pop(context);
          },
          colorBorder: colorSystemYeloow,
          color: colorSystemWhite,
          width: 90.w,
          height: 8.h,
          child: Text(
            'choose'.tr(),
            style: GoogleFonts.aBeeZee(color: colorSystemYeloow, fontSize: 20),
          ),
        );
      })
    ]);
  }
}

class BoxField extends StatelessWidget {
  String hintText;
  String nameTitle;
  double size;
  Icon icon;
  final VoidCallback onTapped;
  BoxField(
      {Key? key,
      required this.hintText,
      required this.nameTitle,
      required this.size,
      required this.icon,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapped,
        child: BoxFieldContainer(
          size: size,
          nameTitle: nameTitle,
          child: Container(
            padding: const EdgeInsets.only(
                bottom: 10.0, left: 10.0, right: 10.0, top: 10),
            decoration: BoxDecoration(
                border: Border.all(color: colorGreyTetiary),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(hintText), icon],
            ),
          ),
        ));
  }
}
