import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class QuestionHeader extends StatelessWidget {
  double padding;

  QuestionHeader({this.padding = paddingSize});

  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 70,
        width: size.width,
        padding: EdgeInsets.only(left: this.padding, right: this.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Img(appLogo, height: 40),
                SizedBox(width: 20),
                Text(
                  orderController.getTitle(),
                  style: AppController.fontStyle(
                    fontTypes.heading2,
                    itemColor1,
                  ),
                ),
              ],
            ),
            orderController.step != 5
                ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: itemColor5,
                    valueColor: AlwaysStoppedAnimation(itemColor2),
                    strokeWidth: 3,
                    value:
                        (orderController.step + orderController.questionIndex) /
                        ((orderController.questions.length > 0
                                ? orderController.questions.length - 1
                                : 0) +
                            4),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
