import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/payment.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class PaidItem extends StatelessWidget {
  Payment payment = Payment();
  PaidItem(this.payment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: maxItemWidth,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(width: 1, color: itemColor5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:
                  payment.status == 0
                      ? itemColor4.withOpacity(0.2)
                      : appColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Img(
              payment.status == 0 ? removalIcon : tickIcon,
              color: payment.status == 0 ? itemColor4 : appColor,
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${AppController.priceFormat(payment.amount!)} تومان',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          payment.status == 0
                              ? itemColor4.withOpacity(0.2)
                              : appColor.withOpacity(0.2),
                    ),
                    child: Text(
                      '${payment.statusTitle}',
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        payment.status == 0 ? itemColor4 : appColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Img(calenderIcon, width: 14, height: 14, color: itemColor4),
                  SizedBox(width: 5),
                  Text(
                    '${payment.date}',
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor4,
                    ),
                  ),
                  SizedBox(width: 10),
                  Img(timerIcon, width: 14, height: 14, color: itemColor4),
                  SizedBox(width: 5),
                  Text(
                    '${payment.time}',
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              payment.message == null
                  ? Container()
                  : Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${payment.message}',
                          style: AppController.fontStyle(
                            fontTypes.heading5,
                            itemColor4,
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
