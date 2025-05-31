import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/category-item.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10,
            left: paddingSize,
            right: paddingSize,
          ),
          child: Input(
            lable: 'جستجو در دسته بندی ها ...',
            initValue: ServiceController.categoryText,
            icon1: Container(
              width: 22,
              height: 22,
              child: Img(searchIcon, width: 22, height: 22, color: itemColor2),
            ),
            width: maxItemWidth,
            onChange: (text) {
              ServiceController.categoryText = text;
              ServiceController.findCategory(text);
            },
          ),
        ),
        Expanded(
          child: MyScroll(
            child: Obx(() {
              return Container(
                margin: EdgeInsets.only(left: paddingSize, right: paddingSize),
                width: size.width,
                child:
                    ServiceController.searchedCategories.value.length == 0 &&
                            ServiceController.categoryText == ''
                        ? Column(
                          children: [
                            SizedBox(height: 15),
                            for (var category
                                in ServiceController.categories.values)
                              if (category.categoryId == null)
                                CategoryItem(category),
                          ],
                        )
                        : Column(
                          children: [
                            SizedBox(height: 15),
                            for (var category
                                in ServiceController.searchedCategories.value)
                              CategoryItem(category, useSub: false),
                          ],
                        ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
