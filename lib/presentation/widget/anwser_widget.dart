import 'package:flutter/material.dart';

import '../../application/cons/color.dart';
import '../../application/cons/text_style.dart';

class AnswerWidget extends StatelessWidget {
  AnswerWidget(
      {Key? key,
        required this.size,
        required this.answer,
        required this.answerSelect,
        required this.quizInfo,
        required this.quiz})
      : super(key: key);
  final Size size;
  final bool quizInfo;
  final String quiz;
  final String answer;
  final String answerSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: quizInfo ? colorBlueQuaternery : colorSystemErrorTer,
        ),
        padding: EdgeInsets.only(
            left: size.width * 0.02,
            right: size.width * 0.02,
            top: size.height * 0.01,
            bottom: size.height * 0.02),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AnswerDetailWidget(
            size: size,
            quiz: quiz,
            answer: answer,
            answerSelect: answerSelect,
            quizInfo: quizInfo,
          ),
          Center(
            child: Text(
              answer,
              style: s20f700ColorMBlue,
            ),
          )
        ]),
      ),
    );
  }
}

class AnswerDetailWidget extends StatelessWidget {
  AnswerDetailWidget({
    super.key,
    required this.size,
    required this.answer,
    required this.answerSelect,
    required this.quizInfo,
    required this.quiz,
  });

  final Size size;
  final String answer;
  final String answerSelect;
  final String quiz;
  final bool quizInfo;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: colorSystemWhite,
                radius: 30,
                child: quizInfo
                    ? const Icon(
                  (Icons.done),
                  color: colorMainBlue,
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
                  style: s20f700ColorMBlue,
                ),
                Text(
                  "Answer Select = $answerSelect",
                  style: s16f700ColorBlueMa,
                )
              ],
            )
          ],
        ));
  }
}
