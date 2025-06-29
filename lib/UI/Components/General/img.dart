import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';

class Img extends StatelessWidget {
  String path;
  double? width, height, radius;
  Color? color;
  Function? onClick;
  bool isNetwork;
  BoxFit fit;
  Img(
    this.path, {
    this.width,
    this.height,
    this.radius,
    this.color,
    this.onClick,
    this.isNetwork = false,
    this.fit = BoxFit.fill,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          this.onClick == null
              ? null
              : () {
                this.onClick!();
              },
      child: Center(
        child: Container(
          width: this.width,
          height: this.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 0),

            child:
                path.split('.').last == 'svg'
                    ? isNetwork
                        ? SvgPicture.network(
                          (kIsWeb ? baseApiUrl : baseUrl) + this.path,
                          color: this.color,
                          fit: fit,
                        )
                        : SvgPicture.asset(
                          this.path,
                          color: this.color,
                          fit: fit,
                        )
                    : isNetwork
                    ? CachedNetworkImage(
                      imageUrl: (kIsWeb ? baseApiUrl : baseUrl) + path,
                      fit: fit,
                      placeholder:
                          (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: SizedBox(),
                          ),
                      errorWidget:
                          (context, url, error) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: SizedBox(),
                          ),
                    )
                    : Image.asset(path, fit: fit),

            // Image.network(

            //   fit: fit,
            //   errorBuilder:
            //       (context, error, stackTrace) => Shimmer.fromColors(
            //         baseColor: Colors.grey[300]!,
            //         highlightColor: Colors.grey[100]!,
            //         child: SizedBox(),
            //       ),
            //   loadingBuilder: (context, child, loadingProgress) {
            //     try {
            //       if (loadingProgress!.cumulativeBytesLoaded ==
            //           loadingProgress.expectedTotalBytes) {
            //         return child;
            //       }
            //     } catch (e) {}
            //     return Shimmer.fromColors(
            //       baseColor: Colors.grey[300]!,
            //       highlightColor: Colors.grey[100]!,
            //       child: child,
            //     );
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
