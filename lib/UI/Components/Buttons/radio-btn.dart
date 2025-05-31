import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';

class RadioBtn extends StatelessWidget {
  var groupValue, optionValue;
  Function? onClick;
  String? lable, description;
  RadioBtn(
    this.groupValue,
    this.optionValue, {
    this.onClick,
    this.lable,
    this.description,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) onClick!();
      },

      child: Container(
        width: maxItemWidth,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio<dynamic>(
                  activeColor: appColor,
                  groupValue: groupValue,
                  value: optionValue,
                  onChanged: (value) {
                    if (onClick != null) onClick!();
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    this.lable ?? '',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor1,
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
            description != null
                ? Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 40),
                  child: Text(
                    this.description!,
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor4,
                    ),
                    maxLines: null,
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
