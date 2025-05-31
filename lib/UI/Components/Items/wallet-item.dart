import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/payment.dart';
import 'package:vodda_old/Logic/Models/wallet.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';

class WalletItem extends StatelessWidget {
  Wallet wallet = Wallet();
  WalletItem(this.wallet, {Key? key}) : super(key: key);

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
                  wallet.type == 0
                      ? itemColor4.withOpacity(0.2)
                      : appColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Img(
              wallet.type == 0 ? removalIcon : tickIcon,
              color: wallet.type == 0 ? itemColor4 : appColor,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${AppController.priceFormat(wallet.amount!)} تومان',
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
                            wallet.type == 0
                                ? itemColor4.withOpacity(0.2)
                                : appColor.withOpacity(0.2),
                      ),
                      child: Text(
                        '${wallet.typeTitle}',
                        style: AppController.fontStyle(
                          fontTypes.heading4,
                          wallet.type == 0 ? itemColor4 : appColor,
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
                      '${wallet.date}',
                      style: AppController.fontStyle(
                        fontTypes.heading5,
                        itemColor4,
                      ),
                    ),
                    SizedBox(width: 10),
                    Img(timerIcon, width: 14, height: 14, color: itemColor4),
                    SizedBox(width: 5),
                    Text(
                      '${wallet.time}',
                      style: AppController.fontStyle(
                        fontTypes.heading5,
                        itemColor4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                wallet.description == null
                    ? Container()
                    : Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${wallet.description}',
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
          ),
        ],
      ),
    );
  }
}
