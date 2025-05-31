import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Items/advertise-item.dart';
import 'package:vodda_old/UI/Components/Items/main-category-item.dart';
import 'package:vodda_old/UI/Components/Sliders/detail-slider.dart';
import 'package:vodda_old/UI/Components/Sliders/main-slider.dart';
import 'package:vodda_old/UI/Components/Sliders/slider-types-.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScroll(
      child: Column(
        children: [
          // SizedBox(height: 30,),
          // size.width<maxItemWidth?
          // MainSlider()
          //     :
          DetailSlider(MainController.mainSlider, padding: paddingSize),

          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var advertise in MainController.ads)
                      AdvertiseItem(advertise),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: [
                for (var category in ServiceController.categories.values)
                  if (category.categoryId == null)
                    MainCategoryItem(
                      category,
                      isMainPage: true,
                      onClick: () {
                        ServiceController.getCategoryServices(category.id!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => SubList(category),
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
          for (var tag in ServiceController.serviceTags) SliderTypes(tag),
          for (var tag in ServiceController.providerTags) SliderTypes(tag),
        ],
      ),
    );
  }
}
