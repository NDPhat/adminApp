import 'package:admin/presentation/navigation/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/status/login_status.dart';
import '../../../domain/bloc/login/login_cubit.dart';
import '../../../main.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              AppBarWidget(
                size: size,
                onBack: () {
                  Navigator.pop(context);
                },
                textTitle: 'Login Screen',
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    alignment: Alignment.center,
                    width: size.width,
                    child: Image.asset(
                      "assets/images/login/login_top.png",
                      height: size.height * 0.3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.width * 0.1,
                        right: size.width * 0.1),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: const Text(
                            "WELCOME BACK",
                            style: s20f700ColorMBlue,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        SizedBox(
                          height: size.height * 0.23,
                          child: Column(
                            children: [
                              BlocBuilder<LoginCubit, LoginState>(
                                  buildWhen: (pre, now) {
                                return pre.emailError != now.emailError;
                              }, builder: (BuildContext context, state) {
                                return InputFieldWidget(
                                  hintText: 'Email your email',
                                  width: size.width * 0.8,
                                  height: size.height * 0.1,
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
                                height: size.height * 0.025,
                              ),
                              BlocBuilder<LoginCubit, LoginState>(
                                  buildWhen: (pre, now) {
                                return pre.passError != now.passError;
                              }, builder: (BuildContext context, state) {
                                return InputFieldWidget(
                                  hintText: 'Email your password',
                                  width: size.width * 0.8,
                                  height: size.height * 0.1,
                                  onChanged: (value) {
                                    context
                                        .read<LoginCubit>()
                                        .passChanged(value);
                                  },
                                  iconRight: _obscureText
                                      ? GestureDetector(
                                          onTap: () {
                                            _toggle();
                                          },
                                          child:
                                              const Icon(Icons.visibility_off))
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
                          height: size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BlocConsumer<LoginCubit, LoginState>(
                                  listener: (context, state) {
                                if (state.status == LoginStatus.success) {
                                  Navigator.pushNamed(
                                      context, Routers.dashboard);
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
                                          height: size.height * 0.1,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: colorSystemWhite,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        )
                                      : IconButton(
                                          color: Colors.white,
                                          onPressed: ()  {
                                           context.read<LoginCubit>().loginAppWithEmailAndPass();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                          )),
                                );
                              })
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
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.75),
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: Image.asset(
                "assets/images/login/login_bot.png",
                height: size.height * 0.25,
                width: size.width * 0.5,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
