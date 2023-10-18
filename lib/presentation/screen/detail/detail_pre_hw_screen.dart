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
import '../../widget/box_field.dart';
import '../../widget/rounded_button.dart';

class DetailPreHomeWorkScreen extends StatelessWidget {
  DetailPreHomeWorkScreen({Key? key}) : super(key: key);
  List<String> signList = ['+', '-', 'x', '/'];

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
                BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                    selector: (state) {
                  return state.week;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    typeText: TextInputType.number,
                    hintText: 'enter week'.tr(),
                    nameTitle: "week".tr(),
                    readOnly: true,
                    controller: TextEditingController(text: state),
                    width: 90.w,
                    height: 8.h,
                  );
                }),
                SizedBox(
                  height: 1.h,
                ),
                BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                    selector: (state) {
                  return state.numQ;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    hintText: "number of questions".tr(),
                    nameTitle: "number of questions".tr(),
                    readOnly: true,
                    controller: TextEditingController(text: state.toString()),
                    typeText: TextInputType.number,
                    width: 90.w,
                    height: 8.h,
                  );
                }),
                SizedBox(
                  height: 2.h,
                ),
                BlocSelector<DetailPreHWCubit, DetailPreHWState, List<String>>(
                    selector: (state) {
                  return state.sign;
                }, builder: (context, state) {
                  return SizedBox(
                    width: 90.w,
                    height: 8.h,
                    child: DropDownMultiSelect(
                      readOnly: true,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      options: signList,
                      selectedValues: state,
                      onChanged: (value) {},
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
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.sNum;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'start number'.tr(),
                        nameTitle: 'start number'.tr(),
                        readOnly: true,
                        controller:
                            TextEditingController(text: state.toString()),
                        typeText: TextInputType.number,
                        width: 40.w,
                        height: 8.h,
                      );
                    }),
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.eNum;
                    }, builder: (context, state) {
                      return InputFieldWidget(
                        hintText: 'end number'.tr(),
                        nameTitle: 'end number'.tr(),
                        readOnly: true,
                        controller:
                            TextEditingController(text: state.toString()),
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
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.dayStart;
                    }, builder: (context, state) {
                      return BoxField(
                        hintText: state,
                        nameTitle: 'start day'.tr(),
                        size: 42.w,
                        icon: const Icon(Icons.calendar_month),
                        onTapped: () async {},
                      );
                    }),
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.timeStart;
                    }, builder: (context, state) {
                      return BoxField(
                          hintText: state,
                          nameTitle: 'start time'.tr(),
                          size: 42.w,
                          icon: const Icon(Icons.timer),
                          onTapped: () async {});
                    }),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.dayEnd;
                    }, builder: (context, state) {
                      return BoxField(
                        hintText: state,
                        nameTitle: 'end day'.tr(),
                        size: 42.w,
                        icon: const Icon(Icons.calendar_month),
                        onTapped: () async {},
                      );
                    }),
                    BlocSelector<DetailPreHWCubit, DetailPreHWState, String>(
                        selector: (state) {
                      return state.timeEnd;
                    }, builder: (context, state) {
                      return BoxField(
                          hintText: state,
                          nameTitle: 'end time'.tr(),
                          size: 42.w,
                          icon: const Icon(Icons.timer),
                          onTapped: () async {});
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
                          BlocSelector<DetailPreHWCubit, DetailPreHWState,
                              String>(selector: (state) {
                            return state.color;
                          }, builder: (context, state) {
                            return CircleAvatar(
                                backgroundColor: colorMainBlue,
                                radius: 15,
                                child: state == "blue"
                                    ? const Icon(
                                        (Icons.done),
                                        color: colorSystemWhite,
                                        size: 16,
                                      )
                                    : Container());
                          }),
                          BlocSelector<DetailPreHWCubit, DetailPreHWState,
                              String>(selector: (state) {
                            return state.color;
                          }, builder: (context, state) {
                            return CircleAvatar(
                                backgroundColor: colorSystemYeloow,
                                radius: 15,
                                child: state == "yellow"
                                    ? const Icon(
                                        (Icons.done),
                                        color: colorSystemWhite,
                                        size: 16,
                                      )
                                    : Container());
                          }),
                          BlocSelector<DetailPreHWCubit, DetailPreHWState,
                              String>(selector: (state) {
                            return state.color;
                          }, builder: (context, state) {
                            return CircleAvatar(
                                backgroundColor: colorErrorPrimary,
                                radius: 15,
                                child: state == "red"
                                    ? const Icon(
                                        (Icons.done),
                                        color: colorSystemWhite,
                                        size: 16,
                                      )
                                    : Container());
                          }),
                        ],
                      ),
                    ),
                    BlocConsumer<DetailPreHWCubit, DetailPreHWState>(
                        listener: (context, state) {
                      if (state.status == AddPreHWStatus.error) {
                        showUpdateFailDialog();
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
                          width: 40.w,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
