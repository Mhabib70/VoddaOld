import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Selectors/select-date.dart';
import 'package:vodda_old/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_old/UI/Components/Selectors/select-box.dart';

class QuestionTime extends StatelessWidget {
  QuestionTime({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: maxItemWidth,
        padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تاریخ و زمان دریافت سرویس را انتخاب کنید :',
              style: AppController.fontStyle(fontTypes.heading4, itemColor2),
            ),
            // SizedBox(height: 20,),
            // RadioGroup(orderController.isImmediate.value, {
            //   'دریافت آنی':true,
            //   'انتخاب تاریخ و زمان':false
            // },onChange: (value){
            //   orderController.isImmediate.value=value;
            //   orderController.order.typeDate=value?0:1;
            // },),
            SizedBox(height: 15),
            orderController.order.providerId != null &&
                    ServiceController
                            .services[orderController.order.serviceId]!
                            .typeTime ==
                        3
                ? SelectDate()
                : Obx(() {
                  return orderController.isImmediate.value
                      ? Container()
                      : Column(
                        children: [
                          SelectBox(
                            options: {
                              for (var date in orderController.dates.keys)
                                orderController.dates[date]!.key:
                                    orderController.dates[date]!.value,
                            },
                            text: 'انتخاب روز',
                            onSelect: (val) {
                              orderController.times.value = [];
                              orderController.order.time = null;
                              orderController.order.date = val;
                              orderController.times.value =
                                  orderController.dates[val]!.time!;
                            },
                            icon: Img(dateIcon),
                            value: orderController.order.date,
                          ),
                          SizedBox(height: 15),
                          SelectBox(
                            options:
                                orderController.times.value.length > 0 &&
                                        orderController.order.date != null
                                    ? {
                                      for (var time
                                          in orderController.times.value)
                                        time: time,
                                    }
                                    : <dynamic, dynamic>{},
                            text: 'انتخاب ساعت',
                            onSelect: (val) {
                              orderController.order.time = val;
                            },
                            icon: Img(clockIcon),
                            value: orderController.order.time,
                          ),
                        ],
                      );
                }),
          ],
        ),
      ),
    );
  }
}
