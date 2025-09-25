import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class DetailSlider extends StatefulWidget {
  List images = [];
  double padding;
  DetailSlider(this.images, {Key? key, this.padding = 0}) : super(key: key);

  @override
  _DetailSliderState createState() => _DetailSliderState();
}

class _DetailSliderState extends State<DetailSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: maxItemWidth,
      height: size.height / 4,
      margin: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
      decoration: BoxDecoration(boxShadow: shadow2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.width < maxItemWidth ? 300 : maxItemWidth,
              initialPage: 0,
              enlargeCenterPage: false,
              disableCenter: false,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              reverse: true,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, a) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: [
              if (widget.images.isEmpty)
                for (int i = 0; i < 3; i++)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: maxItemWidth,
                      height: size.width < maxItemWidth ? 300 : maxItemWidth,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
              for (int i = 0; i < widget.images.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: widget.padding),
                  child: Img(
                    widget.images[i],
                    width: maxItemWidth,
                    height: size.width < maxItemWidth ? 300 : maxItemWidth,
                    isNetwork: true,

                    radius: 25,
                  ),
                ),
            ],
          ),
          widget.images.length > 1
              ? Positioned(
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = widget.images.length - 1; i >= 0; i--)
                      Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 3.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == i ? appColor2 : whiteColor,
                        ),
                      ),
                  ],
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
