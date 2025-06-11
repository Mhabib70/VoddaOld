import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/date.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';

class DateItem extends StatelessWidget {
  Date date = Date();
  bool selected;
  Function? onClick;
  DateItem(this.date, {Key? key, this.selected = false, this.onClick})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onClick != null) this.onClick!();
      },
      child: Container(
        width: 90,
        height: 110,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: selected ? 3 : 1,
            color: selected ? appColor : itemColor5,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${date.weekDay ?? ''}',
              style: AppController.fontStyle(
                fontTypes.heading5,
                selected ? appColor : itemColor2,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: selected ? appColor : Colors.transparent,
              ),
              child: Text(
                '${int.parse((date.day) ?? '0')}',
                style: AppController.fontStyle(
                  fontTypes.heading3,
                  selected ? whiteColor : itemColor1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '${date.month ?? ''}',
              style: AppController.fontStyle(
                fontTypes.text2,
                selected ? appColor : itemColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
