import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/player.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';

import '../utilities/widgets/custom_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = PlayerVM();
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGrad(colors: [Color(0xff320261), Color(0xff130023)]),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      CustomIconButton(
                        assetName: 'user',
                        onPressed: () {
                          //setting page
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: const Column(children: [

                    ],)),
                songArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container songArea() {
    return Container(
      //TODO animated container
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          color: const Color(0xec100112),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 9),
                blurRadius: 20,
                color: Colors.grey.shade700,
                spreadRadius: 9)
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          border: const Border(
              top: BorderSide(color: Color(0xb847375b)),
              left: BorderSide(color: Color(0xb847375b)),
              right: BorderSide(color: Color(0xb847375b)))),
      child: Row(
        children: [
          Flexible(
              child: IconButton(
                  icon: Icon(
                    CupertinoIcons.chevron_up,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  onPressed: () => Get.to(() => const PlayerPage(),
                      transition: Transition.downToUp))),
          const Spacer(),
          Flexible(
            flex: 3,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Şarkı ismi',
                  speed: const Duration(milliseconds: 100),
                  cursor: "",
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'cicikus ismi',
                  cursor: "",
                  speed: const Duration(milliseconds: 100),
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              stopPauseOnTap: true,
              repeatForever: true,
            ),
          )
        ],
      ),
    );
  }
}
