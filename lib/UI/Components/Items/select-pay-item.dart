import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class SelectPayItem extends StatelessWidget {
  String icon, title, description;
  bool selected, disable;
  Function? onSelect;
  SelectPayItem(
    this.icon,
    this.title,
    this.description, {
    Key? key,
    this.selected = false,
    this.disable = false,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!disable) onSelect!();
      },
      child: Container(
        height: 70,
        width: maxItemWidth,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 2, color: selected ? appColor : itemColor5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Img(
                  icon,
                  width: 35,
                  height: 25,
                  color: selected ? appColor : itemColor5,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppController.fontStyle(
                        fontTypes.heading3,
                        selected ? appColor : itemColor4,
                      ),
                    ),
                    Text(
                      description,
                      style: AppController.fontStyle(
                        fontTypes.heading5,
                        itemColor4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            selected
                ? Img(tickIcon, width: 24, height: 16, color: appColor)
                : Container(),
          ],
        ),
      ),
    );
  }
}
