import '../../data/local/notify/notifi_helper.dart';
import 'initInstance.dart';

Future<void> setUpProject() async {
  initLocalRepo();
  await NotifyHelper().initializeNotification();
}
