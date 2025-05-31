import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class AdvertisePage extends StatelessWidget {
  String image;
  AdvertisePage(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(gradient: topGradient),
          child: Stack(
            children: [
              Img(
                image,
                width: size.width,
                height: size.height,
                isNetwork: true,
              ),
              Positioned(
                top: paddingSize,
                left: paddingSize,
                child: Img(
                  backIcon,
                  color: whiteColor,
                  width: 33,
                  height: 30,
                  onClick: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
