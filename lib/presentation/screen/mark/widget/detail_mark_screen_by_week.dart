import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:admin/data/remote/models/user_res.dart';
import 'package:admin/presentation/screen/mark/widget/item_fillter.dart';
import 'package:admin/presentation/widget/app_bar_widget.dart';
import 'package:admin/presentation/widget/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../application/utils/find_average/find_average_score.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../data/remote/models/pre_hw_res.dart';
import '../../../../main.dart';
import '../../create/widget/item_card.dart';

class DetailResultHWByWeek extends StatefulWidget {
  const DetailResultHWByWeek({Key? key}) : super(key: key);
  @override
  State<DetailResultHWByWeek> createState() => _DetailResultHWByWeekState();
}

class _DetailResultHWByWeekState extends State<DetailResultHWByWeek> {
  List<ResultQuizHWAPIModel>? listConvert = [];
  List<ResultQuizHWAPIModel>? listSearch = [];
  Future<List<ResultQuizHWAPIModel>?>? listServer;
  bool chooseNameNow = false;
  bool chooseScoreNow = false;
  PreHWResModel? data;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      data = ModalRoute.of(context)!.settings.arguments as PreHWResModel;
      listServer = instance
          .get<TeacherAPIRepo>()
          .getAllResultQuizHWByWeek(data!.week.toString());
      listServer!.then((value) => setState(() {
            listConvert = value;
          }));
    });
  }

  onSearchChanged(String value) {
    List<ResultQuizHWAPIModel>? results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = listConvert;
    } else {
      results = listConvert!
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      listSearch = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            size: size,
            onBack: () {
              Navigator.pop(context);
            },
            textTitle: "WEEK 1",
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.1,
            child: TextField(
              textInputAction: TextInputAction.next,
              style: s16f700ColorGreyTe,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  LineAwesomeIcons.search,
                  size: 30,
                  color: colorGrayBG,
                ),
                hintText: "Search",
                fillColor: colorBGInput,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                filled: true,
              ),
              onChanged: (value) {
                onSearchChanged(value);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        ItemFillter(
                          size: size,
                          name: "NAME",
                          onTap: () {
                            setState(() {
                              chooseScoreNow = false;
                              chooseNameNow = true;
                              listSearch!.isNotEmpty
                                  ? listSearch!.sort(
                                      (a, b) => a.name!.compareTo(b.name!))
                                  : listConvert!.sort(
                                      (a, b) => a.name!.compareTo(b.name!));
                            });
                          },
                          onChoose: chooseNameNow,
                        ),
                        ItemFillter(
                          size: size,
                          name: "SCORE",
                          onTap: () {
                            setState(() {
                              chooseScoreNow = true;
                              chooseNameNow = false;
                              listSearch!.isNotEmpty
                                  ? listSearch!.sort(
                                      (a, b) => a.score!.compareTo(b.score!))
                                  : listConvert!.sort(
                                      (a, b) => a.score!.compareTo(b.score!));
                            });
                          },
                          onChoose: chooseScoreNow,
                        ),
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: SizedBox(
                      height: size.height * 0.55,
                      child: listSearch!.isEmpty
                          ? ListView.builder(
                              itemCount: listConvert!.length,
                              itemBuilder: (context, index) {
                                return ItemCard(
                                  onTap: () {},
                                  size: size,
                                  backgroundColor: colorMainBlue,
                                  childRight: Center(
                                    child: Text(
                                      findAveScore(listConvert![index].score!),
                                      style: s16f700ColorGreyTe,
                                    ),
                                  ),
                                  childCenter: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${listConvert![index].name}",
                                        style: s16f500ColorSysWhite,
                                      ),
                                      Text(
                                        "SCORE : ${listConvert![index].score}",
                                        style: s16f700ColorError,
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: listSearch!.length,
                              itemBuilder: (context, index) {
                                return ItemCard(
                                  onTap: () {},
                                  size: size,
                                  backgroundColor: colorMainBlue,
                                  childRight: Center(
                                    child: Text(
                                      findAveScore(listSearch![index].score!),
                                      style: s16f700ColorGreyTe,
                                    ),
                                  ),
                                  childCenter: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${listSearch![index].name}",
                                        style: s16f500ColorSysWhite,
                                      ),
                                      Text(
                                        "SCORE : ${listSearch![index].score}",
                                        style: s16f700ColorError,
                                      ),
                                    ],
                                  ),
                                );
                              })),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
