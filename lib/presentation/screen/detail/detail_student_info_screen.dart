import 'package:admin/application/utils/status/detail_user_status.dart';
import 'package:admin/data/remote/models/user_res.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/detail/widget/student_data.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/constants.dart';
import '../../../application/cons/text_style.dart';
import '../../../domain/bloc/detail_user/detail_user_cubit.dart';
import '../../widget/input_field_widget.dart';
import '../../widget/rounded_button.dart';
import '../../widget/scroll_date.dart';

class DetailStudentInfoScreen extends StatelessWidget {
  const DetailStudentInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, Routers.managerUser);
          }).show();
    }

    Future<void> showDeleteDoneDialog() {
      return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.topSlide,
          dismissOnTouchOutside: false,
          closeIcon: const Icon(Icons.close_fullscreen_outlined),
          title: 'delete successful'.tr(),
          descTextStyle: s20GgBarColorMainTeal,
          btnOkOnPress: () {
            Navigator.pushNamed(context, Routers.managerUser);
          }).show();
    }

    Future<void> showDeleteStudentDiaLog(String userID) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext contextBuild) {
          return BlocProvider.value(
              value: BlocProvider.of<DetailUserCubit>(context),
              child: AlertDialog(
                actions: [
                  AnimatedButton(
                    text: 'delete student'.tr(),
                    buttonTextStyle: s18GgfaBeeColorWhite,
                    color: colorErrorPrimary,
                    pressEvent: () {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              headerAnimationLoop: false,
                              animType: AnimType.topSlide,
                              dismissOnTouchOutside: false,
                              desc: "do you want to delete this student ?".tr(),
                              closeIcon:
                                  const Icon(Icons.close_fullscreen_outlined),
                              btnOkOnPress: () {
                                context
                                    .read<DetailUserCubit>()
                                    .deleteUser(userID);
                              },
                              btnCancelOnPress: () {})
                          .show();
                    },
                  )
                ],
              ));
        },
      );
    }

    final List<String> genders = ["Male", "Female"];
    UserAPIModel? user =
        ModalRoute.of(context)!.settings.arguments as UserAPIModel;
    String birthDate = user.birthDay!;
    return Scaffold(
      backgroundColor: colorSystemYeloow,
      body: BGHomeScreen(
        onBack: () {
          Navigator.pushNamed(context, Routers.managerUser);
        },
        textNow: "",
        colorTextAndIcon: Colors.black,
        child: Column(
          children: [
            //we will divide the screen into two parts
            //fixed height for first half
            Container(
              width: 100.w,
              height: 30.h,
              padding:
                  EdgeInsets.only(top: 2.h, bottom: 2.h, right: 5.w, left: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///STUDENT INFO
                      buildStudentInfo(user),

                      ///STUDENT PIC
                      SizedBox(
                        width: 40.w,
                        child: StudentPic(
                          picAddress:
                              user.linkImage,
                        ),
                      ),
                    ],
                  ),
                  sizedBox,

                  ///STUDENT SCORE
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StudentDataCard(
                        title: 'Attendance',
                        value: '90.02%',
                      ),
                      StudentDataCard(
                        title: 'Score',
                        value: 'B',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(right: 5.w, left: 5.w, top: 2.h, bottom: 2.h),
              height: 60.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(color: colorMainBlue),
                  color: colorSystemWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // -- IMAGE with ICON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Name
                        buildName(),

                        ///Class
                        buildClass(),
                      ],
                    ),

                    ///Mail
                    buildMail(),
                    SizedBox(height: 1.h),

                    ///SEX
                    buildGender(genders),

                    ///PHONE
                    buildPhone(),

                    ///DATE OF BIRTH
                    buildDOFB(birthDate),

                    ///ADD
                    buildAdd(),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///UPDATE
                        buildButtonEdit(showUpdateDoneDialog, user),

                        ///DELETE
                        buildButtonDelete(
                            showDeleteStudentDiaLog, showDeleteDoneDialog, user)
                      ],
                    )
                  ],
                ),
              ),
            )

            //other will use all the remaining height of screen
          ],
        ),
      ),
    );
  }

  SizedBox buildStudentInfo(UserAPIModel user) {
    return SizedBox(
      width: 40.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StudentName(name: user.fullName!),
              SizedBox(
                width: 5.w,
              ),
              StudentClass(studentClass: user.lop!),
            ],
          ),
          kHalfSizedBox,
          const Align(
              alignment: Alignment.center,
              child: StudentYear(studentYear: '2023-2024')),
        ],
      ),
    );
  }

  BlocConsumer<DetailUserCubit, DetailUserState> buildButtonDelete(
      Future<void> Function(String userID) showDeleteDialog,
      Future<void> Function() showDeleteDoneDialog,
      UserAPIModel user) {
    return BlocConsumer<DetailUserCubit, DetailUserState>(
        listener: (context, state) {
      if (state.status == DetailUserStatus.successDelete) {
        showDeleteDoneDialog();
      }
    }, builder: (context, state) {
      return RoundedButton(
          press: () {
            showDeleteDialog(user.key!);
          },
          color: colorSystemWhite,
          colorBorder: colorErrorPrimary,
          width: 40.w,
          height: 8.h,
          child: state.status == DetailUserStatus.deleting
              ? SizedBox(
                  height: 10.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorErrorPrimary,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Text(
                  'delete'.tr(),
                  style: s16f700ColorError,
                ));
    });
  }

  BlocConsumer<DetailUserCubit, DetailUserState> buildButtonEdit(
      Future<void> Function() showUpdateDoneDialog, UserAPIModel user) {
    return BlocConsumer<DetailUserCubit, DetailUserState>(
        listener: (context, state) {
      if (state.status == DetailUserStatus.successUpdate) {
        showUpdateDoneDialog();
      }
    }, builder: (context, state) {
      return RoundedButton(
          press: () {
            context.read<DetailUserCubit>().updateUser(user.key!);
          },
          color: colorSystemWhite,
          colorBorder: colorMainTealPri,
          width: 40.w,
          height: 8.h,
          child: state.status == DetailUserStatus.updating
              ? SizedBox(
                  height: 10.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorMainTealPri,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Text(
                  'edit'.tr(),
                  style: s16f700ColorMainTealPri,
                ));
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildDOFB(String birthDate) {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.birthMess != now.birthMess || pre.birthDate != now.birthDate;
    }, builder: (context, state) {
      return InputFieldWidget(
        readOnly: true,
        width: 90.w,
        height: 8.h,
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  builder: (_) {
                    return BlocProvider.value(
                        value: BlocProvider.of<DetailUserCubit>(context),
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
                                        year: ScrollViewDetailOptions(
                                            margin: EdgeInsets.all(10)),
                                        month: ScrollViewDetailOptions(
                                            margin: EdgeInsets.all(10)),
                                        day: ScrollViewDetailOptions(
                                            margin: EdgeInsets.all(10)),
                                      ),
                                      maximumDate: DateTime.now(),
                                      selectedDate: DateTime.now(),
                                      locale: const Locale('en'),
                                      onDateTimeChanged: (DateTime value) {
                                        final f = DateFormat('yyyy-MM-dd');
                                        birthDate = f.format(value).toString();
                                      }),
                                ),
                                RoundedButton(
                                  press: () {
                                    context
                                        .read<DetailUserCubit>()
                                        .birthChangedConfirm(birthDate);
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
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildPhone() {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.phoneMess != now.phoneMess;
    }, builder: (context, state) {
      return InputFieldWidget(
        onChanged: (value) {
          context.read<DetailUserCubit>().phoneChanged(value);
        },
        width: 90.w,
        height: 8.h,
        hintText: 'enter phone'.tr(),
        controller: TextEditingController(text: state.phone),
        icon: const Icon(
          LineAwesomeIcons.phone,
          color: Colors.black,
          size: 20,
        ),
        isHidden: state.phoneMess != "",
        validateText: state.phoneMess,
      );
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildGender(
      List<String> genders) {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.sex != now.sex;
    }, builder: (context, state) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(Icons.list, size: 16, color: colorMainBlue),
              const SizedBox(
                width: 4,
              ),
              Text(
                'choose gender'.tr(),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorMainBlue),
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
            context.read<DetailUserCubit>().sexChanged(value ?? "Male");
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
        ),
      );
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildMail() {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.mailMess != now.mailMess;
    }, builder: (context, state) {
      return InputFieldWidget(
        width: 90.w,
        height: 8.h,
        hintText: 'enter email'.tr(),
        readOnly: true,
        controller: TextEditingController(text: state.email),
        onChanged: (value) {
          context.read<DetailUserCubit>().mailChanged(value);
        },
        icon: const Icon(
          Icons.email_outlined,
          color: Colors.black,
          size: 20,
        ),
        isHidden: state.mailMess != "",
        validateText: state.mailMess,
      );
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildClass() {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.lopMess != now.lopMess;
    }, builder: (context, state) {
      return InputFieldWidget(
        width: 40.w,
        height: 8.h,
        readOnly: true,
        controller: TextEditingController(text: state.lop),
        hintText: 'enter class'.tr(),
        onChanged: (value) {
          context.read<DetailUserCubit>().lopChanged(value);
        },
        icon: const Icon(
          Icons.class_,
          color: Colors.black,
          size: 20,
        ),
        isHidden: state.lopMess != "",
        validateText: state.lopMess,
      );
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildName() {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.nameMess != now.nameMess;
    }, builder: (context, state) {
      return InputFieldWidget(
        width: 40.w,
        height: 8.h,
        controller: TextEditingController(text: state.name),
        hintText: 'enter name'.tr(),
        onChanged: (value) {
          context.read<DetailUserCubit>().nameChanged(value);
        },
        icon: const Icon(
          LineAwesomeIcons.user,
          color: Colors.black,
          size: 20,
        ),
        isHidden: state.nameMess != "",
        validateText: state.nameMess,
      );
    });
  }

  BlocBuilder<DetailUserCubit, DetailUserState> buildAdd() {
    return BlocBuilder<DetailUserCubit, DetailUserState>(buildWhen: (pre, now) {
      return pre.addMess != now.addMess;
    }, builder: (context, state) {
      return InputFieldWidget(
        onChanged: (value) {
          context.read<DetailUserCubit>().addChanged(value);
        },
        width: 90.w,
        height: 8.h,
        controller: TextEditingController(text: state.add),
        hintText: "enter address".tr(),
        icon: const Icon(
          LineAwesomeIcons.address_card,
          color: Colors.black,
          size: 20,
        ),
        isHidden: state.addMess != "",
        validateText: state.addMess,
      );
    });
  }
}
