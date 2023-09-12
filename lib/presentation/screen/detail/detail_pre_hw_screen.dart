import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/domain/bloc/detail_pre/detail_pre_cubit.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:admin/presentation/widget/input_field_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/status/add_pre_hw.dart';
import '../../../../application/utils/time_change/format.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import '../../widget/box_field.dart';
import '../../widget/rounded_button.dart';

class DetailPreHomeWorkScreen extends StatelessWidget {
  DetailPreHomeWorkScreen({Key? key}) : super(key: key);
  final f = DateFormat('MM/dd/yyyy');
  final l = DateFormat('hh:mm aa');
  String startTime = DateFormat('hh:mm aa').format(DateTime.now());
  List<String> signList = ['+', '-', 'x', '/'];
  List<String> selectedSignList = [];

  @override
  Widget build(BuildContext context) {
    PreHWAPIModel data =
        ModalRoute.of(context)!.settings.arguments as PreHWAPIModel;
    Future<void> showUpdateFailDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'update fail'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
      ).show();
    }

    Future<void> showUpdateDoneDialog() {
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.topSlide,
          dismissOnTouchOutside: false,
          closeIcon: const Icon(Icons.close_fullscreen_outlined),
          title: 'update successful'.tr(),
          descTextStyle: s20GgBarColorMainTeal,
          btnOkOnPress: () {
            Navigator.pushNamed(context, Routers.managerMainScreen);
          }).show();
    }

    Future<void> showUpdateHWDiaLog() {
      return AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              headerAnimationLoop: false,
              animType: AnimType.topSlide,
              title: 'finish this home work'.tr(),
              dismissOnTouchOutside: false,
              closeIcon: const Icon(Icons.close_fullscreen_outlined),
              btnOkOnPress: () {
                context
                    .read<DetailPreHWCubit>()
                    .updatePreHWToDone(data.key!, data.week!, data.lop!);
              },
              btnCancelOnPress: () {})
          .show();
    }

    return Scaffold(
      backgroundColor: colorSystemWhite,
      body: BGHomeScreen(
        onBack: () {
          Navigator.pop(context);
        },
        textNow: "home work".tr(),
        onPressHome: () {},
        colorTextAndIcon: Colors.black,
        child: Container(
          height: 90.h,
          padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                    buildWhen: (pre, now) {
                  return pre.weekMess != now.weekMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    typeText: TextInputType.number,
                    hintText: 'enter week'.tr(),
                    nameTitle: "week".tr(),
                    readOnly: data.status == "EXPIRED" ? true : false,
                    onChanged: (value) {
                      context.read<DetailPreHWCubit>().weekChanged(value);
                    },
                    controller: TextEditingController(text: state.week),
                    validateText: state.weekMess,
                    isHidden: state.weekMess != "",
                    width: 90.w,
                    height: 8.h,
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                    buildWhen: (pre, now) {
                  return pre.numQMess != now.numQMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    hintText: "number of questions".tr(),
                    nameTitle: "number of questions".tr(),
                    readOnly: data.status == "EXPIRED" ? true : false,
                    controller:
                        TextEditingController(text: state.numQ.toString()),
                    typeText: TextInputType.number,
                    onChanged: (value) {
                      context.read<DetailPreHWCubit>().numQChanged(value);
                    },
                    validateText: state.numQMess,
                    isHidden: state.numQMess != "",
                    width: 90.w,
                    height: 8.h,
                  );
                }),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                    buildWhen: (pre, now) {
                  return pre.sign != now.sign;
                }, builder: (context, state) {
                  return SizedBox(
                    width: 90.w,
                    height: 8.h,
                    child: DropDownMultiSelect(
                      readOnly: true,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      options: signList,
                      selectedValues: state.sign,
                      onChanged: (value) {
                        context.read<DetailPreHWCubit>().signChanged(value);
                      },
                      whenEmpty: 'sign'.tr(),
                    ),
                  );
                }),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.sNumMess != now.sNumMess;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'start number'.tr(),
                        nameTitle: 'start number'.tr(),
                        readOnly: data.status == "EXPIRED" ? true : false,
                        controller:
                            TextEditingController(text: state.sNum.toString()),
                        typeText: TextInputType.number,
                        onChanged: (value) {
                          context.read<DetailPreHWCubit>().sNumChanged(value);
                        },
                        validateText: state.sNumMess,
                        isHidden: state.sNumMess != "",
                        width: 40.w,
                        height: 8.h,
                      );
                    }),
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.eNumMess != now.eNumMess;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'end number'.tr(),
                        nameTitle: 'end number'.tr(),
                        readOnly: data.status == "EXPIRED" ? true : false,
                        onChanged: (value) {
                          context.read<DetailPreHWCubit>().eNumChanged(value);
                        },
                        controller:
                            TextEditingController(text: state.eNum.toString()),
                        validateText: state.eNumMess,
                        isHidden: state.eNumMess != "",
                        typeText: TextInputType.number,
                        width: 40.w,
                        height: 8.h,
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.dayStart != now.dayStart;
                    }, builder: (context, state) {
                      return BoxField(
                        hintText: state.dayStart,
                        nameTitle: 'start day'.tr(),
                        size: 42.w,
                        icon: const Icon(Icons.calendar_month),
                        onTapped: () async {
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(
                            context,
                            initialDate: DateTime.now(),
                            dateFormat: "yyyy-MM-dd",
                            locale: DateTimePickerLocale.es,
                            looping: true,
                          );
                          if (datePicked != null) {
                            context.read<DetailPreHWCubit>().dayStartChange(
                                (formatDateInput.format(datePicked)));
                          } else {
                            context.read<DetailPreHWCubit>().dayStartChange(
                                formatDateInput.format(DateTime.now()));
                          }
                        },
                      );
                    }),
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.timeStart != now.timeStart;
                    }, builder: (context, state) {
                      return BoxField(
                          hintText: state.timeStart,
                          nameTitle: 'start time'.tr(),
                          size: 42.w,
                          icon: const Icon(Icons.timer),
                          onTapped: () async {
                            var timePic = await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.inputOnly,
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: int.parse(
                                        state.timeStart.split(":")[0]),
                                    minute: int.parse(state.timeStart
                                        .split(":")[1]
                                        .split(" ")[0])));
                            context
                                .read<DetailPreHWCubit>()
                                .emitStartTimeChange((timePic ??
                                        TimeOfDay(
                                            hour: DateTime.now().hour,
                                            minute: DateTime.now().minute))
                                    .format(context));
                          });
                    }),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.dayEnd != now.dayEnd;
                    }, builder: (context, state) {
                      return BoxField(
                        hintText: state.dayEnd,
                        nameTitle: 'end day'.tr(),
                        size: 42.w,
                        icon: const Icon(Icons.calendar_month),
                        onTapped: () async {
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(
                            context,
                            initialDate: DateTime.now(),
                            dateFormat: "yyyy-MM-dd",
                            locale: DateTimePickerLocale.es,
                            looping: true,
                          );
                          if (datePicked != null) {
                            context.read<DetailPreHWCubit>().dayEndChange(
                                (formatDateInput.format(datePicked)));
                          } else {
                            context.read<DetailPreHWCubit>().dayEndChange(
                                formatDateInput.format(DateTime.now()));
                          }
                        },
                      );
                    }),
                    BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.timeEnd != now.timeEnd;
                    }, builder: (context, state) {
                      return BoxField(
                          hintText: state.timeEnd,
                          nameTitle: 'end time'.tr(),
                          size: 42.w,
                          icon: const Icon(Icons.timer),
                          onTapped: () async {
                            var timePic = await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.inputOnly,
                                context: context,
                                initialTime: TimeOfDay(
                                    hour:
                                        int.parse(state.timeEnd.split(":")[0]),
                                    minute: int.parse(state.timeEnd
                                        .split(":")[1]
                                        .split(" ")[0])));
                            //compare timeEnd va timeStart
                            if (convertTimeDayToDouble(timePic ??
                                    TimeOfDay(
                                        hour: DateTime.now().hour,
                                        minute: DateTime.now().minute)) <
                                convertTimeDayToDouble(
                                    convertToTimeOfDay(state.timeStart))) {
                              AlertDialog(
                                content: Text(
                                  "end time must be greater than start time !!"
                                      .tr(),
                                  textAlign: TextAlign.center,
                                  style: s20f700ColorErrorPro,
                                ),
                                actions: <Widget>[
                                  RoundedButton(
                                    press: () {
                                      Navigator.pop(context);
                                    },
                                    color: colorMainBlue,
                                    width: 100.w,
                                    height: 8.h,
                                    child: Text('go'.tr()),
                                  )
                                ],
                              );
                              context
                                  .read<DetailPreHWCubit>()
                                  .emitEndTimeChange((TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute + 10))
                                      .format(context));
                            } else {
                              context
                                  .read<DetailPreHWCubit>()
                                  .emitEndTimeChange((timePic ??
                                          TimeOfDay(
                                              hour: DateTime.now().hour,
                                              minute: DateTime.now().minute))
                                      .format(context));
                            }
                          });
                    }),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'color'.tr(),
                    style: s15f700ColorBlueMa,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                              buildWhen: (pre, now) {
                            return pre.color != now.color;
                          }, builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailPreHWCubit>()
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
                          BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                              buildWhen: (pre, now) {
                            return pre.color != now.color;
                          }, builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailPreHWCubit>()
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
                          BlocBuilder<DetailPreHWCubit, DetailPreHWState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailPreHWCubit>()
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
                    BlocConsumer<DetailPreHWCubit, DetailPreHWState>(
                        listener: (context, state) {
                      if (state.status == AddPreHWStatus.error) {
                        showDialog(
                            context: context,
                            builder: (ctx) => Center(
                                    child: AlertDialog(
                                  shape: ShapeBorder.lerp(const StadiumBorder(),
                                      const StadiumBorder(), 100),
                                  backgroundColor: colorSystemWhite,
                                  title: const Center(
                                    child: Text('UPDATE FAIL',
                                        style: s16f700ColorError,
                                        textAlign: TextAlign.center),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: colorSystemYeloow)),
                                            child: const Center(
                                              child: Text(
                                                'BACK',
                                                style: s15f700ColorErrorPri,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                )));
                        context
                            .read<DetailPreHWCubit>()
                            .clearOldDataErrorForm();
                      } else if (state.status == AddPreHWStatus.success) {
                        showDialog(
                            context: context,
                            builder: (ctx) => Center(
                                    child: AlertDialog(
                                  shape: ShapeBorder.lerp(const StadiumBorder(),
                                      const StadiumBorder(), 100),
                                  backgroundColor: colorSystemWhite,
                                  title: const Center(
                                    child: Text('DONE!!',
                                        style: s16f700ColorError,
                                        textAlign: TextAlign.center),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: colorSystemYeloow)),
                                            child: const Center(
                                              child: Text(
                                                'BACK',
                                                style: s15f700ColorErrorPri,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routers.dashboard);
                                        }),
                                  ],
                                )));
                      } else if (state.status == AddPreHWStatus.sameWeek) {
                        showDialog(
                            context: context,
                            builder: (ctx) => Center(
                                    child: AlertDialog(
                                  shape: ShapeBorder.lerp(const StadiumBorder(),
                                      const StadiumBorder(), 100),
                                  backgroundColor: colorSystemWhite,
                                  title: const Center(
                                    child: Text('WEEK DA TON TAI!!',
                                        style: s16f700ColorError,
                                        textAlign: TextAlign.center),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: colorSystemYeloow)),
                                            child: const Center(
                                              child: Text(
                                                'BACK',
                                                style: s15f700ColorErrorPri,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                )));
                      }
                    }, builder: (context, state) {
                      return RoundedButton(
                          press: () {
                            if (data.status == "GOING") {
                              context
                                  .read<DetailPreHWCubit>()
                                  .updatePreHW(data.key!);
                            }
                          },
                          color: colorSystemWhite,
                          colorBorder: colorMainBlue,
                          width: 40.w,
                          height: 8.h,
                          child: data.status == "GOING"
                              ? (state.status == AddPreHWStatus.submit
                                  ? SizedBox(
                                      height: 10.h,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: colorMainBlue,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'save'.tr().toString(),
                                      style: s16f700ColorBlueMa,
                                    ))
                              : Text(
                                  'done'.tr().toString(),
                                  style: s16f700ColorBlueMa,
                                ));
                    }),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                // update status to done
                BlocConsumer<DetailPreHWCubit, DetailPreHWState>(
                    listener: (context, state) {
                  if (state.status == AddPreHWStatus.error) {
                    showUpdateFailDialog();
                    context.read<DetailPreHWCubit>().clearOldDataErrorForm();
                  } else if (state.status == AddPreHWStatus.success) {
                    showUpdateDoneDialog();
                  }
                }, builder: (context, state) {
                  return RoundedButton(
                      press: () {
                        showUpdateHWDiaLog();
                      },
                      color: colorSystemWhite,
                      colorBorder: colorErrorPrimary,
                      width: 90.w,
                      height: 8.h,
                      child: state.status == AddPreHWStatus.updating
                          ? SizedBox(
                              height: 5.h,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: colorErrorPrimary,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                          : const Text(
                              'DONE TASK',
                              style: s16f700ColorError,
                            ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
