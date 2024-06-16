import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freechoice_music/repository/services/abstract/i_user_service.dart';
import 'package:freechoice_music/utilities/network/endpoints.dart';
import 'package:freechoice_music/utilities/network/network_helper.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../models/play_list/play_list_model.dart';
import '../../../utilities/helpers/user/session.dart';
import '../../../models/user/user.dart';

class UserService extends IUserService {
  @override
  Future<User?> getUserInfo(String userId) async {
    var res = await HttpHelper.get("${mainUrl}user$userId");
    if (res.data != null) {
      var user = User.fromJson(res.data!);
      return user;
    } else {
      debugPrint("error on getting user info");
      return null;
    }
  }

  @override
  Future<PlayList?> getPlayList(String playListId) async {
    var res = await HttpHelper.get("${mainUrl}playlist$playListId");
    if (res.data != null) {
      var playList = PlayList.fromJson(res.data);
      return playList;
    } else {
      return null;
    }
  }

  @override
  Future<NavigationDecision> logIn(NavigationRequest request) async {
    if (request.url.startsWith(redirectUrl)) {
      //add cancel option
      try {
        Get.back();
        EasyLoading.show();
        var urlList = request.url.toString().split("$redirectUrl?code=");
        Session.code = urlList.last;
        var res = await Dio().request(tokenUrl + Session.code!);
        var match = res.data.toString().split("access_token=");
        Session.token = match.last.toString().split("&").first;
        EasyLoading.dismiss();
        Session.saveToken();
        return NavigationDecision.prevent;
      } catch (e) {
        // controller.clearCache(); bu gerekli mi asko
        Get.back();
        //show message error
        return NavigationDecision.prevent;
      }
    } else {
      return NavigationDecision.navigate;
    }
  }
}
