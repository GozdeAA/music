import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/player.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';

import '../utilities/constants/consts.dart';
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomIconButton(
                            assetName: 'user',
                            onPressed: () {
                              //setting page
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TextField(
                            cursorColor: Color(0xff3b0951),
                            decoration: InputDecoration(
                                fillColor: Color(0xc0ffffff),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 5),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Ara",
                                focusedBorder: border,
                                filled: true,
                                enabledBorder: border,
                                border: border),
                          ),
                          GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(1.h),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1,
                              mainAxisSpacing: 2.h,
                              crossAxisSpacing: 3.w,
                              crossAxisCount: 3,
                            ),
                            children: [
                              coverWidget(onTap: () {}),
                              coverWidget(onTap: () {}),
                              coverWidget(onTap: () {})
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                songArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // çalma listesi kapak
  GestureDetector coverWidget({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 16.h,
        width: 32.w,
        padding: EdgeInsets.all(0.5.h),
        child: Placeholder(),
        //resim buraya
        decoration: BoxDecoration(
            color: colors.surfaceTint,
            borderRadius: border.borderRadius,
            shape: BoxShape.rectangle),
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
                  //ilgi kayan text animasyonu ile değiştirilecek
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
