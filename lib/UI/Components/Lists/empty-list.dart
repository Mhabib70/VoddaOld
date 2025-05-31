import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class EmptyList extends StatelessWidget {
  String icon;
  String text;
  double? height;
  fontTypes fontType;
  EmptyList(
    this.icon, {
    Key? key,
    this.text = 'لیست خالی میباشد !',
    this.height,
    this.fontType = fontTypes.heading1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: height == null ? size.height : height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Img(icon, height: 80, width: 80, color: appColor),
            SizedBox(height: 30),
            Text(
              text,
              style: AppController.fontStyle(fontType, itemColor1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
