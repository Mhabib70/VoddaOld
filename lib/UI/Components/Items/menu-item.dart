import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class ListMenuItem extends StatelessWidget {
  String icon, text;
  Function? onClick;
  bool isNetwork;
  ListMenuItem(
    this.icon,
    this.text, {
    Key? key,
    this.onClick,
    this.isNetwork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          if (onClick != null) onClick!();
        },
        child: Container(
          height: 45,
          width: maxItemWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Img(
                    icon,
                    color: appColor,
                    width: 20,
                    height: 20,
                    isNetwork: isNetwork,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor2,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 15, color: itemColor4),
            ],
          ),
        ),
      ),
    );
  }
}
