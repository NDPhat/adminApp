import 'package:admin/application/utils/status/add_user_status.dart';
import 'package:admin/domain/bloc/add_user/add_user_cubit.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:admin/presentation/widget/input_field_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../../application/cons/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../application/cons/text_style.dart';
import '../../../widget/rounded_button.dart';
import '../../../widget/scroll_date.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({Key? key}) : super(key: key);

  final List<String> genders = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
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
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }

    Future<void> showCreateFailDialog() {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.topSlide,
        dismissOnTouchOutside: false,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'create fail'.tr(),
        descTextStyle: s20GgBarColorMainTeal,
        btnOkOnPress: () {},
      ).show();
    }

    return Scaffold(
      body: BGHomeScreen(
        textNow: "create student".tr(),
        onBack: () {
          Navigator.pushNamed(context, Routers.createMainScreen);
        },
        colorTextAndIcon: Colors.black,
        child: Container(
          height: 90.h,
          padding: EdgeInsets.only( left: 5.w, right: 5.w,bottom: 2.h),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                // -- IMAGE with ICON
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.nameMess != now.nameMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    width: 90.w,
                    height: 8.h,
                    hintText: 'enter name'.tr(),
                    nameTitle: "name".tr(),
                    onChanged: (value) {
                      context.read<AddUserCubit>().nameChanged(value);
                    },
                    icon: const Icon(
                      LineAwesomeIcons.user,
                      color: Colors.black,
                      size: 20,
                    ),
                    isHidden: state.nameMess != "",
                    validateText: state.nameMess,
                  );
                }),

                ///Mail
                SizedBox(height: 1.h),
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.mailMess != now.mailMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    width: 90.w,
                    height: 8.h,
                    hintText: 'enter email'.tr(),
                    nameTitle: "email".tr(),
                    onChanged: (value) {
                      context.read<AddUserCubit>().mailChanged(value);
                    },
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    isHidden: state.mailMess != "",
                    validateText: state.mailMess,
                  );
                }),
                SizedBox(height: 1.h),

                ///PASS
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.passMess != now.passMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    width: 90.w,
                    height: 8.h,
                    nameTitle: "password".tr(),
                    hintText: 'enter password'.tr(),
                    onChanged: (value) {
                      context.read<AddUserCubit>().passChanged(value);
                    },
                    icon: const Icon(
                      Icons.password,
                      color: Colors.black,
                      size: 20,
                    ),
                    isHidden: state.passMess != "",
                    validateText: state.passMess,
                  );
                }),

                ///SEX
                SizedBox(height: 1.h),
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.sex != now.sex;
                }, builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            const Icon(Icons.list,
                                size: 16, color: colorMainBlue),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'choose gender'.tr(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colorMainBlue),
                              ),
                            ),
                          ],
                        ),
                        items: genders
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: colorMainBlue,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: state.sex,
                        onChanged: (value) {
                          context
                              .read<AddUserCubit>()
                              .sexChanged(value ?? "Male");
                        },
                        buttonStyleData: ButtonStyleData(
                          width: 90.w,
                          height: 8.h,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: colorSystemWhite,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: colorMainBlue,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 100,
                          width: 45.w,
                          padding: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: colorSystemWhite,
                          ),
                          elevation: 8,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  );
                }),

                ///PHONE
                SizedBox(height: 1.h),
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.phoneMess != now.phoneMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    onChanged: (value) {
                      context.read<AddUserCubit>().phoneChanged(value);
                    },
                    width: 90.w,
                    height: 8.h,
                    nameTitle: "phone".tr(),
                    hintText: 'enter phone'.tr(),
                    icon: const Icon(
                      LineAwesomeIcons.phone,
                      color: Colors.black,
                      size: 20,
                    ),
                    isHidden: state.phoneMess != "",
                    validateText: state.phoneMess,
                  );
                }),

                ///DATE OF BIRTH
                SizedBox(height: 1.h),
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.birthMess != now.birthMess ||
                      pre.birthDate != now.birthDate;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    readOnly: true,
                    width: 90.w,
                    height: 8.h,
                    nameTitle: "birthday".tr(),
                    hintText: 'enter birthDay'.tr(),
                    controller: TextEditingController(text: state.birthDate),
                    isHidden: state.birthMess != "",
                    validateText: state.birthMess,
                    icon: const Icon(
                      LineAwesomeIcons.birthday_cake,
                      color: Colors.black,
                      size: 20,
                    ),
                    iconRight: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ),
                              builder: (_) {
                                return BlocProvider.value(
                                    value:
                                        BlocProvider.of<AddUserCubit>(context),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: SizedBox(
                                        height: 30.h,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 23.h,
                                              child: MyScrollDatePicker(
                                                  widthScreen: 100.w,
                                                  scrollViewOptions:
                                                      const DatePickerScrollViewOptions(
                                                    year:
                                                        ScrollViewDetailOptions(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10)),
                                                    month:
                                                        ScrollViewDetailOptions(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10)),
                                                    day:
                                                        ScrollViewDetailOptions(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10)),
                                                  ),
                                                  maximumDate: DateTime.now(),
                                                  selectedDate: DateTime.now(),
                                                  locale: const Locale('en'),
                                                  onDateTimeChanged:
                                                      (DateTime value) {
                                                    final f = DateFormat(
                                                        'yyyy-MM-dd');
                                                    context
                                                        .read<AddUserCubit>()
                                                        .birthChanged(f
                                                            .format(value)
                                                            .toString());
                                                  }),
                                            ),
                                            RoundedButton(
                                              press: () {
                                                Navigator.pop(context);
                                              },
                                              color: colorMainBlue,
                                              width: 80.w,
                                              height: 6.h,
                                              child: Text(
                                                'done'.tr(),
                                                style: s14f500colorSysWhite,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                        },
                        icon: const Icon(Icons.calendar_month)),
                  );
                }),

                ///ADD
                SizedBox(height: 1.h),
                BlocBuilder<AddUserCubit, AddUserState>(buildWhen: (pre, now) {
                  return pre.addMess != now.addMess;
                }, builder: (context, state) {
                  return InputFieldWidget(
                    onChanged: (value) {
                      context.read<AddUserCubit>().addChanged(value);
                    },
                    width: 90.w,
                    height: 8.h,
                    nameTitle: "address".tr(),
                    hintText: "enter address".tr(),
                    icon: const Icon(
                      LineAwesomeIcons.address_card,
                      color: Colors.black,
                      size: 20,
                    ),
                    isHidden: state.addMess != "",
                    validateText: state.addMess,
                  );
                }),
                SizedBox(height: 2.h),
                BlocConsumer<AddUserCubit, AddUserState>(
                    listener: (context, state) {
                  if (state.status == AddUserStatus.success) {
                    showCreateDoneDialog();
                  } else if (state.status == AddUserStatus.error) {
                    showCreateFailDialog();
                  }
                }, builder: (context, state) {
                  return RoundedButton(
                      press: () {
                        context.read<AddUserCubit>().createUser();
                      },
                      color: colorSystemWhite,
                      colorBorder: colorSystemYeloow,
                      width: 80.w,
                      height: 8.h,
                      child: state.status == AddUserStatus.submit
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
                              style: s16f700ColorSysYel,
                            ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@override
typedef OnPickImageCallback = void Function(String source);
