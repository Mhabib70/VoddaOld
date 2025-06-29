import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Items/advertise-item.dart';
import 'package:vodda_old/UI/Components/Items/main-category-item.dart';
import 'package:vodda_old/UI/Components/Sliders/detail-slider.dart';
import 'package:vodda_old/UI/Components/Sliders/slider-types-.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScroll(
      child: Column(
        children: [
          // SizedBox(height: 30,),
          // size.width<maxItemWidth?
          // MainSlider()
          //     :
          GetBuilder<MainController>(
            builder:
                (controller) =>
                    DetailSlider(controller.mainSlider, padding: paddingSize),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<MainController>(
                  builder:
                      (controller) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var advertise in controller.ads)
                            AdvertiseItem(advertise),
                        ],
                      ),
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
          // for(var tag in ServiceController.providerTags)
          //     SliderTypes(tag),
          Text(
            'ما را در شبکه های اجتماعی دنبال کنید',
            style: AppController.fontStyle(fontTypes.heading3, itemColor1),
            maxLines: 1,
          ),
          SizedBox(height: 15),
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: GetBuilder<MainController>(
              builder: (controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.setting.containsKey("socials"))
                        for (var json in controller.setting['socials'])
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {
                                launchUrlString(json['link']);
                              },
                              child: Img(
                                json['file'],
                                width: 100,
                                height: 100,
                                isNetwork: true,
                              ),
                            ),
                          ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
