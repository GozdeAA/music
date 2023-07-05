import 'package:flutter/material.dart';
import 'package:freechoice_music/controllers/splash_vm.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:get/get.dart';

import '../utilities/widgets/custom_widget/background_grad.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ilgi burada ilk splash deki renkleri alaeak animasyon başlasın daha sonra kayarak renk deişsin yükleniyorken
    Get.put(SplashVM());
    return Scaffold(
        body: BackgroundGrad(
            child: Center(
      child: Text(
        "Free Choice\nMusic",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Abril", color: Colors.white, fontSize: 24.sp),
      ),
    )));
  }
}
