import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import '../../../Controller/extension.dart';
import '/view/widget/dialog/popup.dart';

class CopyOnTap extends StatelessWidget {
  const CopyOnTap(this.text, {Key? key, this.description, this.delay = const Duration(milliseconds: 500), this.barrierColor, this.style, this.showCopyIcon = false, this.callback, this.isPhone = false}) : super(key: key);
  final String? description;
  final String text;
  final Duration delay;
  final Color? barrierColor;
  final TextStyle? style;
  final bool showCopyIcon;
  final bool isPhone;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerLeft,
      fit: BoxFit.scaleDown,
      child: GestureDetector(
        onTap: () {
          if (callback != null) {
            callback!.call();
          } else {
            FlutterClipboard.copy(text);
            appModalPopup(context, '${description ?? text.toString().addQuotes()} kopyalandı', delay: delay, barrierColor: barrierColor);
          }
        },
        child: Row(
          children: [
            Text(text),
            if (showCopyIcon)
              Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(
                    Icons.copy,
                    size: style?.fontSize ?? 14,
                    color: style?.color?.withOpacity(.5) ?? Colors.black.withOpacity(.5),
                  )),
          ],
        ),
      ),
    );
  }
}
