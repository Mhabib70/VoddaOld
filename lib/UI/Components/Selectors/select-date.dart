import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Models/date.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Items/date-item.dart';
import 'package:vodda_old/UI/Components/Items/time-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key? key}) : super(key: key);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return orderController.dates.length > 0
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              color: Colors.cyanAccent.withOpacity(0.1),
              width: size.width,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: [
                        for (var date in orderController.dates.keys)
                          DateItem(
                            orderController.dates[date]!,
                            selected: orderController.order.date == date,
                            onClick: () {
                              setState(() {
                                orderController.order.time = null;
                                orderController.order.date = date;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (orderController.order.date != null)
                  for (var time
                      in orderController
                          .dates[orderController.order.date]!
                          .time!)
                    TimeItem(
                      time,
                      onClick: () {
                        setState(() {
                          orderController.order.time = time;
                        });
                      },
                      selected: orderController.order.time == time,
                    ),
              ],
            ),
          ],
        )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EmptyList(
              dateIcon,
              text: 'استاد انتخاب شده زمان خالی برای رزرو ندارد',
              height: 300,
              fontType: fontTypes.heading2,
            ),
            Btn(
              btnType.mini,
              text: 'بازگشت',
              isHalf: true,
              onClick: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
  }
}
