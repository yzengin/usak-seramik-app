import '/Controller/asset.dart';
import '/Controller/extension.dart';
import '/View/widget/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  ValueNotifier<bool> onWebLoad = ValueNotifier<bool>(false);
  ValueNotifier<double> onWebLoadProgress = ValueNotifier<double>(0);

  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onUrlChange: (change) {},
        onPageStarted: (url) {
          onWebLoad.value = true;
          setState(() {});
        },
        onNavigationRequest: (request) async {
          debugPrint('new -- ${request.url}');
          if (request.url != context.routeArguments?[0]) {
            await appDialog(context, dialogType: DialogType.warning, message: context.translete('leaveAppWebviewTitle')).then((value) async {
              if (value) {
                if (await canLaunchUrl(Uri.parse(context.routeArguments?[0]))) {
                  await launchUrl(Uri.parse(context.routeArguments?[0]), mode: LaunchMode.externalApplication);
                }
              } else {
                return NavigationDecision.prevent;
              }
            });
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onProgress: (progress) {
          onWebLoadProgress.value = progress.reduceRange01(100, 0);
          if (progress == 100) {
            if (onWebLoad.value) {}
            onWebLoad.value = false;
          }
        },
      ),
    )
    ..loadRequest(Uri.parse(context.routeArguments?[0]));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.clearCache();
    controller.clearLocalStorage();
    onWebLoad.dispose();
    onWebLoadProgress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (context.routeArguments?[2] == null ? false : context.routeArguments![2])
        ? Stack(
            children: [
              WebViewWidget(controller: controller),
              ValueListenableBuilder(
                valueListenable: onWebLoad,
                builder: (context, value, child) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (mounted) {
                      if (onWebLoad.value) {}
                    }
                  });
                  return SizedBox();
                },
              )
            ],
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(context.routeArguments?[1] ?? ""),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    AppImage.logo,
                    color: context.theme.textTheme.bodyMedium!.color,
                  ),
                )
              ],
            ),
            body: ValueListenableBuilder(
                valueListenable: onWebLoad,
                builder: (context, _, __) {
                  if (onWebLoad.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return WebViewWidget(controller: controller);
                  }
                  // return Stack(
                  //   children: [
                  //     ValueListenableBuilder(
                  //       valueListenable: onWebLoad,
                  //       builder: (context, value, child) {
                  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //           if (mounted) {
                  //             if (onWebLoad.value) {
                  //               // appProcess(context);
                  //             }
                  //           }
                  //         });
                  //         return SizedBox();
                  //       },
                  //     )
                  //   ],
                  // );
                }),
          );
  }
}
