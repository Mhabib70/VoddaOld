import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Views/Order/order-index.dart';

class OrderItem extends StatelessWidget {
  Order order = Order();
  OrderItem(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxItemWidth,
      padding: EdgeInsets.only(left: paddingSize, right: paddingSize),
      // height: 165,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              OrderController.setTime(order);
              OrderController.getOrder(order.id!, hasLoading: true);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => OrderIndex(order.id!)),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Img(
                        ServiceController.services[order.serviceId]!.images[0],
                        width: 80,
                        height: 80,
                        radius: 5,
                        isNetwork: true,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${ServiceController.services[order.serviceId]!.title}',
                              style: AppController.fontStyle(
                                fontTypes.heading3,
                                itemColor1,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${order.fullDate} ${order.typeDate == 0 ? '' : '- ساعت ${order.fullTime}'}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading5,
                                      itemColor2,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Img(
                                  order.stateIcon!,
                                  width: 14,
                                  height: 14,
                                  color:
                                      order.statusPay == 0
                                          ? errorColor
                                          : order.stateColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${order.stateTitle}',
                                  style: AppController.fontStyle(
                                    fontTypes.heading5,
                                    order.statusPay == 0
                                        ? errorColor
                                        : order.stateColor!,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Img(
                                  doneIcon,
                                  width: 12,
                                  height: 12,
                                  color: itemColor1,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${order.code}',
                                  style: AppController.fontStyle(
                                    fontTypes.heading5,
                                    itemColor1,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Img(
                                  infoIcon,
                                  width: 14,
                                  height: 14,
                                  color: itemColor4,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${order.typeTitle}',
                                  style: AppController.fontStyle(
                                    fontTypes.heading5,
                                    itemColor4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                order.state == 1 || order.state == 2
                    ? Btn(
                      btnType.mini,
                      radius: 30,
                      width: 55,
                      height: 30,
                      fontType: fontTypes.heading5,
                      text: 'لغو',
                      onClick: () {
                        OrderController.cancelOrder(order.id!);
                      },
                    )
                    : Container(),
              ],
            ),
          ),
          SizedBox(height: 10),
          MyDivider(),
        ],
      ),
    );
  }
}
