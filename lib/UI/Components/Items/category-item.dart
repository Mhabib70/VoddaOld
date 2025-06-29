import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'dart:math' as math;

import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';

class CategoryItem extends StatefulWidget {
  Category model = Category();
  bool useSub;
  CategoryItem(this.model, {Key? key, this.useSub = true}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool showAccordion = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxItemWidth,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.model.hasSub! && widget.useSub)
                setState(() {
                  showAccordion = !showAccordion;
                });
              else {
                Get.find<ServiceController>().getCategoryServices(
                  widget.model.id!,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => SubList(widget.model),
                  ),
                );
              }
            },
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        widget.model.icon != null
                            ? Img(
                              widget.model.icon!,
                              isNetwork: true,
                              width: 60,
                              height: 60,
                              radius: 60,
                            )
                            : Container(width: 60, height: 60),

                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.model.title ?? ''}',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  itemColor1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Text('${widget.model.description??''}',style: AppController.fontStyle(fontTypes.text2, itemColor4),maxLines: 2,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Transform.rotate(
                    angle: showAccordion ? -math.pi / 2 : 0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: appColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          showAccordion
              ? Column(
                children: [
                  SizedBox(height: 10),
                  for (var category in widget.model.categories)
                    InkWell(
                      onTap: () {
                        if (!category.hasSub!) {
                          Get.find<ServiceController>().getCategoryServices(
                            category.id!,
                          );
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => SubList(category),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15, bottom: 5, top: 5),
                        child: Row(
                          children: [
                            Img(
                              arrowIcon,
                              width: 5,
                              height: 10,
                              color: appColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${category.title ?? ''}',
                              style: AppController.fontStyle(
                                fontTypes.text2,
                                itemColor3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
              : Container(),
          MyDivider(),
        ],
      ),
    );
  }
}
