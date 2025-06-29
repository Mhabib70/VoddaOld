import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/main-category-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Items/tag-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/checkbox.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: paddingSize, right: paddingSize),
            child: Column(
              children: [
                GetBuilder<ServiceController>(
                  builder:
                      (serviceController) => Input(
                        lable: 'جستجو در خدمات و سرویس ها ...',
                        initValue: serviceController.serviceText,
                        icon1: SizedBox(
                          width: 22,
                          height: 22,
                          child: Img(
                            searchIcon,
                            width: 22,
                            height: 22,
                            color: itemColor2,
                          ),
                        ),
                        width: maxItemWidth,
                        onChange: (text) {
                          serviceController.serviceText = text;
                          Get.find<ServiceController>().getSearchedServices(
                            text,
                          );
                        },
                        icon2: InkWell(
                          onTap: () {
                            showBottomModal(
                              context,
                              550,
                              Column(
                                children: [
                                  SizedBox(height: 15),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Img(filterIcon),
                                            SizedBox(width: 20),
                                            Text(
                                              'فیلتر ها',
                                              style: AppController.fontStyle(
                                                fontTypes.heading2,
                                                itemColor1,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Text('حذف همه',style: ServiceController.fontStyle(fontType.heading5, itemColor2),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (
                                            int i = 0;
                                            i <
                                                serviceController
                                                    .providerTags
                                                    .length;
                                            i++
                                          )
                                            CheckBox(
                                              serviceController
                                                  .providerTags[i]
                                                  .title!,
                                              value: serviceController
                                                  .selectedTags
                                                  .value
                                                  .contains(
                                                    serviceController
                                                        .providerTags[i],
                                                  ),
                                              onClick: (value) {
                                                if (value) {
                                                  serviceController.selectedTags
                                                      .add(
                                                        serviceController
                                                            .providerTags[i],
                                                      );
                                                } else {
                                                  serviceController.selectedTags
                                                      .remove(
                                                        serviceController
                                                            .providerTags[i],
                                                      );
                                                }
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Icon(
                            Icons.filter_alt_outlined,
                            size: 25,
                            color: itemColor4,
                          ),
                        ),
                      ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<ServiceController>(
                        builder:
                            (serviceController) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var category
                                    in serviceController.categories.values)
                                  if (category.categoryId == null)
                                    MainCategoryItem(
                                      category,
                                      isSelective: true,
                                      onClick: () {
                                        if (serviceController
                                                .selectedCategory
                                                .value !=
                                            category.id) {
                                          serviceController
                                              .selectedCategory
                                              .value = category.id!;
                                        } else {
                                          serviceController
                                              .selectedCategory
                                              .value = 0;
                                        }
                                      },
                                    ),
                              ],
                            ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<ServiceController>(
                  builder: (serviceController) {
                    return Center(
                      child:
                          serviceController.selectedTags.isNotEmpty
                              ? Container(
                                padding: EdgeInsets.only(bottom: paddingSize),
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(
                                    context,
                                  ).copyWith(
                                    dragDevices: {
                                      PointerDeviceKind.touch,
                                      PointerDeviceKind.mouse,
                                    },
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (
                                          int i = 0;
                                          i <
                                              serviceController
                                                  .selectedTags
                                                  .length;
                                          i++
                                        )
                                          TagItem(
                                            serviceController.selectedTags[i],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              : Container(),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<ServiceController>(
              builder:
                  (serviceController) => Loading(
                    getLoadedComponent:
                        () =>
                            serviceController.searchedServices.isNotEmpty
                                ? MyScroll(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: paddingSize,
                                      right: paddingSize,
                                    ),
                                    width: size.width,
                                    child: Column(
                                      children: [
                                        for (var serviceId
                                            in serviceController
                                                .searchedServices)
                                          if (serviceController
                                              .services[serviceId]!
                                              .hasUserCity())
                                            ServiceItem(
                                              serviceController
                                                  .services[serviceId]!,
                                            ),
                                      ],
                                    ),
                                  ),
                                )
                                : EmptyList(searchIcon),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
