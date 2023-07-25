import 'package:admin/application/utils/status/add_user_status.dart';
import 'package:admin/domain/bloc/add_user/add_user_cubit.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/widget/input_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../../application/cons/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../application/cons/text_style.dart';
import '../../../widget/app_bar_widget.dart';
import '../../../widget/rounded_button.dart';
import '../../../widget/scroll_date.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({
    Key? key,
  });
  final List<String> genders = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            onBack: () {
              Navigator.pop(context);
            },
            textTitle: 'Create User',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 2.h, bottom: 10.h, left: 2.w, right: 2.w),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // -- IMAGE with ICON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<AddUserCubit, AddUserState>(
                              buildWhen: (pre, now) {
                            return pre.nameMess != now.nameMess;
                          }, builder: (context, state) {
                            return InputFieldWidget(
                              width: 45.w,
                              height: 8.h,
                              hintText: 'Your name',
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
                          BlocBuilder<AddUserCubit, AddUserState>(
                              buildWhen: (pre, now) {
                            return pre.lopMess != now.lopMess;
                          }, builder: (context, state) {
                            return InputFieldWidget(
                              width: 45.w,
                              height: 8.h,
                              hintText: 'Your class',
                              onChanged: (value) {
                                context.read<AddUserCubit>().lopChanged(value);
                              },
                              icon: const Icon(
                                Icons.class_,
                                color: Colors.black,
                                size: 20,
                              ),
                              isHidden: state.lopMess != "",
                              validateText: state.lopMess,
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.mailMess != now.mailMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          width: 90.w,
                          height: 8.h,
                          hintText: 'Your email',
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
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.passMess != now.passMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          width: 90.w,
                          height: 8.h,
                          hintText: 'Your password',
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
                      SizedBox(height: 1.h),
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.sex != now.sex;
                      }, builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: const Row(
                                children: [
                                  Icon(Icons.list,
                                      size: 16, color: colorMainBlue),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Choose gender',
                                      style: TextStyle(
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
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
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
                      SizedBox(height: 1.h),
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.phoneMess != now.phoneMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          onChanged: (value) {
                            context.read<AddUserCubit>().phoneChanged(value);
                          },
                          width: 90.w,
                          height: 8.h,
                          hintText: 'Your phone',
                          icon: const Icon(
                            LineAwesomeIcons.phone,
                            color: Colors.black,
                            size: 20,
                          ),
                          isHidden: state.phoneMess != "",
                          validateText: state.phoneMess,
                        );
                      }),
                      SizedBox(height: 1.h),
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.birthMess != now.birthMess ||
                            pre.birthDate != now.birthDate;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          readOnly: true,
                          width: 90.w,
                          height: 8.h,
                          hintText: 'Your birthDate',
                          controller:
                              TextEditingController(text: state.birthDate),
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
                                          value: BlocProvider.of<AddUserCubit>(
                                              context),
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
                                                              margin: EdgeInsets
                                                                  .all(10)),
                                                          month: ScrollViewDetailOptions(
                                                              margin: EdgeInsets
                                                                  .all(10)),
                                                          day: ScrollViewDetailOptions(
                                                              margin: EdgeInsets
                                                                  .all(10)),
                                                        ),
                                                        maximumDate:
                                                            DateTime.now(),
                                                        selectedDate:
                                                            DateTime.now(),
                                                        locale:
                                                            const Locale('en'),
                                                        onDateTimeChanged:
                                                            (DateTime value) {
                                                          final f = DateFormat(
                                                              'yyyy-MM-dd');
                                                          context
                                                              .read<
                                                                  AddUserCubit>()
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
                                                    child: const Text(
                                                      'Done',
                                                      style:
                                                          s14f500colorSysWhite,
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
                      SizedBox(height: 1.h),
                      BlocBuilder<AddUserCubit, AddUserState>(
                          buildWhen: (pre, now) {
                        return pre.addMess != now.addMess;
                      }, builder: (context, state) {
                        return InputFieldWidget(
                          onChanged: (value) {
                            context.read<AddUserCubit>().addChanged(value);
                          },
                          width: 90.w,
                          height: 8.h,
                          hintText: "Your add",
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
                                      child: Text('Create success',
                                          style: s16f700ColorError,
                                          textAlign: TextAlign.center),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      color:
                                                          colorSystemYeloow)),
                                              child: const Center(
                                                child: Text(
                                                  'DONE',
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
                        }
                      }, builder: (context, state) {
                        return RoundedButton(
                            press: () {
                              context.read<AddUserCubit>().createUser();
                            },
                            color: colorMainBlue,
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
                                : const Text(
                                    'GO',
                                    style: s16f700ColorSysWhite,
                                  ));
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@override
typedef OnPickImageCallback = void Function(String source);
