import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/discount-item.dart';
import 'package:vodda_old/UI/Components/Items/overview-item.dart';
import 'package:get/get.dart';
import 'package:vodda_old/UI/Components/Items/question-item.dart';
import 'package:vodda_old/UI/Views/User/edit-profile.dart';

class QuestionOverviw extends StatelessWidget {
  QuestionOverviw({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return MyScroll(
      child: Center(
        child: Container(
          width: maxItemWidth,
          padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                '${ServiceController.services[orderController.order.serviceId]!.title ?? ''}',
                style: AppController.fontStyle(fontTypes.heading3, itemColor1),
              ),
              SizedBox(height: 30),
              OverviewItem(
                moneyIcon,
                title: 'نوع پرداخت :',
                value:
                    '${ServiceController.services[orderController.order.serviceId]!.typePayTitle}',
              ),

              orderController.order.providerId != null
                  ? OverviewItem(
                    userIcon,
                    title: 'نام استاد :',
                    value:
                        '${OrderController.providers[orderController.order.providerId]!.fname ?? ''} ${OrderController.providers[orderController.order.providerId]!.lname ?? ''}',
                  )
                  : OverviewItem(
                    bellIcon,
                    title: 'نوع درخواست :',
                    value: 'فراخوان',
                  ),
              orderController.order.date == null
                  ? Container()
                  : Column(
                    children: [
                      Row(
                        children: [
                          Img(dateIcon, height: 18, width: 18, color: appColor),
                          SizedBox(width: 10),
                          Text(
                            'زمان انجام کار',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              appColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'روز :',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor2,
                            ),
                          ),
                          Text(
                            '${orderController.isImmediate.value ? 'آنی' : orderController.dates[orderController.order.date]!.key}',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'ساعت :',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor2,
                            ),
                          ),
                          Text(
                            '${orderController.isImmediate.value ? 'آنی' : orderController.order.time}',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
              orderController.order.addressId != null
                  ? Column(
                    children: [
                      Row(
                        children: [
                          Img(
                            locationIcon,
                            height: 18,
                            width: 18,
                            color: appColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'آدرس',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              appColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'شهر :',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor2,
                            ),
                          ),
                          Text(
                            '${MainController.provinces[UserController.addresses[orderController.addressId.value]!.provinceId]!.cities[UserController.addresses[orderController.addressId.value]!.cityId]!.name}',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'آدرس :',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor2,
                            ),
                          ),
                          Text(
                            '${UserController.addresses[orderController.addressId.value]!.fullAddress}',
                            style: AppController.fontStyle(
                              fontTypes.bold14,
                              itemColor1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                  : Container(),
              ServiceController
                              .services[orderController.order.serviceId]!
                              .typePay ==
                          0 ||
                      ServiceController
                              .services[orderController.order.serviceId]!
                              .typePay ==
                          1
                  ? DiscountItem()
                  : Container(),

              Text(
                'در صورتی که نکته خاصی در رابطه با این سفارش مدنظرتان است در کادر زیر وارد کنید :',
                style: AppController.fontStyle(fontTypes.heading5, itemColor3),
              ),

              SizedBox(height: 15),
              Input(
                lable: 'توضیحات تکمیلی',
                initValue: orderController.order.description,
                icon1: Container(
                  child: Icon(Icons.edit_outlined, size: 20, color: itemColor4),
                  width: 50,
                  height: 250,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 5),
                ),
                lines: 10,
                onChange: (text) {
                  orderController.order.description = text;
                },
              ),
              SizedBox(height: 15),
              for (int i = 0; i < orderController.questions.length; i++)
                if (orderController.order.answers[i].value != null &&
                    (orderController.order.answers[i].value.runtimeType == List
                        ? orderController.order.answers[i].value.length != 0
                        : true))
                  QuestionItem(
                    orderController.questions[i],
                    orderController.order.answers[i],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
