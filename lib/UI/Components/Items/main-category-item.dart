import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class MainCategoryItem extends StatefulWidget {
  Category categoryModel;
  Function? onClick;
  bool isSelective, isMainPage;
  MainCategoryItem(
    this.categoryModel, {
    Key? key,
    this.onClick,
    this.isSelective = false,
    this.isMainPage = false,
  }) : super(key: key);

  @override
  State<MainCategoryItem> createState() => _MainCategoryItemState();
}

class _MainCategoryItemState extends State<MainCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (widget.onClick != null) widget.onClick!();
        },
        child: Container(
          width: 100,
          margin: EdgeInsets.only(left: 20, right: 20),

          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color:
                    ServiceController.selectedCategory.value ==
                                widget.categoryModel.id &&
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
              Container(
                width: 100,
                height: 90,
                child:
                    widget.categoryModel.icon != null
                        ? Img(
                          widget.categoryModel.icon!,
                          width: 100,
                          height: 90,
                          isNetwork: true,
                        )
                        : Container(),
              ),
              SizedBox(width: 10),
              Text(
                '${widget.categoryModel.title ?? ''}',
                style: AppController.fontStyle(
                  widget.isMainPage ? fontTypes.regular15 : fontTypes.regular15,
                  itemColor1,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      );
    });
  }
}
