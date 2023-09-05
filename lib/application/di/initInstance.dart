import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/api/api_impl/api_teacher_impl.dart';

import '../../data/local/drift/db/db_app.dart';
import '../../data/local/models/pre_global.dart';
import '../../data/local/repo/notify_task/notify_task_repo_impl.dart';
import '../../data/local/repo/notify_task/notoify_task_repo.dart';
import '../../data/remote/authen/authen_repo.dart';
import '../../main.dart';

void initLocalRepo() {
  instance.registerLazySingleton<AppDb>(() => AppDb());
  instance.registerLazySingleton<NotifyTaskLocalRepo>(
      () => NotifyTaskRepoImpl(instance.get<AppDb>()));
  instance.registerLazySingleton<AuthenRepository>(() => AuthenRepository());
  instance.registerLazySingleton<TeacherAPIRepo>(() => TeacherAPIImpl());
  instance.registerLazySingleton<PreGlobal>(() => PreGlobal());
  instance.registerLazySingleton<UserGlobal>(() => UserGlobal());
}
