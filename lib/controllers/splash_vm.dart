import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/home.dart';
import 'package:get/get.dart';

class SplashVM extends GetxController {

  @override
  void onInit() {
    super.onInit();
    skipToHome();
  }

  Future<void> skipToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.put(PlayerVM());
    Get.off(() => const HomePage());
  }
}
