import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freechoice_music/controllers/player_vm.dart';
import 'package:freechoice_music/pages/player.dart';
import 'package:freechoice_music/pages/song_list.dart';
import 'package:freechoice_music/utilities/extensions/sizer.dart';
import 'package:freechoice_music/utilities/widgets/custom_widget/background_grad.dart';
import 'package:get/get.dart';
import '../models/play_list/play_list_model.dart';
import '../utilities/constants/consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Get.put(PlayerVM());
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
                      SizedBox(
                        height: 2.h,
                      ),
                      Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              cursorColor: const Color(0xff3b0951),
                              controller: vm.searchController,
                              onChanged: (value) => vm.onSearch(value),
                              decoration: InputDecoration(
                                  fillColor: const Color(0xc0ffffff),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Ara",
                                  focusedBorder: vm.getSearchValue()
                                      ? border.copyWith(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(16),
                                              topLeft: Radius.circular(16)))
                                      : border,
                                  filled: true,
                                  border: border),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            if (!vm.permissionsGranted.value)
                              Column(
                                children: [
                                  Text(
                                    "Devam etmek için dosya erişim izni vermeniz gerekmektedir.",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        vm.askPermission();
                                      },
                                      child: const Text(
                                          "İzin için buraya tıklayınız.")),
                                ],
                              ),
                            if (vm.permissionsGranted.value)
                              getBody(vm.getSearchValue(), vm),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                songArea(vm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody(bool condition, PlayerVM vm) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _body(condition, vm),
    );
  }

  Widget _body(bool condition, PlayerVM vm) {
    if (condition) {
      return Container(
        height: 20.h,
        padding: EdgeInsets.all(2.h),
        decoration: const BoxDecoration(
            color: Color(0x7affffff),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: vm.searchList.length,
            itemBuilder: (context, i) {
              return Text(vm.searchList[i].title);
            }),
      );
    } else {
      return GridView(
        shrinkWrap: true,
        padding: EdgeInsets.all(1.h),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 3.w,
          crossAxisCount: 3,
        ),
        children: playListWidgets(vm.playLists, vm),
      );
    }
  }

  List<Widget> playListWidgets(List<PlayList> list, PlayerVM vm) {
    List<Widget> playListWidgets = [];
    for (var i in list) {
      playListWidgets.add(coverWidget(
          onTap: () {
            Get.to(
              const SongListPage(),
              arguments: i,
            );
            vm.getFiles();
          },
          image: i.picture,
          title: i.title ?? ""));
    }

    playListWidgets.add(createPlayListWidget());
    return playListWidgets;
  }

  // çalma listesi kapak
  GestureDetector coverWidget(
      {required VoidCallback onTap, required String title, String? image}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 16.h,
          width: 32.w,
          padding: EdgeInsets.all(0.5.h),
          decoration: BoxDecoration(
              color: colors.surfaceTint,
              borderRadius: border.borderRadius,
              shape: BoxShape.rectangle),
          child: Column(
            children: [
              if (image != null && image.isNotEmpty)
                Image.file(File(image)), // kaynak file degil
              Flexible(
                  flex: 3,
                  child: SvgPicture.asset(
                    "assets/images/icons/note.svg",
                  )),
              Flexible(child: Text(title))
            ],
          )),
    );
  }

  GestureDetector createPlayListWidget() {
    return GestureDetector(
      onTap: () {
        //todo create playlist dialog widget which only takes playlist name
        //saves into local storage
        showDialog(
            context: Get.context!,
            builder: (context) => const AlertDialog(
                  content: Center(
                    child: Text("hi"),
                  ),
                ));
      },
      child: Container(
          height: 16.h,
          width: 32.w,
          padding: EdgeInsets.all(0.5.h),
          decoration: BoxDecoration(
              color: colors.surfaceTint.withOpacity(0.6),
              borderRadius: border.borderRadius,
              shape: BoxShape.rectangle),
          child: Icon(
            Icons.add,
            size: 8.h,
            color: const Color(0x4c091c27),
          )),
    );
  }

  Widget songArea(PlayerVM vm) {
    return GestureDetector(
      onTap: () =>
          Get.to(() => const PlayerPage(), transition: Transition.downToUp),
      child: Container(
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
              child: Icon(
                CupertinoIcons.chevron_up,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            const Spacer(),
            Obx(() {
              return Flexible(
                flex: 3,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      //ilgi kayan text animasyonu ile değiştirilecek
                      vm.currentSongName.value,
                      speed: const Duration(milliseconds: 100),
                      cursor: "",
                      textStyle: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (vm.query.isNotEmpty &&
                        vm.query[vm.currentIndex.value].artist != null &&
                        vm.query[vm.currentIndex.value].artist!.isNotEmpty)
                      TypewriterAnimatedText(
                        vm.query[vm.currentIndex.value].artist!,
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
              );
            })
          ],
        ),
      ),
    );
  }
}
