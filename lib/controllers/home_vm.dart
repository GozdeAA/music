import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../utilities/enums.dart';

class HomeVM extends GetxController {
  SwiperController swiperController = SwiperController();
  AudioPlayer player = AudioPlayer();
  RxList<SongModel> files = <SongModel>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool playButton = true.obs;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void onInit() {
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

  next10Seconds() async {
    Duration? dur = await player.getCurrentPosition();
    if (dur != null) player.seek(const Duration(seconds: 10) + dur);
  }

  pre10Seconds() async {
    Duration? dur = await player.getCurrentPosition();
    if (dur != null && dur.compareTo(const Duration(seconds: 10)) > 0) {
      player.seek(dur - const Duration(seconds: 10));
    } else {
      player.seek(const Duration(seconds: 0));
    }
  }

  testplay(PlayType p, {int? i}) async {
    try {
      //files.shuffle();
      if (p == PlayType.next) {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) + 1].data));
        swiperController.next();
      } else if (p == PlayType.previous) {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) - 1].data));
        swiperController.previous();
      } else {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[i ?? currentIndex.value].data));
      }
    } catch (e) {
      printError();
    }
  }
}
