import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/constants.dart';
import '../../../../application/cons/text_style.dart';

class StudentName extends StatelessWidget {
  const StudentName({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(name, style: s16f700ColorSysWhite);
  }
}

class StudentClass extends StatelessWidget {
  const StudentClass({Key? key, required this.studentClass}) : super(key: key);
  final String studentClass;
  @override
  Widget build(BuildContext context) {
    return Text(studentClass, style: s16f700ColorSysWhite);
  }
}

class StudentYear extends StatelessWidget {
  const StudentYear({Key? key, required this.studentYear}) : super(key: key);

  final String studentYear;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: SizerUtil.deviceType == DeviceType.tablet ? 4.h : 3.h,
      child: Center(
        child: Text(studentYear, style: s16f700ColorSysWhite),
      ),
    );
  }
}

class StudentPic extends StatelessWidget {
  const StudentPic({Key? key, required this.picAddress}) : super(key: key);
  final String picAddress;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorSystemWhite,
      radius: SizerUtil.deviceType == DeviceType.tablet ? 10.w : 12.w,
      child: Padding(
        padding: const EdgeInsets.all(8), // Border radius
        child: ClipOval(
            child: picAddress != null
                ? Image.network(
                    picAddress,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    picAddress,
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }
}

class StudentDataCard extends StatelessWidget {
  const StudentDataCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: colorSystemWhite,
        border: Border.all(color: colorMainBlue,width: 2),
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
