import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class QuestionConfirm extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: maxItemWidth,
      padding: const EdgeInsets.only(left: paddingSize, right: paddingSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Img(successIcon, height: 150, width: 150, color: appColor),
                  SizedBox(height: 30),
                  Text(
                    'سفارش شما ثبت شد !',
                    style: AppController.fontStyle(
                      fontTypes.heading1,
                      itemColor1,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'کد پیگیری : ${orderController.order.code}',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return Container(
              width: maxItemWidth,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(boxShadow: shadow, color: Colors.white),
              child:
                  OrderController.statusPay.value == 0
                      ? Row(
                        children: [
                          Icon(Icons.info_outline, color: errorColor, size: 25),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'سفارش در انتظار پرداخت... در صورت عدم پرداخت با مراجعه به صفحه پروفایل در قسمت لیست سفارشات میتوانید مرحله پرداخت را تکمیل کنید .',
                              style: TextStyle(
                                color: errorColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Icon(Icons.info_outline, color: appColor, size: 25),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'با مراجعه به صفحه پروفایل میتوانید لیست سفارشات خودتان را مشاهده کنید .',
                              style: TextStyle(
                                color: itemColor1,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
            );
          }),
        ],
      ),
    );
  }
}
