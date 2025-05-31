import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/styles.dart';
import 'dart:math' as math;

class DescriptionItem extends StatefulWidget {
  String? description;
  DescriptionItem(this.description, {Key? key}) : super(key: key);

  @override
  _DescriptionItemState createState() => _DescriptionItemState();
}

class _DescriptionItemState extends State<DescriptionItem> {
  bool showAll = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            '${widget.description ?? ''}',
            style: AppController.fontStyle(fontTypes.heading4, itemColor2),
            overflow: TextOverflow.fade,
            textAlign: TextAlign.right,
          ),
        ),

        // Center(
        //      child: GestureDetector(
        //        onTap: (){
        //          setState(() {
        //            showAll=!showAll;
        //          });
        //        },
        //        child: Row(
        //          mainAxisAlignment: MainAxisAlignment.center,
        //          children: [
        //            Text('جزئیات بیشتر',style: AppController.fontStyle(fontType.heading4, itemColor1),),
        //            SizedBox(width: 10,),
        //            Transform.rotate(
        //              angle: showAll?math.pi/2:-math.pi / 2,
        //              child: Icon(Icons.arrow_forward_ios,size: 18,color: itemColor1,),
        //            )
        //          ],
        //        ),
        //      ),
        //    ),
      ],
    );
  }
}
