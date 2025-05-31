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
import 'package:vodda_old/UI/Components/Items/wallet-item.dart';
import 'package:vodda_old/UI/Components/Items/wallet-item2.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Inputs/cash-input.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';

class WalletList extends StatelessWidget {
  WalletList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Loading(
        getLoadedComponent: () {
          return Column(
            children: [
              BackHeader(title: "کیف پول"),
              Container(
                margin: EdgeInsets.only(right: 25, left: 25),
                width: maxItemWidth,
                height: 180,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 25,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'موجودی شما',
                      style: AppController.fontStyle(
                        fontTypes.heading4,
                        itemColor4,
                      ),
                    ),
                    SizedBox(),
                    Text(
                      '${AppController.priceFormat(UserController.user.value.walletTotal)} تومان',
                      style: AppController.fontStyle(
                        fontTypes.heading2,
                        itemColor2,
                      ),
                    ),
                    SizedBox(height: 30),
                    Btn(
                      btnType.primary,
                      width: 125,
                      height: 35,
                      text: 'شارژ حساب',
                      radius: 30,
                      onClick: () {
                        String amount = '';
                        showBottomModal(
                          context,
                          300,
                          Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CashInput(
                                      onChange: (value) {
                                        amount = value;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),

                              Btn(
                                btnType.primary,
                                text: "افزایش موجودی",
                                onClick: () {
                                  Navigator.pop(context);
                                  UserController.addToWallet(amount);
                                },
                              ),
                              SizedBox(height: paddingSize),
                            ],
                          ),
                          title: 'افزایش موجودی',
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: paddingSize),
                  Img(timerIcon, width: 30, height: 30, color: itemColor2),
                  SizedBox(width: 15),
                  Text(
                    'تاریخچه :',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(() {
                  return UserController.myWallets.value.length > 0
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
                              for (var wallet
                                  in UserController.myWallets.value.values)
                                WalletItem2(wallet),
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
                            'شما تا کنون از کیف پول استفاده نکرده اید ...',
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
