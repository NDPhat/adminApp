import '../../data/local/notify/notifi_helper.dart';
import '../utils/network/network.dart';
import 'initInstance.dart';
import 'package:get/get.dart';

Future<void> setUpProject() async {
  initLocalRepo();
  await NotifyHelper().initializeNotification();
  Get.put<NetworkController>(NetworkController(), permanent: true);
}
