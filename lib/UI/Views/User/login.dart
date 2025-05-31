import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/mobile-input.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

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
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'به ${appTitle} خوش آمدید !',
                          style: AppController.fontStyle(
                            fontTypes.bold26,
                            itemColor1,
                          ),
                        ),
                        SizedBox(height: 60),
                        Text(
                          'جهت ورود یا ثبت نام , شماره موبایلتان را وارد کنید :',
                          style: AppController.fontStyle(
                            fontTypes.heading4,
                            itemColor2,
                          ),
                        ),
                        SizedBox(height: 40),
                        MobileInput(
                          initValue: UserController.mobile,
                          onChange: (text) {
                            UserController.mobile = text;
                            print('a${text}b');
                          },
                        ),
                        Spacer(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ثبت نام  به معنای پذیرش  ',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  launchUrlString(
                                    MainController.setting['rule_link'],
                                  );
                                },
                                child: Text(
                                  'قوانین ',
                                  style: AppController.fontStyle(
                                    fontTypes.heading5,
                                    appColor,
                                  ),
                                ),
                              ),
                              Text(
                                'این اپلیکیشن است ..',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Btn(
                          btnType.primary,
                          text: 'ثبت نام / ورود',
                          onClick: () {
                            if (UserController.mobile.isNotEmpty)
                              UserController.login();
                          },
                        ),
                        SizedBox(height: paddingSize),
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
