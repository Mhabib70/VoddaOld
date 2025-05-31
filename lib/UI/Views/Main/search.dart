import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
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
                Input(
                  lable: 'جستجو در خدمات و سرویس ها ...',
                  initValue: ServiceController.serviceText,
                  icon1: Container(
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
                    ServiceController.serviceText = text;
                    ServiceController.getSearchedServices(text);
                  },
                  icon2: InkWell(
                    onTap: () {
                      showBottomModal(
                        context,
                        550,
                        Column(
                          children: [
                            SizedBox(height: 15),
                            Container(
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
                                      i < ServiceController.providerTags.length;
                                      i++
                                    )
                                      CheckBox(
                                        ServiceController
                                            .providerTags[i]
                                            .title!,
                                        value: ServiceController
                                            .selectedTags
                                            .value
                                            .contains(
                                              ServiceController.providerTags[i],
                                            ),
                                        onClick: (value) {
                                          if (value)
                                            ServiceController.selectedTags.add(
                                              ServiceController.providerTags[i],
                                            );
                                          else
                                            ServiceController.selectedTags
                                                .remove(
                                                  ServiceController
                                                      .providerTags[i],
                                                );
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var category
                              in ServiceController.categories.values)
                            if (category.categoryId == null)
                              MainCategoryItem(
                                category,
                                isSelective: true,
                                onClick: () {
                                  if (ServiceController
                                          .selectedCategory
                                          .value !=
                                      category.id)
                                    ServiceController.selectedCategory.value =
                                        category.id!;
                                  else
                                    ServiceController.selectedCategory.value =
                                        0;
                                },
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Center(
                    child:
                        ServiceController.selectedTags.length > 0
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
                                            ServiceController
                                                .selectedTags
                                                .length;
                                        i++
                                      )
                                        TagItem(
                                          ServiceController.selectedTags[i],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            : Container(),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Loading(
              getLoadedComponent:
                  () =>
                      ServiceController.searchedServices.length > 0
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
                                      in ServiceController.searchedServices)
                                    if (ServiceController.services[serviceId]!
                                        .hasUserCity())
                                      ServiceItem(
                                        ServiceController.services[serviceId]!,
                                      ),
                                ],
                              ),
                            ),
                          )
                          : EmptyList(searchIcon),
            ),
          ),
        ],
      ),
    );
  }
}
