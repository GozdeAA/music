import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../utilities/enums.dart';

//TODO player icon durumu göre değişecek, gerekirse buton olarak ayır state e göre
//tODO vcs

class HomeVM extends GetxController {
  SwiperController swiperController = SwiperController();
  AudioPlayer player = AudioPlayer();
  RxList<SongModel> files = <SongModel>[].obs;
  Rx<IconData> playIcon = Rx<IconData>(Icons.play_arrow);
  RxInt currentIndex = 0.obs;
  final OnAudioQuery _audioQuery = OnAudioQuery();

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
    print(files.length);
  }

  Future<void> checkPlayingStatus() async {
    if (player.state == PlayerState.playing) {
      await player.pause();
      playIcon.value = Icons.play_arrow;
      return;
    } else if (player.state == PlayerState.paused) {
      await player.resume();
      playIcon.value = Icons.pause;
      return;
    } else {
      files.shuffle();
      await player.play(DeviceFileSource(files[currentIndex.value].data));
      return;
    }
  }

  testplay(PlayType p, {int? i}) async {
    try {
      if (p == PlayType.next) {
        //files.shuffle();
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) + 1].data));
        playIcon.value = Icons.pause;
        swiperController.next();
      } else if (p == PlayType.previous) {
        //files.shuffle();
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) - 1].data));
        playIcon.value = Icons.pause;
        swiperController.previous();
      } else {
        //files.shuffle();
        playIcon.value = Icons.pause;
        await player
            .play(DeviceFileSource(files[i ?? currentIndex.value].data));
      }
    } catch (e) {
      printError();
    }
  }
}
