import 'package:webview_flutter/webview_flutter.dart';

import '../../utilities/helpers/user/play_list_model.dart';
import '../../utilities/helpers/user/user.dart';

abstract class IUserService {
  Future<User?> getUserInfo(String userId);

  Future<PlayList?> getPlayList(String playListId);

  Future<NavigationDecision> logIn(NavigationRequest request);
}
