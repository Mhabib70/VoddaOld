import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class MainSlider extends StatelessWidget {
  const MainSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 4,
      child: CarouselSlider(
        options: CarouselOptions(
          height: size.height,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: size.width > maxItemWidth ? false : true,
          scrollDirection: Axis.horizontal,
          viewportFraction:
              size.width > maxItemWidth
                  ? 0.3
                  : 0.8, //for increase showing items
        ),
        items: [
          for (var image in MainController.mainSlider)
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width > maxItemWidth ? 15 : 0,
              ),
              child: Img(
                image,
                width: size.width,
                height: size.height / 4,
                isNetwork: true,
                radius: 15,
              ),
            ),
        ],
      ),
    );
  }
}
