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
import '../../../../domain/bloc/add_task/add_pre_cubit.dart';
import '../../../widget/box_field.dart';
import '../../../widget/rounded_button.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class CreatePreHomeWorkScreen extends StatelessWidget {
  CreatePreHomeWorkScreen({Key? key}) : super(key: key);
  final f = DateFormat('MM/dd/yyyy');
  final l = DateFormat('hh:mm aa');
  String startTime = DateFormat('hh:mm aa').format(DateTime.now());
  List<String> signList = ['+', '-', 'x', '/'];
  List<String> selectedSignList = [];
  @override
  Widget build(BuildContext context) {
    Future<void> showCreateFailDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'create fail'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
      ).show();
    }

    Future<void> showCreateAlreadyExistDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'this week already created'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {},
      ).show();
    }

    Future<void> showCreateDoneDialog() {
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.topSlide,
          dismissOnTouchOutside: false,
          closeIcon: const Icon(Icons.close_fullscreen_outlined),
          title: 'create successful'.tr(),
          descTextStyle: s20GgBarColorMainTeal,
          btnOkOnPress: () {
            Navigator.pushNamed(context, Routers.createMainScreen);
          }).show();
    }

    return Scaffold(
      body: BGHomeScreen(
        textNow: "create home work".tr(),
        colorTextAndIcon: Colors.black,
        onBack: () {
          Navigator.pushNamed(context, Routers.createMainScreen);
        },
        child: Container(
          height: 90.h,
          padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<AddPreHWCubit, AddPreHWState>(
                    buildWhen: (pre, now) {
                  return pre.weekMess != now.weekMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    typeText: TextInputType.number,
                    hintText: 'enter week'.tr(),
                    nameTitle: "week".tr(),
                    onChanged: (value) {
                      context.read<AddPreHWCubit>().weekChanged(value);
                    },
                    validateText: state.weekMess,
                    isHidden: state.weekMess != "",
                    width: 90.w,
                    height: 8.h,
                  );
                }),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<AddPreHWCubit, AddPreHWState>(
                    buildWhen: (pre, now) {
                  return pre.numQMess != now.numQMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    hintText: 'number of questions'.tr(),
                    typeText: TextInputType.number,
                    nameTitle: 'number of questions'.tr(),
                    onChanged: (value) {
                      context.read<AddPreHWCubit>().numQChanged(value);
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
                BlocBuilder<AddPreHWCubit, AddPreHWState>(
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
                      selectedValues: selectedSignList,
                      onChanged: (value) {
                        context.read<AddPreHWCubit>().signChanged(value);
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
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.sNumMess != now.sNumMess;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'start number'.tr(),
                        nameTitle: 'start number'.tr(),
                        typeText: TextInputType.number,
                        onChanged: (value) {
                          context.read<AddPreHWCubit>().sNumChanged(value);
                        },
                        validateText: state.sNumMess,
                        isHidden: state.sNumMess != "",
                        width: 40.w,
                        height: 8.h,
                      );
                    }),
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.eNumMess != now.eNumMess;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'end number'.tr(),
                        nameTitle: 'end number'.tr(),
                        onChanged: (value) {
                          context.read<AddPreHWCubit>().eNumChanged(value);
                        },
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
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
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
                            context.read<AddPreHWCubit>().dayStartChange(
                                (formatDateInput.format(datePicked)));
                          } else {
                            context.read<AddPreHWCubit>().dayStartChange(
                                formatDateInput.format(DateTime.now()));
                          }
                        },
                      );
                    }),
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
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
                            context.read<AddPreHWCubit>().emitStartTimeChange(
                                (timePic ??
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
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
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
                            context.read<AddPreHWCubit>().dayEndChange(
                                (formatDateInput.format(datePicked)));
                          } else {
                            context.read<AddPreHWCubit>().dayEndChange(
                                formatDateInput.format(DateTime.now()));
                          }
                        },
                      );
                    }),
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
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
                                    width: 90.w,
                                    height: 8.h,
                                    child: Text('go'.tr()),
                                  )
                                ],
                              );
                              context.read<AddPreHWCubit>().emitEndTimeChange(
                                  (TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute + 10))
                                      .format(context));
                            } else {
                              context.read<AddPreHWCubit>().emitEndTimeChange(
                                  (timePic ??
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
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 1.h,
                  ),
                  child: SizedBox(
                    width: 100.w,
                    child: Text(
                      'color'.tr(),
                      style: s15f700ColorBlueMa,
                    ),
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
                          BlocBuilder<AddPreHWCubit, AddPreHWState>(
                              buildWhen: (pre, now) {
                            return pre.color != now.color;
                          }, builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<AddPreHWCubit>()
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
                          BlocBuilder<AddPreHWCubit, AddPreHWState>(
                              buildWhen: (pre, now) {
                            return pre.color != now.color;
                          }, builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<AddPreHWCubit>()
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
                          BlocBuilder<AddPreHWCubit, AddPreHWState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<AddPreHWCubit>()
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
                    BlocConsumer<AddPreHWCubit, AddPreHWState>(
                        listener: (context, state) {
                      if (state.status == AddPreHWStatus.error) {
                        showCreateFailDialog();
                        context.read<AddPreHWCubit>().clearOldDataErrorForm();
                      } else if (state.status == AddPreHWStatus.success) {
                        showCreateDoneDialog();
                      } else if (state.status == AddPreHWStatus.sameWeek) {
                        showCreateAlreadyExistDialog();
                      }
                    }, builder: (context, state) {
                      return RoundedButton(
                          press: () {
                            context.read<AddPreHWCubit>().createPreHW();
                          },
                          color: colorSystemWhite,
                          colorBorder: colorSystemYeloow,
                          width: 40.w,
                          height: 5.h,
                          child: state.status == AddPreHWStatus.submit
                              ? SizedBox(
                                  height: 10.h,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: colorSystemWhite,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Text(
                                  'create'.tr(),
                                  style: s16f700ColorSysYel,
                                ));
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
