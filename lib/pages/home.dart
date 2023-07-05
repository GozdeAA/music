import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/controllers/home_vm.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/themes/light_theme.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';
import '../utilities/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Get.put(HomeVM());
    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: [
        const BackgroundGrad(colors: [Color(0xff6109AF), Color(0xff130023)]),
        Column(
          children: [
            SizedBox(
              //nereden çalındıgı yazsın, çalma listesi mesela veya klasör
              height: 15.h, //appbar olacak
            ),
            Obx(
              () => SizedBox(
                height: 50.h,
                child: Swiper(
                  onIndexChanged: (i) {
                    if (vm.files.isNotEmpty) {
                      vm.currentIndex.value = i;
                      //vm.checkPlayingStatus();
                      vm.testplay(i: i, PlayType.current);
                    }
                  },
                  loop: false,
                  controller: vm.swiperController,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(vm.files[index].title),
                          Text(vm.files[index].artist ?? ""),
                        ],
                      ),
                    );
                  },
                  itemCount: vm.files.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
            )
          ],
        ),
        Align(alignment: Alignment.bottomCenter, child: playArea(vm))
      ],
    ));
  }

  Container playArea(HomeVM vm) {
    return Container(
      height: 16.h,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70), topRight: Radius.circular(70))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //customIcon(Icons.shuffle, size: 20.sp),
          customIcon(Icons.skip_previous_rounded,
              onPressed: () => vm.testplay(PlayType.previous)),
          Obx(() => vm.playButton.value),
          customIcon(Icons.skip_next,
              onPressed: () => vm.testplay(PlayType.next)),
          //  customIcon(Icons.loop, size: 20.sp)
        ],
      ),
    );
  }

  Flexible playButton(HomeVM vm) {
    return Flexible(
        child: IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: LightTheme().darkerIconColor?.withOpacity(0.8),
              size: 28.sp,
            ),
            onPressed: () {
              vm.testplay(PlayType.current);
              vm.playButton.value= pauseButton(vm);
            }));
  }

  Flexible pauseButton(HomeVM vm) {
    return Flexible(
        child: IconButton(
            icon: Icon(
              Icons.pause,
              color: LightTheme().darkerIconColor?.withOpacity(0.8),
              size: 28.sp,
            ),
            onPressed: () {
              vm.player.pause();
              vm.playButton.value= playButton(vm);

            }));
  }

  //iconlar değişecek
  Flexible customIcon(IconData iconData,
      {VoidCallback? onPressed, int? flex, double? size}) {
    return Flexible(
      flex: flex ?? 1,
      child: IconButton(
          onPressed: onPressed ?? () {},
          icon: Icon(
            iconData,
            color: LightTheme().darkerIconColor?.withOpacity(0.8),
            size: size ?? 28.sp,
          )),
    );
  }
}
