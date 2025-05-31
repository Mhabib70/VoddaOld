import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';

class SelectCashItem extends StatelessWidget {
  String value;
  Function? onClick;
  bool selected;
  SelectCashItem(this.value, {Key? key, this.onClick, this.selected = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick!();
      },
      child: Container(
        width: 80,
        height: 40,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: selected ? appColor : itemColor5, width: 2),
        ),
        child: Center(
          child: Text(
            value,
            style: AppController.fontStyle(
              fontTypes.heading3,
              selected ? appColor : itemColor4,
            ),
          ),
        ),
      ),
    );
  }
}
