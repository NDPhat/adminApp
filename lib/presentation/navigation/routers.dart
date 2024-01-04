import 'package:admin/data/local/repo/notify_task/notoify_task_repo.dart';
import 'package:admin/data/remote/api/api/pre_hw_repo.dart';
import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:admin/data/remote/authen/authen_repo.dart';
import 'package:admin/data/remote/models/user_res.dart';
import 'package:admin/domain/bloc/add_notifi/add_notify_cubit.dart';
import 'package:admin/domain/bloc/add_user/add_user_cubit.dart';
import 'package:admin/domain/bloc/data_sheet/data_sheet_cubit.dart';
import 'package:admin/domain/bloc/detail_user/detail_user_cubit.dart';
import 'package:admin/domain/bloc/login/login_cubit.dart';
import 'package:admin/domain/bloc/manage_hw/manage_hw_cubit.dart';
import 'package:admin/domain/bloc/manage_main/manage_cubit.dart';
import 'package:admin/domain/bloc/notify_main/notify_main_cubit.dart';
import 'package:admin/domain/bloc/update_pass/update_pass_cubit.dart';
import 'package:admin/domain/bloc/update_profile/update_profile_cubit.dart';
import 'package:admin/main.dart';
import 'package:admin/presentation/screen/create/create_main_screen.dart';
import 'package:admin/presentation/screen/create/widget/create_user_screen.dart';
import 'package:admin/presentation/screen/detail/detail_pre_hw_screen.dart';
import 'package:admin/presentation/screen/detail/detail_student_info_screen.dart';
import 'package:admin/presentation/screen/detail/widget/detail_quiz_hw.dart';
import 'package:admin/presentation/screen/home/home_screen.dart';
import 'package:admin/presentation/screen/intro/intro_screen.dart';
import 'package:admin/presentation/screen/language_screen/language_screen.dart';
import 'package:admin/presentation/screen/login/login_screen.dart';
import 'package:admin/presentation/screen/manager/manager_main_screen.dart';
import 'package:admin/presentation/screen/manager/widget/manager_hw_ongoing.dart';
import 'package:admin/presentation/screen/profile/widget/my_acc/profile_myaccount.dart';
import 'package:admin/presentation/screen/profile/widget/update_pass/change_pass_word_screen.dart';
import 'package:admin/presentation/screen/setting/setting_main_screen.dart';
import 'package:admin/presentation/screen/setting/widget/add_notify_screen.dart';
import 'package:admin/presentation/screen/setting/widget/notify_main.dart';
import 'package:admin/presentation/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/bloc/add_pre_hw/add_pre_cubit.dart';
import '../../domain/bloc/detail_homework/detail_result_hw_cubit.dart';
import '../../domain/bloc/detail_pre/detail_pre_cubit.dart';
import '../screen/create/widget/create_pre_screen.dart';
import '../screen/dashboard_main/dashboard_home_page_screen.dart';
import '../screen/detail/detail_result_hw_by_weak_main_screen.dart';
import '../screen/detail/detail_result_hw_item_screen.dart';
import '../screen/manager/widget/manager_hw_screen.dart';
import '../screen/manager/widget/manager_student_screen.dart';
import '../screen/profile/profile_screen.dart';
import '../screen/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routers {
  static const String welCome = '/welCome';
  static const String login = '/login';
  static const String intro = '/intro';
  static const String splash = '/splash';
  static const String createPre = '/createPre';
  static const String detailResultHW = '/detailResultHW';
  static const String detailStudent = '/detailStudent';
  static const String home = '/home';
  static const String language = '/language';
  static const String setting = '/setting';
  static const String profile = '/profile';
  static const String updatePass = '/updatePass';
  static const String updateProfile = '/updateProfile';
  static const String managerUser = '/managerUser';
  static const String managerHWOnGoing = '/managerHWOnGoing';
  static const String managerMainScreen = '/managerMainScreen';
  static const String createUser = '/createUser';
  static const String createMainScreen = '/createMainScreen';
  static const String notifyMainScreen = '/notifyMainScreen';
  static const String addNotify = '/addNotify';
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
      case detailResultHW:
        return const DetailQuizHWScreen();
      case language:
        return const LanguageScreen();
      case managerUser:
        return const ManagerStudentScreen();
      case splash:
        return const SplashScreen();
      case home:
        return const HomeScreen();
      case managerMainScreen:
        return BlocProvider(
            create: (context) => ManageCubit(
                  preHWAPIRepo: instance.get<PreHWAPIRepo>(),
                ),
            child: const ManagerMainScreen());
      case intro:
        return const IntroScreen();
      case profile:
        return const ProfileScreen();
      case createMainScreen:
        return const CreateMainScreen();
      case createUser:
        return BlocProvider(
            create: (context) => AddUserCubit(
                  userAPIRepo: instance.get<UserAPIRepo>(),
                ),
            child: CreateUserScreen());
      case updatePass:
        return BlocProvider(
            create: (context) => UpdatePassCubit(
                  userRepo: instance.get<UserAPIRepo>(),
                ),
            child: const ChangePassWordScreen());
      case notifyMainScreen:
        return BlocProvider(
            create: (context) => NotifyMainCubit(
                  notifyTaskLocalRepo: instance.get<NotifyTaskLocalRepo>(),
                ),
            child: const LocalNotifyMainScreen());
      case updateProfile:
        return BlocProvider(
            create: (context) => UpdateProfileCubit(
                  userAPIRepo: instance.get<UserAPIRepo>(),
                ),
            child: const UpdateProfileUserScreen());
      case addNotify:
        return BlocProvider(
            create: (context) => AddNotifyCubit(
                  notifyTaskRepo: instance.get<NotifyTaskLocalRepo>(),
                ),
            child: AddNotifyScreen());
      case detailAllResultHW:
        return BlocProvider(
            create: (context) => ManageHWCubit(
                  resultHWAPIRepo: instance.get<ResultHWAPIRepo>(),
                  userAPIRepo: instance.get<UserAPIRepo>(),
                ),
            child: const ManagerHomeWorkScreen());
      case managerHWOnGoing:
        return BlocProvider(
            create: (context) => ManageHWCubit(
              resultHWAPIRepo: instance.get<ResultHWAPIRepo>(),
              userAPIRepo: instance.get<UserAPIRepo>(),
            ),
            child: const ManagerHomeWorkOnGoingScreen());
      case detailStudent:
        return BlocProvider(
            create: (context) => DetailUserCubit(
                  userAPIRepo: instance.get<UserAPIRepo>(),
                  userAPIModel: settings.arguments! as UserAPIModel,
                ),
            child: const DetailStudentInfoScreen());
      case detailQuizHWByResultID:
        return const DetailResultHWItemScreen();
      case detailResultHWByWeakMainScreen:
        return BlocProvider(
            create: (context) => DetailResultHWCubit(
                  resultHWAPIRepo: instance.get<ResultHWAPIRepo>(),
                ),
            child: const DetailResultHWByWeakMainScreen());
      case dashboard:
        return BlocProvider(
            create: (context) => DataSheetCubit(
                  resultHWAPIRepo: instance.get<ResultHWAPIRepo>(),
                ),
            child: const DataSheetMainScreen());
      case createPre:
        return BlocProvider(
            create: (context) => AddPreHWCubit(
                  preHWAPIRepo: instance.get<PreHWAPIRepo>(),
                ),
            child: CreatePreHomeWorkScreen());
      case detailPre:
        return BlocProvider(
            create: (context) => DetailPreHWCubit(
                  preHWAPIRepo: instance.get<PreHWAPIRepo>(),
                  resultHWAPIRepo: instance.get<ResultHWAPIRepo>(),
                  userAPIRepo: instance.get<UserAPIRepo>(),
                ),
            child: DetailPreHomeWorkScreen());
      case login:
        return BlocProvider(
            create: (context) => LoginCubit(
                userAPIRepo: instance.get<UserAPIRepo>(),
                authenRepository: instance.get<AuthenRepository>()),
            child: const LoginApp());
      default:
        return const SplashScreen();
    }
  }
}
