import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class OverviewItem extends StatelessWidget {
  bool isRow;
  String icon, title, value;
  OverviewItem(
    this.icon, {
    this.isRow = true,
    this.title = '',
    this.value = '',
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Flex(
        direction: isRow ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Img(icon, width: 18, height: 18, color: appColor),
              SizedBox(width: 10),
              Text(
                title,
                style: AppController.fontStyle(fontTypes.heading5, appColor),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            value,
            style: AppController.fontStyle(fontTypes.heading4, itemColor1),
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
