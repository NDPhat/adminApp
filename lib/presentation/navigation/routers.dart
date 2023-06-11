import 'package:admin/data/remote/authen/authen_repo.dart';
import 'package:admin/domain/bloc/login/login_cubit.dart';
import 'package:admin/main.dart';
import 'package:admin/presentation/screen/dashboard/dash_board_main_screen.dart';
import 'package:admin/presentation/screen/detail/detail_pre_hw_screen.dart';
import 'package:admin/presentation/screen/login/login_screen.dart';
import 'package:admin/presentation/screen/mark/widget/detail_mark_screen_by_week.dart';
import 'package:flutter/material.dart';
import '../../data/remote/api/api/api_teacher_repo.dart';
import '../../domain/bloc/add_task/add_pre_cubit.dart';
import '../../domain/bloc/detail_pre/detail_pre_cubit.dart';
import '../screen/create/widget/create_pre_screen.dart';
import '../screen/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routers {
  static const String welCome = '/welCome';
  static const String login = '/login';
  static const String createPre = '/createPre';
  static const String detailPre = '/detailPre';
  static const String detailAllResultHW = '/detailAllResultHW';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => route(settings),
        settings:
            RouteSettings(name: settings.name, arguments: settings.arguments));
  }

  static route(RouteSettings settings) {
    switch (settings.name) {
      case welCome:
        return const WelcomeScreen();
      case detailAllResultHW:
        return const DetailResultHWByWeek();
      case dashboard:
        return const DashBoardMainScreen();
      case createPre:
        return BlocProvider(
            create: (context) => AddPreHWCubit(
                  teacherAPIRepo: instance.get<TeacherAPIRepo>(),
                ),
            child: CreatePreHomeWorkScreen());
      case detailPre:
        return BlocProvider(
            create: (context) => DetailPreHWCubit(
                  teacherAPIRepo: instance.get<TeacherAPIRepo>(),
                ),
            child: DetailPreHomeWorkScreen());
      case login:
        return BlocProvider(
            create: (context) => LoginCubit(
                teacherAPIRepo: instance.get<TeacherAPIRepo>(),
                authenRepository: instance.get<AuthenRepository>()),
            child: const LoginApp());
      default:
        return WelcomeScreen();
    }
  }
}
