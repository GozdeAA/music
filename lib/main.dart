import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freechoice_music/pages/splash.dart';
import 'package:freechoice_music/repository/local/storage_keys.dart';
import 'package:freechoice_music/repository/services/abstract/i_user_service.dart';
import 'package:freechoice_music/repository/services/concrete/user_service.dart';
import 'package:freechoice_music/utilities/themes/light_theme.dart';
import 'package:freechoice_music/utilities/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    EasyLoading.instance
      ..indicatorWidget = const CustomLoading()
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = const Color(0x55FFFFFF)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.white
      ..backgroundColor = Colors.transparent
      ..textColor = Colors.white
      ..boxShadow = []
      ..dismissOnTap = false
      ..userInteractions = false;
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: LightTheme().themeData,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      home: const Splash(),
    );
  }

  Future<void> setup() async {
    GetIt.I.registerSingleton<IUserService>(UserService());
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.bbsh.freechoice_music',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
    await GetStorage.init(SKeys.userSettings);
  }
}
