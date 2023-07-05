import 'package:flutter/material.dart';
import 'package:freechoice_music/pages/splash.dart';
import 'package:freechoice_music/utilities/themes/light_theme.dart';
import 'package:get/get.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: LightTheme().themeData,
      themeMode: ThemeMode.dark,
      home: Splash(),
    );
  }
}
