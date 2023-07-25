import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/app_bar_widget.dart';
import 'package:admin/presentation/widget/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/status/add_pre_hw.dart';
import '../../../../application/utils/time_change/format.dart';
import '../../../../domain/bloc/add_task/add_pre_cubit.dart';
import '../../../widget/box_field.dart';
import '../../../widget/rounded_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            onBack: () {
              Navigator.pop(context);
            },
            textTitle: 'Create Pre Home work',
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<AddPreHWCubit, AddPreHWState>(
                        buildWhen: (pre, now) {
                      return pre.weekMess != now.weekMess;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        typeText: TextInputType.number,
                        hintText: 'Enter week ',
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
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AddPreHWCubit, AddPreHWState>(
                            buildWhen: (pre, now) {
                          return pre.numQMess != now.numQMess;
                        }, builder: (context, state) {
                          return InputFieldWidget(
                            hintText: 'Number quiz ',
                            typeText: TextInputType.number,
                            onChanged: (value) {
                              context.read<AddPreHWCubit>().numQChanged(value);
                            },
                            validateText: state.numQMess,
                            isHidden: state.numQMess != "",
                            width: 40.w,
                            height: 8.h,
                          );
                        }),
                        BlocBuilder<AddPreHWCubit, AddPreHWState>(
                            buildWhen: (pre, now) {
                          return pre.sign != now.sign;
                        }, builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: SizedBox(
                              width: 40.w,
                              height: 8.h,
                              child: DropDownMultiSelect(
                                readOnly: true,
                                icon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                options: signList,
                                selectedValues: selectedSignList,
                                onChanged: (value) {
                                  context
                                      .read<AddPreHWCubit>()
                                      .signChanged(value);
                                },
                                whenEmpty: 'Sign',
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AddPreHWCubit, AddPreHWState>(
                            buildWhen: (pre, now) {
                          return pre.sNumMess != now.sNumMess;
                        }, builder: (context, state) {
                          return InputFieldWidget(
                            hintText: 'Start number',
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
                            hintText: 'End number',
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
                      height: 3.h,
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
                            nameTitle: 'Day start',
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
                              nameTitle: 'Time start',
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
                                    .read<AddPreHWCubit>()
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
                      height: 3.h,
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
                            nameTitle: 'Day end',
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
                                    convertTimeDayToDouble(
                                        convertToTimeOfDay(state.timeStart))) {
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
                                        width: 90.w,
                                        height: 8.h,
                                        child: Text('GO'),
                                      )
                                    ],
                                  );
                                  context
                                      .read<AddPreHWCubit>()
                                      .emitEndTimeChange((TimeOfDay(
                                              hour: DateTime.now().hour,
                                              minute:
                                                  DateTime.now().minute + 10))
                                          .format(context));
                                } else {
                                  context
                                      .read<AddPreHWCubit>()
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
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 1.h,
                      ),
                      child: SizedBox(
                        width: 100.w,
                        child: const Text(
                          'Color',
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
                            showDialog(
                                context: context,
                                builder: (ctx) => Center(
                                        child: AlertDialog(
                                      shape: ShapeBorder.lerp(
                                          const StadiumBorder(),
                                          const StadiumBorder(),
                                          100),
                                      backgroundColor: colorSystemWhite,
                                      title: const Center(
                                        child: Text('CREATE FAIL',
                                            style: s16f700ColorError,
                                            textAlign: TextAlign.center),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color:
                                                            colorSystemYeloow)),
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
                                .read<AddPreHWCubit>()
                                .clearOldDataErrorForm();
                          } else if (state.status == AddPreHWStatus.success) {
                            showDialog(
                                context: context,
                                builder: (ctx) => Center(
                                        child: AlertDialog(
                                      shape: ShapeBorder.lerp(
                                          const StadiumBorder(),
                                          const StadiumBorder(),
                                          100),
                                      backgroundColor: colorSystemWhite,
                                      title: const Center(
                                        child: Text('DONE!!',
                                            style: s16f700ColorError,
                                            textAlign: TextAlign.center),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color:
                                                            colorSystemYeloow)),
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
                                      shape: ShapeBorder.lerp(
                                          const StadiumBorder(),
                                          const StadiumBorder(),
                                          100),
                                      backgroundColor: colorSystemWhite,
                                      title: const Center(
                                        child: Text('WEEK DA TON TAI!!',
                                            style: s16f700ColorError,
                                            textAlign: TextAlign.center),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color:
                                                            colorSystemYeloow)),
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
                                context.read<AddPreHWCubit>().createPreHW();
                              },
                              color: colorMainBlue,
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
                                  : const Text(
                                      'Create',
                                      style: s14f500colorSysWhite,
                                    ));
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
