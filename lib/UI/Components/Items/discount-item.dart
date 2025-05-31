import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';

class DiscountItem extends StatefulWidget {
  DiscountItem({Key? key}) : super(key: key);

  @override
  State<DiscountItem> createState() => _DiscountItemState();
}

class _DiscountItemState extends State<DiscountItem> {
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 50,
      width: maxItemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: borderSize, color: itemColor5),
        boxShadow: shadow,
        color: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Img(
                orderController.order.gift!.giftPercent != null
                    ? successIcon
                    : discountIcon,
                width: 25,
                height: 25,
                color: appColor,
              ),
              SizedBox(width: 10),
              Text(
                orderController.order.gift!.giftPercent != null
                    ? 'کد تخفیف اعمال شد !'
                    : 'کد تخفیف دارید ؟',
                style: AppController.fontStyle(fontTypes.heading4, itemColor4),
              ),
            ],
          ),
          orderController.order.gift!.giftPercent != null
              ? Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: appColor.withOpacity(0.2),
                    ),
                    child: Text(
                      '${orderController.order.gift!.giftPercent}%',
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        appColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        orderController.order.gift!.giftPercent = null;
                      });
                    },
                    child: Icon(Icons.clear, size: 20, color: itemColor4),
                  ),
                ],
              )
              : InkWell(
                onTap: () {
                  orderController.order.gift!.giftTitle = null;
                  showBottomModal(
                    context,
                    270,
                    Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Input(
                                lable: 'کد تخفیف',
                                initValue:
                                    orderController.order.gift!.giftTitle,
                                icon1: Container(
                                  width: 30,
                                  child: Img(
                                    discountIcon,
                                    width: 20,
                                    height: 20,
                                    color: appColor,
                                  ),
                                ),
                                onChange: (text) {
                                  if (orderController.order.gift!.giftTitle ==
                                      '')
                                    orderController.order.gift!.giftTitle =
                                        null;
                                  else
                                    orderController.order.gift!.giftTitle =
                                        text;
                                },
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                        Btn(
                          btnType.primary,
                          text: 'بررسی / اعمال کد تخفیف',
                          onClick: () {
                            if (orderController.order.gift!.giftTitle != null) {
                              Navigator.pop(context);
                              orderController.checkGiftCode();
                            }
                          },
                        ),
                        SizedBox(height: paddingSize),
                      ],
                    ),
                    title: 'کد تخفیف را وارد کنید :',
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: appColor.withOpacity(0.2),
                  ),
                  child: Text(
                    'اینجا وارد کنید',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      appColor,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
