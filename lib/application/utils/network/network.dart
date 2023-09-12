import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/authen/authen_repo.dart';
import '../../../main.dart';
import '../../../presentation/navigation/routers.dart';
import '../../cons/color.dart';
import '../../cons/text_style.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.defaultDialog(
        barrierDismissible: true,
        title: 'LOST YOUR CONNECTION',
        middleText: "YOUR WILL BE RETURNED TO THE WELCOME SCREEN",
        middleTextStyle: s16f700ColorError,
        backgroundColor: colorSystemWhite,
        titleStyle: s20f700ColorMBlue,
        onConfirm: () {
          instance.get<AuthenRepository>().handleAutoLoginApp(false);
          instance.get<UserGlobal>().onLogin = false;
          Get.toNamed(Routers.welCome);
        },
      );
    }
  }
}
