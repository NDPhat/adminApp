import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:admin/presentation/widget/rounded_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/constants.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/status/login_status.dart';
import '../../../domain/bloc/login/login_cubit.dart';
import '../../widget/input_field_widget.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loginFailDialog() {
      return AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              headerAnimationLoop: false,
              animType: AnimType.topSlide,
              dismissOnTouchOutside: false,
              closeIcon: const Icon(Icons.close_fullscreen_outlined),
              title: 'login fail'.tr(),
              descTextStyle: s20GgBarColorMainTeal,
              btnOkOnPress: () {})
          .show();
    }

    return Scaffold(
      backgroundColor: colorSystemYeloow,
      body: SingleChildScrollView(
        child: BGHomeScreen(
          textNow: "",
          colorTextAndIcon: Colors.black,
          onBack: () {
            Navigator.pushNamed(context, Routers.welCome);
          },
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 35.h,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/login/login.png",
                      height: 20.h,
                    ),
                    sizedBox,
                    Text('hi'.tr(),
                        style: GoogleFonts.cabin(
                            color: colorSystemWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    Text('sign in to continue'.tr(),
                        style: GoogleFonts.cabin(
                            color: colorSystemWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    sizedBox,
                  ],
                ),
              ),
              Container(
                height: 55.5.h,
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: colorSystemWhite,
                  //reusable radius,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.h),
                      topLeft: Radius.circular(10.h)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: Column(
                        children: [
                          BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (pre, now) {
                            return pre.emailError != now.emailError;
                          }, builder: (BuildContext context, state) {
                            return InputFieldWidget(
                              hintText: 'enter email'.tr(),
                              nameTitle: 'enter email'.tr(),
                              width: 80.w,
                              height: 8.h,
                              onChanged: (value) {
                                context.read<LoginCubit>().emailChanged(value);
                              },
                              validateText: state.emailError,
                              isHidden: state.emailError != "",
                              icon: const Icon(Icons.email_outlined),
                            );
                          }),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (pre, now) {
                            return pre.passError != now.passError;
                          }, builder: (BuildContext context, state) {
                            return InputFieldWidget(
                              hintText: 'enter password'.tr(),
                              nameTitle: 'enter password'.tr(),
                              width: 80.w,
                              height: 8.h,
                              onChanged: (value) {
                                context.read<LoginCubit>().passChanged(value);
                              },
                              iconRight: _obscureText
                                  ? GestureDetector(
                                      onTap: () {
                                        _toggle();
                                      },
                                      child: const Icon(Icons.visibility_off))
                                  : GestureDetector(
                                      onTap: () {
                                        _toggle();
                                      },
                                      child: const Icon(Icons.visibility)),
                              validateText: state.passError,
                              isHidden: state.passError != "",
                              showValue: _obscureText,
                              icon: const Icon(Icons.fingerprint),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 10.h,
                      alignment: Alignment.center,
                      child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                        if (state.status == LoginStatus.success) {
                          Navigator.pushNamed(context, Routers.home);
                        } else if (state.status == LoginStatus.error) {
                          loginFailDialog();
                        }
                      }, builder: (context, state) {
                        return RoundedButton(
                            press: () async {
                              context.read<LoginCubit>().clearData();
                              await context
                                  .read<LoginCubit>()
                                  .loginAppWithEmailAndPass();
                            },
                            color: colorSystemWhite,
                            colorBorder: colorSystemYeloow,
                            width: 80.w,
                            height: 8.h,
                            child: state.status == LoginStatus.onLoading
                                ? SizedBox(
                                    height: 10.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: colorSystemYeloow,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'go'.tr().toString(),
                                    style: s16f700ColorSysYel,
                                  ));
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
