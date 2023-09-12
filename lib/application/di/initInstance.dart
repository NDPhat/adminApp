import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/api/api/pre_hw_repo.dart';
import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:admin/data/remote/api/api_impl/pre_hw_repo_impl.dart';
import 'package:admin/data/remote/api/api_impl/result_hw_repo_impl.dart';
import 'package:admin/data/remote/api/api_impl/user_repo_impl.dart';

import '../../data/local/drift/db/db_app.dart';
import '../../data/local/models/pre_global.dart';
import '../../data/local/repo/notify_task/notify_task_repo_impl.dart';
import '../../data/local/repo/notify_task/notoify_task_repo.dart';
import '../../data/remote/authen/authen_repo.dart';
import '../../data/remote/authen/authen_repo_impl.dart';
import '../../main.dart';

void initLocalRepo() {
  instance.registerLazySingleton<AppDb>(() => AppDb());
  instance.registerLazySingleton<NotifyTaskLocalRepo>(
      () => NotifyTaskRepoImpl(instance.get<AppDb>()));
  instance.registerLazySingleton<AuthenRepository>(() => AuthenRepoImpl());
  instance.registerLazySingleton<UserAPIRepo>(() => UserAPIRepoImpl());
  instance.registerLazySingleton<PreHWAPIRepo>(() => PreHWAPIImpl());
  instance.registerLazySingleton<ResultHWAPIRepo>(() => ResultHWAPIRepoImpl());
  instance.registerLazySingleton<PreGlobal>(() => PreGlobal());
  instance.registerLazySingleton<UserGlobal>(() => UserGlobal());
}
