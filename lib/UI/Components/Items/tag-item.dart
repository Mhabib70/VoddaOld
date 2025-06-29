import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/tag.dart';
import 'package:vodda_old/Public/config.dart';

class TagItem extends StatelessWidget {
  Tag tagModel = Tag();
  TagItem(this.tagModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 90,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: appColor),
        borderRadius: BorderRadius.circular(5),
        color: appColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${tagModel.title ?? ''}',
            style: AppController.fontStyle(fontTypes.heading5, appColor),
          ),
          GestureDetector(
            onTap: () {
              Get.find<ServiceController>().selectedTags.remove(tagModel);
            },
            child: Icon(Icons.clear, size: 15, color: appColor),
          ),
        ],
      ),
    );
  }
}
