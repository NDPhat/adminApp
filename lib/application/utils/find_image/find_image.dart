import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/main.dart';

import '../../../data/remote/models/user_res.dart';

Future<String?> findImage(String uid) async {
  UserAPIModel? user = await instance.get<TeacherAPIRepo>().getUserById(uid);
  return user!.linkImage;
}
