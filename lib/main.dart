import 'package:admin/presentation/navigation/routers.dart';
import 'package:admin/presentation/screen/restart_app/restart_app_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:device_preview/device_preview.dart';
import 'package:sizer/sizer.dart';
import 'application/di/setupProject.dart';
import 'data/local/authen/authen_repo.dart';

GetIt instance = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  instance.registerLazySingleton<AuthenRepository>(() => AuthenRepository());
  setUpProject();
  runApp(DevicePreview(
    builder: (context) => EasyLocalization(
        supportedLocales: const [
          Locale("vi", "VI"),
          Locale("en", "EN"),
        ],
        path: "resources/langs",
        saveLocale: true,
        child: const RestartWidget(child: AdminApp())), // Wrap your app
  ));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, device) {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          initialRoute: Routers.splash,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          onGenerateRoute: Routers.generateRoute,
        ),
      );
    });
  }
}
