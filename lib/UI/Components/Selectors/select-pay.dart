import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/UI/Components/Items/select-pay-item.dart';

class SelectPay extends StatefulWidget {
  int selectedIndex, price;
  Function onSelect;
  SelectPay(this.selectedIndex, this.price, this.onSelect, {Key? key})
    : super(key: key);

  @override
  _SelectPayState createState() => _SelectPayState();
}

class _SelectPayState extends State<SelectPay> {
  @override
  Widget build(BuildContext context) {
    // if(){
    //   widget.selectedIndex=0;
    //   widget.onSelect(0);
    // }
    return Column(
      children: [
        SelectPayItem(
          onlineIcon,
          'پرداخت آنلاین',
          'پرداخت با کلیه کارت های عضو شتاپ',
          onSelect: () {
            setState(() {
              widget.selectedIndex = 0;
            });
            widget.onSelect(widget.selectedIndex);
          },
          selected: widget.selectedIndex == 0,
        ),
        SizedBox(height: 15),
        SelectPayItem(
          walletIcon,
          'پرداخت با کیف پول',
          'اعتبار : ${AppController.priceFormat(UserController.user.value.walletTotal)} تومان',
          onSelect: () {
            setState(() {
              widget.selectedIndex = 1;
            });
            widget.onSelect(widget.selectedIndex);
          },
          selected: widget.selectedIndex == 1,
          disable: UserController.user.value.walletTotal == 0,
        ),
        SizedBox(height: 15),
        SelectPayItem(
          diamondIcon,
          'پرداخت با امتیاز',
          'اعتبار : ${AppController.priceFormat(UserController.user.value.scorePrice!)} تومان',
          onSelect: () {
            setState(() {
              widget.selectedIndex = 2;
            });
            widget.onSelect(widget.selectedIndex);
          },
          selected: widget.selectedIndex == 2,
          disable: UserController.user.value.scorePrice! < widget.price,
        ),
      ],
    );
  }
}
