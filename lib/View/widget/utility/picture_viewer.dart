import 'package:flutter/material.dart';
import '../../../Controller/extension.dart';
import 'package:photo_view/photo_view.dart';

void pictureViewer(BuildContext context, String url) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return Material(
        color: Colors.white,
        child: SizedBox.expand(
          child: Stack(
            children: [
              PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.white),
                controller: PhotoViewController(),
                // imageProvider: NetworkImage(url),
                imageProvider: AssetImage(url),
                loadingBuilder: (context, event) {
                  if (event == null || event.cumulativeBytesLoaded != event.expectedTotalBytes) {
                    return const AspectRatio(
                      aspectRatio: 1,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: context.paddingTop + 20
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ));
}
