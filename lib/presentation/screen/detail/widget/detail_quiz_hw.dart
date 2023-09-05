import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/presentation/widget/bg_home_screen.dart';
import 'package:admin/presentation/widget/bg_listview_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/cons/color.dart';
import '../../../../main.dart';
import '../../../widget/anwser_widget.dart';

class DetailQuizHWScreen extends StatelessWidget {
  const DetailQuizHWScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        body: BGHomeScreen(
      onBack: () {
        Navigator.pop(context);
      },
      colorTextAndIcon: Colors.black,
      textNow: 'review answer'.tr().toString(),
      onPressHome: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: BackGroundListView(
          colorBG: colorMainTealPri,
          width: 90.w,
          height: 90.h,
          content: 'review answer'.tr(),
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: FutureBuilder<List<QuizHWAPIModel>?>(
                future:
                    instance.get<TeacherAPIRepo>().getAllQuizHWByResultID(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: colorMainBlue,
                          strokeWidth: 5,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: snapshot.data!.length,
                                (context, index) {
                          return AnswerWidget(
                            quiz: snapshot.data![index].quiz.toString(),
                            answer: snapshot.data![index].answer.toString(),
                            answerSelect:
                                snapshot.data![index].answerSelect.toString(),
                            quizInfo: snapshot.data![index].infoQuiz!,
                          );
                        }))
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ),
      ),
    ));
  }
}
