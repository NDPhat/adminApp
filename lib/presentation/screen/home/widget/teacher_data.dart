import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../application/cons/constants.dart';
import '../../../../../main.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../data/local/models/user_global.dart';

class TeacherName extends StatelessWidget {
  const TeacherName({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Hi ', style: s16f700ColorSysWhite),
        Text(instance.get<UserGlobal>().fullName!, style: s16f700ColorSysWhite),
      ],
    );
  }
}

class TeacherPicture extends StatelessWidget {
  TeacherPicture({Key? key, required this.picAddress}) : super(key: key);
  final String picAddress;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorSystemWhite,
      radius: SizerUtil.deviceType == DeviceType.tablet ? 10.w : 12.w,
      child: Padding(
        padding: const EdgeInsets.all(8), // Border radius
        child: ClipOval(
            child: instance.get<UserGlobal>().onLogin == true
                ? Image.network(
                    instance.get<UserGlobal>().linkImage!,
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

class TeacherDataCard extends StatelessWidget {
  const TeacherDataCard({
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
      height: 12.h,
      decoration: BoxDecoration(
        color: colorSystemWhite,
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
