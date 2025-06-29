import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Headers/question-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/file-picker.dart';
import 'package:vodda_old/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_old/UI/Views/Main/main-index.dart';
import 'package:vodda_old/UI/Views/Question/question-address.dart';
import 'package:vodda_old/UI/Views/Question/question-confirm.dart';
import 'package:vodda_old/UI/Views/Question/question-overview.dart';
import 'package:vodda_old/UI/Views/Question/question-time.dart';
import 'package:vodda_old/UI/Views/Question/question-types.dart';

class QuestionIndex extends StatelessWidget {
  QuestionIndex({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GetBuilder<OrderController>(
        builder: (c) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics(),
            ),
            child: Container(
              alignment: Alignment.center,
              width: size.width,
              height: size.height,
              child: Loading(
                getLoadedComponent:
                    () => Column(
                      children: [
                        QuestionHeader(),
                        orderController.step != 5
                            ? Container(
                              height: 60,
                              width: maxItemWidth,
                              margin: EdgeInsets.only(
                                left: paddingSize,
                                right: paddingSize,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: whiteColor,
                                boxShadow: shadow,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Img(moneyIcon, color: appColor),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'هزینه خدمات :',
                                            style: AppController.fontStyle(
                                              fontTypes.text1,
                                              itemColor4,
                                            ),
                                          ),
                                          Text(
                                            '${AppController.priceFormat(orderController.order.priceValue + orderController.addPrice)} تومان',
                                            style: AppController.fontStyle(
                                              fontTypes.heading4,
                                              itemColor1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Img(timeIcon, color: appColor),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'زمان مورد نیاز :',
                                            style: AppController.fontStyle(
                                              fontTypes.text1,
                                              itemColor4,
                                            ),
                                          ),
                                          Text(
                                            ' ${((orderController.order.timespan + orderController.addTime) / 60).toInt() > 0 ? '${((orderController.order.timespan + orderController.addTime) / 60).toInt()} ساعت ' : ''} ${((orderController.order.timespan + orderController.addTime) / 60).toInt() > 0 && (orderController.order.timespan + orderController.addTime) % 60 > 0 ? 'و' : ''} ${(orderController.order.timespan + orderController.addTime) % 60 > 0 ? '${(orderController.order.timespan + orderController.addTime) % 60} دقیقه' : ''}',
                                            style: AppController.fontStyle(
                                              fontTypes.heading4,
                                              itemColor1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            : Container(),
                        SizedBox(height: 30),
                        Expanded(
                          child:
                              orderController.step == 1
                                  ? QuestionTypes()
                                  : orderController.step == 2
                                  ? QuestionAddress()
                                  : orderController.step == 3
                                  ? QuestionTime()
                                  : orderController.step == 4
                                  ? QuestionOverviw()
                                  : QuestionConfirm(),
                        ),
                        Container(
                          height: 95,
                          width: maxItemWidth,
                          margin: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child:
                              orderController.step != 5
                                  ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Btn(
                                        btnType.primary,
                                        text:
                                            orderController.step == 4
                                                ? 'ثبت سفارش'
                                                : 'مرحله بعد',
                                        isHalf: true,
                                        onClick: () {
                                          orderController.changeStep();
                                        },
                                      ),
                                      Btn(
                                        btnType.secondary,
                                        text: 'مرحله قبل',
                                        isHalf: true,
                                        onClick: () {
                                          orderController.changeStep(
                                            isNext: false,
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                  : Btn(
                                    btnType.primary,
                                    text: 'بازگشت به صفحه اصلی',
                                    onClick: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (c) => MainIndex(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  ),
                        ),
                      ],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
