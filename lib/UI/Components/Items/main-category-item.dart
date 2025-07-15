import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class MainCategoryItem extends StatefulWidget {
  Category? categoryModel;
  Function? onClick;
  bool isSelective, isMainPage;
  MainCategoryItem(
    this.categoryModel, {
    super.key,
    this.onClick,
    this.isSelective = false,
    this.isMainPage = false,
  });

  @override
  State<MainCategoryItem> createState() => _MainCategoryItemState();
}

class _MainCategoryItemState extends State<MainCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) widget.onClick!();
      },
      child: GetBuilder<ServiceController>(
        builder:
            (serviceController) => Container(
              width: 80,
              margin: EdgeInsets.only(left: 20, right: 20),

              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color:
                        serviceController.selectedCategory.value ==
                                    widget.categoryModel?.id &&
                                widget.isSelective
                            ? appColor
                            : Colors.transparent,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    height: 70,
                    child:
                        widget.categoryModel?.icon != null
                            ? Img(
                              widget.categoryModel!.icon!,
                              width: 80,
                              height: 70,
                              isNetwork: true,
                            )
                            : Container(),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.categoryModel?.title ?? '',
                    style: AppController.fontStyle(
                      widget.isMainPage
                          ? fontTypes.regular15
                          : fontTypes.regular15,
                      itemColor1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
