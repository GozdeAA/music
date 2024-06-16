import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/home.dart';
import 'package:freechoice_music/repository/local/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashVM extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await skipToHome();
  }

  Future<void> skipToHome() async {
    var storage = GetStorage(SKeys.userSettings);
    var e = storage.read(SKeys.firstUse);
    await Future.delayed(const Duration(seconds: 3));

    if (e != null && !e) {
      //get user informations
      //get playlist
      Get.put(PlayerVM(firstUse: false));
      Get.off(() => const HomePage());
    } else {
      Get.put(PlayerVM(firstUse: true));
      Get.off(() => const HomePage());
    }
  }
}
