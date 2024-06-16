import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/play_list/play_list_model.dart';
import '../../../models/user/user.dart';

abstract class IUserService {
  Future<User?> getUserInfo(String userId);

  Future<PlayList?> getPlayList(String playListId);

  Future<NavigationDecision> logIn(NavigationRequest request);
}
