import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/pages/home.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../utilities/enums.dart';

class HomeVM extends GetxController {
  SwiperController swiperController = SwiperController();
  AudioPlayer player = AudioPlayer();
  RxList<SongModel> files = <SongModel>[].obs;
  Rx<Widget> playButton = Rx<Widget>(const SizedBox());
  RxInt currentIndex = 0.obs;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void onInit() {
    playButton.value = const HomePage().playButton(this);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await _audioQuery.permissionsRequest();
    getFiles();
    super.onReady();
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }

  Future getFiles() async {
    files.value = await _audioQuery.querySongs();
    printInfo(info: "bulunan dosya sayısı: ${files.length}");
  }

  testplay(PlayType p, {int? i}) async {
    try {
      //files.shuffle();
      if (p == PlayType.next) {
        playButton.value = const HomePage().pauseButton(this);
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) + 1].data));
        swiperController.next();
      } else if (p == PlayType.previous) {
        playButton.value = const HomePage().pauseButton(this);
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) - 1].data));
        swiperController.previous();
      } else {
        playButton.value = const HomePage().pauseButton(this);
        await player
            .play(DeviceFileSource(files[i ?? currentIndex.value].data));
      }
    } catch (e) {
      printError();
    }
  }
}
