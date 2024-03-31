import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freechoice_music/utilities/network/endpoints.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/helpers/user/session.dart';

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
            if (request.url.startsWith(redirectUrl)) {
              //close webview
              //put loading

              //add cancel option
              try{
                //show laoding
                var urlList = request.url.toString().split("$redirectUrl?code=");
                Session.code = urlList.last;
                var res = await Dio().request(tokenUrl + Session.code!);
                var match = res.data.toString().split("access_token=");
                Session.token = match.last.toString().split("&").first;
                Get.back();
                return NavigationDecision.prevent;
              }catch(e){
                // controller.clearCache(); bu gerekli mi asko
                Get.back();
                //show message error
                return NavigationDecision.prevent;
              }

            } else {
              return NavigationDecision.navigate;
            }
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
    return WebViewWidget(
      controller: _controller,
    );
  }
}
