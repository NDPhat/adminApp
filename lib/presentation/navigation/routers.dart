import 'package:admin/data/remote/authen/authen_repo.dart';
import 'package:admin/domain/bloc/add_user/add_user_cubit.dart';
import 'package:admin/domain/bloc/login/login_cubit.dart';
import 'package:admin/main.dart';
import 'package:admin/presentation/screen/create/create_main_screen.dart';
import 'package:admin/presentation/screen/create/widget/create_user_screen.dart';
import 'package:admin/presentation/screen/detail/detail_pre_hw_screen.dart';
import 'package:admin/presentation/screen/home/home_screen.dart';
import 'package:admin/presentation/screen/intro/intro_screen.dart';
import 'package:admin/presentation/screen/language_screen/language_screen.dart';
import 'package:admin/presentation/screen/login/login_screen.dart';
import 'package:admin/presentation/screen/manager/manager_main_screen.dart';
import 'package:admin/presentation/screen/manager/widget/manager_result_hw_main_screen.dart';
import 'package:admin/presentation/screen/setting/setting_main_screen.dart';
import 'package:admin/presentation/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../data/remote/api/api/api_teacher_repo.dart';
import '../../domain/bloc/add_task/add_pre_cubit.dart';
import '../../domain/bloc/detail_pre/detail_pre_cubit.dart';
import '../screen/create/widget/create_pre_screen.dart';
import '../screen/dashboard_main/dashboard_home_page_screen.dart';
import '../screen/detail/detail_result_hw_by_weak_main_screen.dart';
import '../screen/detail/detail_result_hw_item_screen.dart';
import '../screen/manager/widget/manager_student_with_page_view_screen.dart';
import '../screen/profile/profile_screen.dart';
import '../screen/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routers {
  static const String welCome = '/welCome';
  static const String login = '/login';
  static const String intro = '/intro';
  static const String splash = '/splash';
  static const String createPre = '/createPre';
  static const String home = '/home';
  static const String language = '/language';
  static const String setting = '/setting';
  static const String profile = '/profile';
  static const String managerUser = '/managerUser';
  static const String managerMainScreen = '/managerMainScreen';
  static const String createUser = '/createUser';
  static const String createMainScreen = '/createMainScreen';
  static const String detailPre = '/detailPre';
  static const String detailAllResultHW = '/detailAllResultHW';
  static const String detailQuizHWByResultID = '/detailQuizHWByResultID';
  static const String detailResultHWByWeakMainScreen =
      '/detailResultHWByWeakMainScreen';
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
      case setting:
        return const SettingMainScreen();
      case language:
        return const LanguageScreen();
      case managerUser:
        return const ManagerStudentPageView();
      case splash:
        return const SplashScreen();
      case home:
        return const HomeScreen();
      case managerMainScreen:
        return const ManagerMainScreen();
      case intro:
        return const IntroScreen(); case profile:
        return const ProfileScreen();
      case createMainScreen:
        return const CreateMainScreen();
      case createUser:
        return BlocProvider(
            create: (context) => AddUserCubit(
                  teacherAPIRepo: instance.get<TeacherAPIRepo>(),
                ),
            child: CreateUserScreen());
      case detailAllResultHW:
        return const ManagerResultHWMainScreen();
      case detailQuizHWByResultID:
        return const DetailResultHWItemScreen();
      case detailResultHWByWeakMainScreen:
        return const DetailResultHWByWeakMainScreen();
      case dashboard:
        return const DashBoardHomePageScreen();
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
        return const SplashScreen();
    }
  }
}
