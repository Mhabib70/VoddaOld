import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class MainSlider extends StatelessWidget {
  const MainSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height / 4,
      child: GetBuilder<MainController>(
        builder:
            (controller) => CarouselSlider(
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
                for (var image in controller.mainSlider)
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
      ),
    );
  }
}
