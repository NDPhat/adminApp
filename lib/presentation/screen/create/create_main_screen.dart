import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/create/widget/item_card.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../application/utils/find_color/find_color.dart';
import '../../../data/event_local/update_pre_now.dart';
import '../../../main.dart';
import '../../widget/line_content_item_widget.dart';
import '../../widget/rounded_button.dart';

class CreateMainScreen extends StatelessWidget {
  const CreateMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGHomeScreen(
        textNow: 'Create',
        colorTextAndIcon: Colors.black,
        child: Padding(
          padding:  EdgeInsets.only(left: 5.w,right: 5.w),
          child: Column(
            children: [
              const LineContentItem(
                title: 'User',
                icon: Icon(LineAwesomeIcons.user),
                colorBG: colorMainBlue,
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 100.w,
                child: Center(
                  child: RoundedButton(
                      press: () async {
                        Navigator.pushNamed(context, Routers.createUser);
                      },
                      color: colorMainBlue,
                      width: 80.w,
                      height: 5.h,
                      child: const Text(
                        'CREATE',
                        style: s30f500colorSysWhite,
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 1,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: colorGrayBG),
                  ),
                ),
              ),
              const LineContentItem(
                  colorBG: colorMainBlue,
                  title: 'HOME WORK',
                  icon: Icon(Icons.home_work)),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 100.w,
                child: Center(
                  child: RoundedButton(
                      press: () async {
                        Navigator.pushNamed(context, Routers.createPre);
                      },
                      color: colorMainBlue,
                      width: 80.w,
                      height: 5.h,
                      child: const Text(
                        'CREATE',
                        style: s30f500colorSysWhite,
                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
