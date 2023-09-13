import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  WebViewExample({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  WebViewExampleState createState() => WebViewExampleState(url: url);
}

class WebViewExampleState extends State<WebViewExample> {
  WebViewExampleState({required this.url});
  final String url;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  function() async {
    // Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Yooto'),
        actions: <Widget>[
          NavigationControls(_controller.future),
          // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right)),
          // SizedBox(
          //   width: 2.w,
          // )
          // Menu(_controller.future, () => _favorites),
        ],
      ),
      body: WillPopScope(
        onWillPop: (() => function()),
        child: Container(
          height: 100.h,
          width: 100.w,
          child: WebView(
            initialUrl: url,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller!, goBack: true),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller!, goBack: false),
            ),
          ],
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack = false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      // );
    }
  }
}
