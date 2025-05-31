import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/paid-item.dart';
import 'package:vodda_old/UI/Components/Items/paid-item2.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Inputs/cash-input.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';

class Payments extends StatelessWidget {
  Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Loading(
        getLoadedComponent: () {
          return Column(
            children: [
              BackHeader(title: "تراکنش ها"),
              Expanded(
                child: Obx(() {
                  return UserController.myPayments.value.length > 0
                      ? MyScroll(
                        child: Container(
                          width: size.width,
                          margin: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              for (var payment
                                  in UserController.myPayments.value.values)
                                PaidItem2(payment),
                            ],
                          ),
                        ),
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Img(
                            walletIcon,
                            width: 110,
                            height: 110,
                            color: appColor,
                          ),
                          SizedBox(height: 45),
                          Text(
                            'لیست خالی میباشد !',
                            style: AppController.fontStyle(
                              fontTypes.heading2,
                              itemColor1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'شما تا کنون هیچ تراکنشی انجام نداده اید ...',
                            style: AppController.fontStyle(
                              fontTypes.heading4,
                              itemColor4,
                            ),
                          ),
                        ],
                      );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
