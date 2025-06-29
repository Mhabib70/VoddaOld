import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';

class BreadcrumbItem extends StatelessWidget {
  Category categoryModel = Category();
  BreadcrumbItem(this.categoryModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ServiceController>().getCategoryServices(categoryModel.id!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => SubList(categoryModel)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10),
        width: 135,
        height: 45,
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(5),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Img(categoryModel.icon!, width: 20, height: 20, isNetwork: true),
            Container(
              width: 80,
              child: Text(
                '${categoryModel.title ?? ''}',
                style: AppController.fontStyle(fontTypes.heading5, itemColor1),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Icon(Icons.arrow_forward_ios,size: 13,color: itemColor4,)
          ],
        ),
      ),
    );
  }
}
