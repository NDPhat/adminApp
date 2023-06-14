import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/api/api_impl/api_teacher_impl.dart';

import '../../data/local/models/pre_global.dart';
import '../../data/remote/authen/authen_repo.dart';
import '../../main.dart';

void initLocalRepo() {
  instance.registerLazySingleton<AuthenRepository>(() => AuthenRepository());
  instance.registerLazySingleton<TeacherAPIRepo>(() => TeacherAPIImpl());
  instance.registerLazySingleton<PreGlobal>(() => PreGlobal());
  instance.registerLazySingleton<UserGlobal>(() => UserGlobal());
}
