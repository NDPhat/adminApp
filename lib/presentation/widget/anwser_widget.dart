import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../application/cons/color.dart';
import '../../application/cons/constants.dart';
import '../../application/cons/text_style.dart';

class AnswerWidget extends StatelessWidget {
  AnswerWidget(
      {Key? key,
      required this.answer,
      required this.answerSelect,
      required this.quizInfo,
      required this.quiz})
      : super(key: key);
  final bool quizInfo;
  final String quiz;
  final String answer;
  final String answerSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: quizInfo ? colorMainTealPri : colorErrorPrimary),
              color: colorSystemWhite,
              borderRadius: BorderRadius.all(Radius.circular(5.w))),
          padding:
              EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 2.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AnswerDetailWidget(
              quiz: quiz,
              answer: answer,
              answerSelect: answerSelect,
              quizInfo: quizInfo,
            ),
            Center(
              child: Text(
                answer,
                style: GoogleFonts.abel(
                    color: quizInfo ? colorMainTealPri : colorErrorPrimary,
                    fontSize: 16),
              ),
            )
          ]),
        ),
        sizedBox
      ],
    );
  }
}

class AnswerDetailWidget extends StatelessWidget {
  AnswerDetailWidget({
    super.key,
    required this.answer,
    required this.answerSelect,
    required this.quizInfo,
    required this.quiz,
  });

  final String answer;
  final String answerSelect;
  final String quiz;
  final bool quizInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: colorSystemWhite,
                radius: 30,
                child: quizInfo
                    ? const Icon(
                  (Icons.done),
                  color: colorMainTealPri,
                  size: 30,
                )
                    : const Icon(
                  (Icons.close),
                  color: colorErrorPrimary,
                  size: 30,
                )),
            Column(
              children: [
                Text(
                  quiz,
                  style: GoogleFonts.abel(
                      color: quizInfo ? colorMainTealPri : colorErrorPrimary,
                      fontSize: 20),
                ),
                SizedBox(height: 1.h),
                Text(
                  "Answer Select = $answerSelect",
                  style:  GoogleFonts.abel(
                      color: quizInfo ? colorMainTealPri : colorErrorPrimary,
                      fontSize: 16),
                )
              ],
            )
          ],
        ));
  }
}
