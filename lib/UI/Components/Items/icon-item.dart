import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class IconItem extends StatelessWidget {
  String icon, text, value;
  IconItem(this.icon, this.text, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Img(icon, color: appColor2, width: 28, height: 28),
        Text(
          '${text}',
          style: AppController.fontStyle(fontTypes.text2, itemColor4),
        ),
        Text(
          '${value}',
          style: AppController.fontStyle(fontTypes.heading3, itemColor1),
        ),
      ],
    );
  }
}
