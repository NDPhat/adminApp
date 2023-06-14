// import 'dart:html';
import 'package:admin/presentation/navigation/routers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:device_preview/device_preview.dart';
import 'application/di/setupProject.dart';
import 'data/local/authen/authen_repo.dart';

GetIt instance = GetIt.instance;
void main() {
  instance.registerLazySingleton<AuthenRepository>(() => AuthenRepository());
  setUpProject();
  runApp(DevicePreview(
    builder: (context) => const AdminApp(), // Wrap your app
  ));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MaterialApp(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        initialRoute: Routers.welCome,
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
