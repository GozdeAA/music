import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:freechoice_music/models/play_list/play_list_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utilities/constants/enums.dart';

class PlayerVM extends GetxController {
  SwiperController swiperController = SwiperController();
  TextEditingController searchController = TextEditingController();
  AudioPlayer player = AudioPlayer();
  RxList<SongModel> files = <SongModel>[].obs;
  RxList<SongModel> query = <SongModel>[].obs;
  RxList<SongModel> searchList = <SongModel>[].obs;
  RxList<PlayList> playLists = RxList([
    PlayList(id: "0", title: "List 1"),
    PlayList(
      id: "1",
      title: "List 2",
    ),
    PlayList(
      id: "2",
      title: "List 3",
    )
  ]);
  RxInt currentIndex = 0.obs;
  RxBool playButton = true.obs;
  RxBool searchOn = false.obs;
  RxString currentSongName = "".obs;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Future<void> onReady() async {
    await askPermission();
    await _audioQuery.permissionsRequest();
    super.onReady();
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }

  askPermission() async {
    var storage = await Permission.storage.request();
    var library = await Permission.mediaLibrary.request();

    if (storage.isPermanentlyDenied || library.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      getFiles();
    }
  }

  bool getSearchValue() {
    return searchList.isNotEmpty;
  }

  void onSearch(String value) {
    if (files.isNotEmpty && value.length >= 3) {
      for (var i in files) {
        if ((i.title.isNotEmpty && i.title.toLowerCase().contains(value)) ||
            i.artist != null &&
                i.artist!.isNotEmpty &&
                i.artist!.toLowerCase().contains(value)) {
          searchList.addIf(!searchList.contains(i), i);
        }
      }
    } else {
      searchList.clear();
    }
  }

  Future getFiles() async {
    if (Get.arguments != null && Get.arguments is PlayList) {
      query.clear();
      query.value = Get.arguments;
    } else {
      files.value = await _audioQuery.querySongs();
      query.value = files;
      printInfo(info: "bulunan dosya sayısı: ${files.length}");
    }
  }

  Future getPlayLists() async {}

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

  shuffle({RxList<SongModel>? playlist}) {
    if (playlist != null && playlist.isNotEmpty) {
      playlist.shuffle();
    } else {
      query.shuffle();
    }
  }

  loopCurrentSong() {
    if (query[currentIndex.value] != query[currentIndex.value + 1]) {
      query.insert(currentIndex.value + 1, query[currentIndex.value]);
    }
  }

  testplay(PlayType p, {int? i}) async {
    try {
      //files.shuffle();
      if (p == PlayType.next) {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) + 1].data));
        currentSongName.value = files[i ?? currentIndex.value].title;
        swiperController.next();
      } else if (p == PlayType.previous) {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[(i ?? currentIndex.value) - 1].data));
        currentSongName.value = files[i ?? currentIndex.value].title;
        swiperController.previous();
      } else {
        playButton.value = false;
        await player
            .play(DeviceFileSource(files[i ?? currentIndex.value].data));
        currentSongName.value = files[i ?? currentIndex.value].title;
      }
    } catch (e) {
      printError();
    }
  }
}
