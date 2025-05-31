import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/UI/Components/Inputs/code-input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Views/User/login.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: appColor,
              ),
              Positioned(
                top: 30,
                child: Img(
                  loginImage,
                  width: maxItemWidth > size.width ? size.width : maxItemWidth,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: size.height * 2 / 3,
                    width: maxItemWidth,
                    padding: EdgeInsets.only(
                      left: paddingSize,
                      right: paddingSize,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3000),
                        topLeft: Radius.circular(3000),
                      ),
                      color: whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'ورود به اپلیکیشن',
                          style: AppController.fontStyle(
                            fontTypes.bold26,
                            itemColor1,
                          ),
                        ),
                        SizedBox(height: 60),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'شماره موبایل : ${UserController.mobile}',
                              style: AppController.fontStyle(
                                fontTypes.bold15,
                                itemColor1,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => Login(),
                                  ),
                                );
                              },
                              child: Text(
                                'ویرایش',
                                style: AppController.fontStyle(
                                  fontTypes.bold15,
                                  appColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'کد 4 رقمی برای شما ارسال شد , آن را وارد کنید :',
                          style: AppController.fontStyle(
                            fontTypes.bold14,
                            itemColor3,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Input(
                        //     hint: '_  _  _     _  _  _',
                        //     isNumber: true,
                        //     onChange: (text) {
                        //       UserController.verifyCode = text;
                        //     },
                        //     align: TextAlign.center,
                        //     initValue: UserController.verifyCode),
                        CodeInput(
                          onChange: (value) {
                            UserController.verifyCode = value;
                          },
                          onComplete: (val) {
                            UserController.verify();
                          },
                        ),
                        Spacer(),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.all(paddingSize),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UserController.timer > 0
                                    ? Text(
                                      'ارسال مجدد کد تایید بعد از ${UserController.timer.value} ثانیه ',
                                      style: AppController.fontStyle(
                                        fontTypes.heading5,
                                        itemColor2,
                                      ),
                                    )
                                    : Container(),
                                InkWell(
                                  onTap: () {
                                    UserController.login();
                                  },
                                  child: Text(
                                    UserController.timer.value > 0
                                        ? ''
                                        : 'ارسال مجدد کد تایید',
                                    style: AppController.fontStyle(
                                      fontTypes.heading5,
                                      appColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Btn(
                        //   btnType.primary,
                        //   text: 'ورود به برنامه',
                        //   onClick: () {
                        //     if (UserController.verifyCode.isNotEmpty)
                        //       UserController.verify();
                        //   },
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Img(
                  backIcon,
                  color: whiteColor,
                  width: 22,
                  height: 20,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
