import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class TimeItem extends StatelessWidget {
  String time;
  bool selected;
  Function? onClick;
  TimeItem(this.time, {Key? key, this.selected = false, this.onClick})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick!();
      },
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: appColor),
          color: selected ? appColor : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              time.split('-')[0],
              style: AppController.fontStyle(
                fontTypes.heading4,
                selected ? Colors.white : appColor,
              ),
              textDirection: TextDirection.ltr,
            ),
            // Img(clock2Icon,width: 20,height: 20,color: selected?appColor:itemColor4,),
          ],
        ),
      ),
    );
  }
}
