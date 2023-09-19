import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

enum DialogType { success, warning, info, failed }

IconData _getDialogIcon(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return CupertinoIcons.check_mark;
    case DialogType.info:
      return CupertinoIcons.question;
    case DialogType.warning:
      return CupertinoIcons.exclamationmark;
    case DialogType.failed:
      return CupertinoIcons.xmark;
    default:
      return Icons.question_mark_outlined;
  }
}

String _getDialogSubmitTitle(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return 'ok';
    case DialogType.info:
      return 'iknown';
    case DialogType.warning:
      return 'accept';
    case DialogType.failed:
      return 'ok';
    default:
      return 'ok';
  }
}

String _getDialogMessage(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return 'success';
    case DialogType.info:
      return 'areYouAccept';
    case DialogType.warning:
      return 'toBeContinue';
    case DialogType.failed:
      return 'failed';
    default:
      return 'ok';
  }
}

String _getRouteName(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return 'success_dialog';
    case DialogType.info:
      return 'info_dialog';
    case DialogType.warning:
      return 'warning_dialog';
    case DialogType.failed:
      return 'failed_dialog';
    default:
      return 'app_dialog';
  }
}

Color _getDialogColor(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.success:
      return Colors.greenAccent.shade700;
    case DialogType.info:
      return Colors.blueAccent.shade400;
    case DialogType.warning:
      return Colors.orange.shade700;
    case DialogType.failed:
      return Colors.redAccent.shade700;
    default:
      return Colors.grey.shade700;
  }
}

Future appDialog(
  BuildContext context, {
  bool onWillPop = false,
  String? message,
  String? routename,
  DialogType dialogType = DialogType.warning,
  Widget? child,
  bool showButtonForChild = true,
}) {
  double aspectRatio = 2;
  double elevation = 10;
  double radius = 20;
  String? submitTitle;
  String cancelTitle = 'cancel';
  IconData? icon;
  return showCupertinoDialog(
    context: context,
    routeSettings: RouteSettings(
        name: routename != null
            ? routename
            : child == null
                ? _getRouteName(dialogType)
                : "dialogHaveChild"),
    // barrierColor: barrierColor.withOpacity(.5),
    barrierDismissible: child == null ? onWillPop : !showButtonForChild,
    builder: (context) {
      return BackdropFilter(
        // filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        filter: ColorFilter.mode(Theme.of(context).scaffoldBackgroundColor.withOpacity(.75), BlendMode.srcOver),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: elevation,
            shadowColor: const Color.fromARGB(180, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: (child == null)
                ? AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(icon ?? _getDialogIcon(dialogType), size: 30, color: context.theme.iconTheme.color),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(message ?? context.translete(_getDialogMessage(dialogType)), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ))
                            ],
                          ),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: kToolbarHeight,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: dialogType != DialogType.warning ? BorderRadius.vertical(bottom: Radius.circular(radius * 0.5)) : BorderRadius.only(bottomLeft: Radius.circular(radius * 0.5)))),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return _getDialogColor(dialogType);
                                      } else {
                                        return _getDialogColor(dialogType);
                                        // return Theme.of(context).scaffoldBackgroundColor;
                                      }
                                    }),
                                  ),
                                  child: Center(child: Text(submitTitle ?? context.translete(_getDialogSubmitTitle(dialogType)), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium!.color!))),
                                ),
                              ),
                            ),
                            if (dialogType == DialogType.warning)
                              Expanded(
                                child: SizedBox(
                                  height: kToolbarHeight,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius * 0.5)))),
                                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                                        if (states.contains(MaterialState.pressed)) {
                                          return Theme.of(context).textTheme.bodyMedium!.color!;
                                        } else {
                                          return Theme.of(context).scaffoldBackgroundColor;
                                        }
                                      }),
                                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                                        if (states.contains(MaterialState.pressed)) {
                                          return Theme.of(context).scaffoldBackgroundColor;
                                        } else {
                                          return Theme.of(context).textTheme.bodyMedium!.color!;
                                        }
                                      }),
                                    ),
                                    child: Center(child: Text(context.translete(cancelTitle), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ))
                : AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
                            child: SizedBox.expand(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                        (showButtonForChild)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: kToolbarHeight,
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: dialogType != DialogType.warning ? BorderRadius.vertical(bottom: Radius.circular(radius * 0.5)) : BorderRadius.only(bottomLeft: Radius.circular(radius * 0.5)))),
                                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return Theme.of(context).scaffoldBackgroundColor;
                                            } else {
                                              return Colors.greenAccent.shade700;
                                            }
                                          }),
                                        ),
                                        child: Center(child: Text(submitTitle ?? context.translete(_getDialogSubmitTitle(dialogType)), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium!.color!))),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: kToolbarHeight,
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius * 0.5)))),
                                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return Theme.of(context).textTheme.bodyMedium!.color!;
                                            } else {
                                              return Theme.of(context).scaffoldBackgroundColor;
                                            }
                                          }),
                                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return Theme.of(context).scaffoldBackgroundColor;
                                            } else {
                                              return Theme.of(context).textTheme.bodyMedium!.color!;
                                            }
                                          }),
                                        ),
                                        child: Center(child: Text(context.translete(cancelTitle), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
          ),
        ),
      );
    },
  );
}
