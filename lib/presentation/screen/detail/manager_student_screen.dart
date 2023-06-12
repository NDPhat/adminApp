import 'package:admin/data/remote/models/user_res.dart';
import 'package:admin/presentation/screen/dashboard_main/dashboard_home_page_screen.dart';
import 'package:admin/presentation/widget/app_bar_widget.dart';
import 'package:admin/presentation/widget/item_manager_user.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../application/cons/color.dart';
import '../../../application/cons/text_style.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../main.dart';
import '../mark/widget/item_fillter.dart';

class ManagerStudentScreen extends StatefulWidget {
  const ManagerStudentScreen({Key? key}) : super(key: key);
  @override
  State<ManagerStudentScreen> createState() => _ManagerStudentScreenState();
}

class _ManagerStudentScreenState extends State<ManagerStudentScreen> {
  List<UserAPIModel>? listConvert = [];
  List<UserAPIModel>? listSearch = [];
  Future<List<UserAPIModel>?>? listServer;
  bool chooseNameNow = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      listServer = instance.get<TeacherAPIRepo>().getAllStudentByClass("1D");
      listServer!.then((value) => setState(() {
            listConvert = value;
          }));
    });
  }

  onSearchChanged(String value) {
    List<UserAPIModel>? results = [];
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
            onBack: () {},
            textTitle: "Manger User",
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
                bottom: size.height * 0.05),
            child: Column(
              children: [
                ItemFillter(
                  size: size,
                  name: "NAME",
                  onTap: () {
                    setState(() {
                      if (chooseNameNow == true) {
                        chooseNameNow = false;
                      } else {
                        chooseNameNow = true;
                        listSearch!.sort((a, b) => a.name!.compareTo(b.name!));
                      }
                    });
                  },
                  onChoose: chooseNameNow,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: size.height * 0.5,
                    child: listSearch!.isEmpty
                        ? ListView.builder(
                            itemCount: listConvert!.length,
                            itemBuilder: (context, index) {
                              return ItemManagerUser(
                                  size: size,
                                  lop: listConvert![index].lop!,
                                  ten: listConvert![index].name!,
                                  onTap: () {});
                            },
                          )
                        : ListView.builder(
                            itemCount: listSearch!.length,
                            itemBuilder: (context, index) {
                              return ItemManagerUser(
                                  size: size,
                                  lop: listSearch![index].lop!,
                                  ten: listSearch![index].name!,
                                  onTap: () {});
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
