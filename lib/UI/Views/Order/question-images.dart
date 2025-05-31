import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';

class QuestionImages extends StatelessWidget {
  var galleryItems;
  QuestionImages(this.galleryItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              (kIsWeb ? baseApiUrl : baseUrl) + galleryItems[index],
            ),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
          );
        },
        itemCount: galleryItems.length,
        loadingBuilder:
            (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value:
                      event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!.toInt(),
                ),
              ),
            ),
        // backgroundDecoration: backgroundDecoration,
        // pageController: pageController,
        onPageChanged: (index) {},
      ),
    );
  }
}
