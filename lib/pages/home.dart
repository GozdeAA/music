import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freechoice_music/controllers/home_vm.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';
import '../utilities/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //TODO fix animated switcher

  @override
  Widget build(BuildContext context) {
    var vm = Get.put(HomeVM());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Obx(() => Text(
                "Yerel kitaplıktan çalınıyor\n${vm.currentSongName.value}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                textAlign: TextAlign.center,
              )),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const BackgroundGrad(
                colors: [Color(0xff6109AF), Color(0xff130023)]),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customIcon("skip_previous",
                  onPressed: () => vm.testplay(PlayType.previous)),
              customIcon("pre", onPressed: () => vm.pre10Seconds()),
              AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                reverseDuration: const Duration(seconds: 5),
                duration: const Duration(seconds: 5),
                switchInCurve: Curves.bounceInOut,
                switchOutCurve: Curves.easeOutCirc,
                child: Obx(() => customButton(vm.playButton.value, vm)),
              ),
              customIcon("next", onPressed: () => vm.next10Seconds()),
              customIcon("skip_next",
                  onPressed: () => vm.testplay(PlayType.next)),
            ],
          ),
          SizedBox(
            height: 0.5.h,
          ),
        ],
      ),
    );
  }

  Widget customButton(bool play, vm) {
    if (play) {
      return playButton(vm);
    } else {
      return pauseButton(vm);
    }
  }

  Widget playButton(HomeVM vm) {
    return GestureDetector(
        child: SvgPicture.asset(
          "assets/images/icons/play.svg",
          height: 24.sp,
        ),
        onTap: () {
          vm.testplay(PlayType.current);
          vm.playButton.value = false;
        });
  }

  Widget pauseButton(HomeVM vm) {
    return GestureDetector(
        child: SvgPicture.asset(
          "assets/images/icons/pause.svg",
          height: 24.sp,
        ),
        onTap: () {
          vm.player.pause();
          vm.playButton.value = true;
        });
  }

  Flexible customIcon(String assetName,
      {VoidCallback? onPressed, int? flex, double? size, double? grade}) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: onPressed ?? () {},
        child: SvgPicture.asset(
          "assets/images/icons/$assetName.svg",
          height: size ?? 24.sp,
        ),
      ),
    );
  }
}
