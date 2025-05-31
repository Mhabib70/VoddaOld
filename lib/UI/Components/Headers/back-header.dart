import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class BackHeader extends StatelessWidget {
  double padding;
  String title;
  bool hasLogo;
  BackHeader({
    this.padding = paddingSize,
    this.title = '',
    this.hasLogo = true,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 80,
        width: size.width,

        padding: EdgeInsets.only(left: this.padding, right: this.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  hasLogo ? Img(appLogo, width: 40) : Container(),
                  hasLogo ? SizedBox(width: 20) : Container(),
                  Expanded(
                    child: Text(
                      title,
                      style: AppController.fontStyle(
                        fontTypes.heading3,
                        itemColor1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(width: 40, height: 40, child: Img(backIcon)),
            ),
          ],
        ),
      ),
    );
  }
}
