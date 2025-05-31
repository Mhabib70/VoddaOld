import 'package:flutter/cupertino.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/select-cash-item.dart';

class CashInput extends StatefulWidget {
  Function? onChange;
  CashInput({Key? key, this.onChange}) : super(key: key);

  @override
  _CashInputState createState() => _CashInputState();
}

class _CashInputState extends State<CashInput> {
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       SelectCashItem('100,000', onClick: (){
        //         setState(() {
        //           value='100000';
        //         });
        //       },selected: value=='100000'),
        //       SizedBox(width: 10),
        //       SelectCashItem('300,000', onClick: (){
        //         setState(() {
        //           value='300000';
        //         });
        //       },selected: value=='300000'),
        //       SizedBox(width: 10),
        //       SelectCashItem('500,000', onClick: (){
        //         setState(() {
        //           value='500000';
        //         });
        //       },selected: value=='500000'),
        //     ],
        //   ),
        // ),
        SizedBox(height: 20),
        Input(
          lable: 'مبلغ',
          initValue: value.toString(),
          icon1: Container(
            width: 20,
            height: 20,
            child: Img(moneyIcon, width: 20, height: 20, color: itemColor4),
          ),
          isNumber: true,
          icon2: Container(
            width: 20,
            height: 20,
            child: Center(
              child: Text(
                'تومان',
                style: AppController.fontStyle(fontTypes.heading4, itemColor4),
              ),
            ),
          ),
          onChange: (text) {
            // setState(() {
            value = text;
            // });
            widget.onChange!(value);
          },
        ),
      ],
    );
  }
}
