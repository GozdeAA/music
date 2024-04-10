import 'package:flutter/material.dart';
import 'package:freechoice_music/services/abstract/i_user_service.dart';
import 'package:freechoice_music/utilities/network/endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';


//todo add vm
//Todo add get it
class AuthDeezer extends StatefulWidget {
  const AuthDeezer({Key? key}) : super(key: key);

  @override
  State<AuthDeezer> createState() => _AuthDeezerState();
}

class _AuthDeezerState extends State<AuthDeezer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    var userService = GetIt.I<IUserService>();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            return userService.logIn(request);
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(authUrl));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
