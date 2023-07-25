import 'package:admin/data/local/models/user_global.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../application/cons/color.dart';
import '../../../../application/cons/text_style.dart';
import '../../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../../data/remote/models/user_res.dart';
import '../../../../main.dart';
import '../../../widget/app_bar_widget.dart';
import '../../../widget/item_manager_user.dart';

class ManagerStudentPageView extends StatefulWidget {
  const ManagerStudentPageView({Key? key}) : super(key: key);

  @override
  State<ManagerStudentPageView> createState() => _ManagerStudentPageViewState();
}

class _ManagerStudentPageViewState extends State<ManagerStudentPageView> {
  late PageController _pageController;
  List<UserAPIModel>? listConvert = [];
  List<UserAPIModel>? listSearch = [];
  Future<List<UserAPIModel>?>? listServer;
  Future<List<UserAPIModel>?>? listFake;
  int pageNum = 0;
  int pageNow = 0;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    Future.delayed(Duration.zero, () {
      listServer = instance
          .get<TeacherAPIRepo>()
          .getAllStudentByClass(instance.get<UserGlobal>().lop.toString());
      listServer!.then((value) => setState(() {
            listConvert = value;
            pageNum = listConvert!.length ~/ 4 + 1;
          }));
    });
    getListDataBack();
  }

  void getListDataBack() {
    listFake = instance
        .get<TeacherAPIRepo>()
        .getAllStudentByClass(instance.get<UserGlobal>().lop.toString());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onSearchChanged(String value) {
    List<UserAPIModel>? results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      setState(() {
        listSearch!.clear();
      });
    } else {
      results = listConvert!
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        listSearch = results;
      });
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AppBarWidget(
            onBack: () {
              Navigator.pop(context);
            },
            textTitle: "manager student".tr().toString(),
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.1,
            child: TextField(
              textInputAction: TextInputAction.next,
              style: s16f700ColorGreyTe,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  LineAwesomeIcons.search,
                  size: 30,
                  color: colorGrayBG,
                ),
                hintText: "search".tr().toString(),
                fillColor: colorBGInput,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                filled: true,
              ),
              onChanged: (value) {
                onSearchChanged(value);
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.7,
            child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  controller: _pageController,
                  itemCount: pageNum,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => SizedBox(
                    height: size.height * 0.6,
                    child: listSearch!.isEmpty
                        ? ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              listConvert!
                                  .sort((a, b) => a.name!.compareTo(b.name!));
                              int indexListNow = index + _pageIndex * 4;
                              if (indexListNow < listConvert!.length) {
                                return ItemManagerUser(
                                    lop: listConvert![indexListNow].lop!,
                                    ten: listConvert![indexListNow].name!,
                                    onTap: () {});
                              } else {
                                return Container();
                              }
                            },
                          )
                        : ListView.builder(
                            itemCount: listSearch!.length,
                            itemBuilder: (context, index) {
                              return ItemManagerUser(
                                  lop: listSearch![index].lop!,
                                  ten: listSearch![index].name!,
                                  onTap: () {});
                            },
                          ),
                  ),
                )),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  width: size.width * 0.35,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DotPageIndicator(
                          size: size,
                          icon: const Icon(
                            Icons.skip_previous_sharp,
                            size: 25,
                            color: colorSystemWhite,
                          ),
                          onTap: () {
                            if (_pageIndex == 0) {
                            } else {
                              _pageController.previousPage(
                                  duration: const Duration(microseconds: 300),
                                  curve: Curves.ease);
                            }
                          },
                        ),
                        DotIndicator(
                          size: size,
                          pageIndex: (_pageIndex + 1).toString(),
                        ),
                        DotPageIndicator(
                          size: size,
                          icon: const Icon(
                            Icons.skip_next,
                            size: 25,
                            color: colorSystemWhite,
                          ),
                          onTap: () {
                            if (_pageIndex == pageNum - 1) {
                            } else {
                              _pageController.nextPage(
                                  duration: const Duration(microseconds: 300),
                                  curve: Curves.ease);
                            }
                          },
                        ),
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, required this.size, required this.pageIndex})
      : super(key: key);
  final Size size;
  final String pageIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.1,
      height: size.height * 0.05,
      decoration: const BoxDecoration(
          color: colorErrorPrimary,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Text(
          pageIndex,
          style: s14f500colorSysWhite,
        ),
      ),
    );
  }
}

class DotPageIndicator extends StatelessWidget {
  const DotPageIndicator(
      {Key? key, required this.size, required this.icon, required this.onTap})
      : super(key: key);
  final Size size;
  final Icon icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.1,
        height: size.height * 0.05,
        decoration: const BoxDecoration(
            color: colorGrayBG,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(child: icon),
      ),
    );
  }
}
