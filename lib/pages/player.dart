import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/song_list.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';
import '../utilities/constants/consts.dart';
import '../utilities/constants/enums.dart';
import '../utilities/widgets/custom_icon_button.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  //TODO fix animated switcher

  @override
  Widget build(BuildContext context) {
    var vm = Get.put(PlayerVM());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.chevron_down,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: true,
          title: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Flexible(
                    flex: 6,
                    child: Text(
                      "Yerel kitaplıktan çalınıyor\n${vm.currentSongName.value}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                        onPressed: () {
                          Get.to(() => const SongListPage(),
                              transition: Transition.rightToLeft);
                        },
                        icon: Icon(
                          Icons.menu_outlined,
                          color: colors.primary,
                        )),
                  )
                ],
              )),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const BackgroundGrad(
                //colors: [Color(0xff6109AF), Color(0xff130023)]),
                colors: [
                  Color(0xff260246),
                  Color(0xec100112),
                ]),
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
                        if (vm.files.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                const Text(
                                    "Dosya bulunamadı. Dilerseniz çevrimiçi kütüphaneyi deneyebilirsiniz."),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "➡",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ))
                              ],
                            ),
                          );
                        } else {
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
                        }
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

  Container playArea(PlayerVM vm) {
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
              CustomIconButton(
                  assetName: "skip_previous",
                  onPressed: () => vm.testplay(PlayType.previous)),
              CustomIconButton(
                  assetName: "pre", onPressed: () => vm.pre10Seconds()),
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
              CustomIconButton(
                  assetName: "next", onPressed: () => vm.next10Seconds()),
              CustomIconButton(
                  assetName: "skip_next",
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

  Widget playButton(PlayerVM vm) {
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

  Widget pauseButton(PlayerVM vm) {
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
}
