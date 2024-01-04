import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../application/cons/color.dart';
import '../../../../../application/cons/text_style.dart';
import '../../../../../application/utils/status/update_pass.dart';
import '../../../../../domain/bloc/update_pass/update_pass_cubit.dart';
import '../../../../navigation/routers.dart';
import '../../../../widget/input_field_widget.dart';
import '../../../../widget/rounded_button.dart';

class ChangePassWordScreen extends StatelessWidget {
  const ChangePassWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> showDoneDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'update successful'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnCancelOnPress: () {
          Navigator.pushNamed(context, Routers.profile);
        },
        btnOkOnPress: () {},
      ).show();
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: BGHomeScreen(
      onBack: () {
          Navigator.pushNamed(context, Routers.profile);
      },
      colorTextAndIcon: Colors.black,
      textNow: 'change password'.tr().toString(),
      onPressHome: () {},
      child: SingleChildScrollView(
          child: Container(
            height: 85.h,
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/image_update_pass.png',
                  height: 25.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'change your password.'.tr(),
                    style: s16f400ColorGreyTe,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 45.h,
                  child: Column(
                    children: [
                      BlocBuilder<UpdatePassCubit, UpdatePassState>(
                          buildWhen: (pre, now) {
                        return pre.oldPassErrorMessage != now.oldPassErrorMessage;
                      }, builder: (BuildContext context, state) {
                        return InputFieldWidget(
                          hintText: 'your old password'.tr(),
                          width: 80.w,
                          height: 8.h,
                          nameTitle: "old password".tr(),
                          onChanged: (value) {
                            context.read<UpdatePassCubit>().oldPassChanged(value);
                          },
                          validateText: state.oldPassErrorMessage,
                          isHidden: state.oldPassErrorMessage != "",
                          icon: const Icon(Icons.fingerprint),
                        );
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<UpdatePassCubit, UpdatePassState>(
                          buildWhen: (pre, now) {
                        return pre.passErrorMessage != now.passErrorMessage;
                      }, builder: (BuildContext context, state) {
                        return InputFieldWidget(
                          hintText: 'your new password'.tr(),
                          width: 80.w,
                          height: 8.h,
                          nameTitle: "new password".tr(),
                          onChanged: (value) {
                            context.read<UpdatePassCubit>().passChanged(value);
                          },
                          validateText: state.passErrorMessage,
                          isHidden: state.passErrorMessage != "",
                          icon: const Icon(Icons.fingerprint),
                        );
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<UpdatePassCubit, UpdatePassState>(
                          buildWhen: (pre, now) {
                        return pre.confirmPassErrorMessage !=
                            now.confirmPassErrorMessage;
                      }, builder: (BuildContext context, state) {
                        return InputFieldWidget(
                          hintText: 're-your new password'.tr(),
                          width: 80.w,
                          height: 8.h,
                          nameTitle: "re-new password".tr(),
                          onChanged: (value) {
                            context
                                .read<UpdatePassCubit>()
                                .confirmPassChange(value);
                          },
                          validateText: state.confirmPassErrorMessage,
                          isHidden: state.confirmPassErrorMessage != "",
                          icon: const Icon(Icons.key),
                        );
                      }),
                    ],
                  ),
                ),
                BlocConsumer<UpdatePassCubit, UpdatePassState>(
                    listener: (context, state) {
                  if (state.status == UpdatePassStatus.success) {
                    showDoneDialog();
                  }
                }, builder: (context, state) {
                  return RoundedButton(
                      press: () {
                        context.read<UpdatePassCubit>().clearData();
                        context
                            .read<UpdatePassCubit>()
                            .changePassWithCredentials();
                      },
                      color: colorMainBlue,
                      width: 80.w,
                      height: 8.h,
                      child: state.status == UpdatePassStatus.onLoading
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
                              'go'.tr(),
                              style: s20f700ColorSysWhite,
                            ));
                })
              ],
            ),
          ),
      ),
    ),
        ));
  }
}
