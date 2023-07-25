import 'package:admin/presentation/navigation/routers.dart';
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
import '../../widget/app_bar_widget.dart';
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
    return Scaffold(
      backgroundColor: colorMainBlue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100.w,
                  height: 35.h,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/login/login_bot.png",
                        height: 20.h,
                      ),
                      sizedBox,
                      Text('Hi Teacher',
                          style: GoogleFonts.cabin(
                              color: colorSystemWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      Text('Sign in to continue',
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
                        height: 37.h,
                        child: Column(
                          children: [
                            BlocBuilder<LoginCubit, LoginState>(
                                buildWhen: (pre, now) {
                              return pre.emailError != now.emailError;
                            }, builder: (BuildContext context, state) {
                              return InputFieldWidget(
                                hintText: 'Email your email',
                                nameTitle: 'Your email',
                                width: 80.w,
                                height: 8.h,
                                onChanged: (value) {
                                  context
                                      .read<LoginCubit>()
                                      .emailChanged(value);
                                },
                                validateText: state.emailError,
                                isHidden: state.emailError != "",
                                icon: Icon(Icons.email_outlined),
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
                                hintText: 'Email your password',
                                nameTitle: 'Your password',
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
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 10.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ForgetPassWidget(onForget: () {}),
                            SizedBox(
                              height: 10.h,
                              child: BlocConsumer<LoginCubit, LoginState>(
                                  listener: (context, state) {
                                if (state.status == LoginStatus.success) {
                                  Navigator.pushNamed(
                                      context, Routers.home);
                                } else if (state.status == LoginStatus.error) {
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
                                              child: Text('LOGIN FAIL',
                                                  style: s16f700ColorError,
                                                  textAlign: TextAlign.center),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          border: Border.all(
                                                              color:
                                                                  colorSystemYeloow)),
                                                      child: const Center(
                                                        child: Text(
                                                          'BACK',
                                                          style:
                                                              s15f700ColorErrorPri,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          )));
                                }
                              }, builder: (context, state) {
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundColor: colorMainBlue,
                                  child: state.status == LoginStatus.onLoading
                                      ? SizedBox(
                                          height: 10.h,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: colorSystemWhite,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        )
                                      : IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            context
                                                .read<LoginCubit>()
                                                .clearData();
                                            await context
                                                .read<LoginCubit>()
                                                .loginAppWithEmailAndPass();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                          )),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ForgetPassWidget extends StatelessWidget {
  const ForgetPassWidget({
    Key? key,
    required this.onForget,
  }) : super(key: key);
  final VoidCallback onForget;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10.h,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: onForget,
          child: const Text('Forget password ?',
              style: TextStyle(
                  decoration: TextDecoration.underline, color: colorMainBlue)),
        ));
  }
}
