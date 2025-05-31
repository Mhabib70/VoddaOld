import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/tag.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Items/slider-item1.dart';
import 'package:vodda_old/UI/Components/Items/slider-item2.dart';
import 'package:vodda_old/UI/Components/Items/slider-item3.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

class SliderTypes extends StatelessWidget {
  Tag tagModel = Tag();
  SliderTypes(this.tagModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            width: maxItemWidth,
            child: Column(
              children: [
                (tagModel.type == 0 && tagModel.providerIds.length == 0) ||
                        (tagModel.type != 0 && tagModel.serviceIds.length == 0)
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.only(
                        left: paddingSize,
                        right: paddingSize,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${tagModel.title ?? ''}',
                              style: AppController.fontStyle(
                                fontTypes.heading3,
                                itemColor1,
                              ),
                              maxLines: 1,
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (builder) =>
                                          SubList(tagModel, isTag: true),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'مشاهده همه',
                                  style: AppController.fontStyle(
                                    fontTypes.heading5,
                                    appColor,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Img(
                                  arrowIcon,
                                  width: 5,
                                  height: 10,
                                  color: appColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          tagModel.type == 1
              ? Container(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: Column(
                    children: [
                      for (var service in ServiceController.services.values
                          .where(
                            (element) =>
                                tagModel.serviceIds.contains(element.id) &&
                                element.hasUserCity(),
                          )
                          .take(9))
                        SliderItem1(service),
                    ],
                  ),
                ),
              )
              : tagModel.type == 2
              ? ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: paddingSize),
                      for (var service in ServiceController.services.values
                          .where(
                            (element) =>
                                tagModel.serviceIds.contains(element.id) &&
                                element.hasUserCity(),
                          )
                          .take(5))
                        SliderItem2(service),
                      SizedBox(width: paddingSize),
                    ],
                  ),
                ),
              )
              : tagModel.type == 0
              ? ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: paddingSize),
                      for (var provider in MainController.tagProviders.values
                          .where(
                            (element) =>
                                tagModel.providerIds.contains(element.id) &&
                                element.hasUserCity(),
                          ))
                        SliderItem3(provider),
                      SizedBox(width: paddingSize),
                    ],
                  ),
                ),
              )
              : Container(),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
