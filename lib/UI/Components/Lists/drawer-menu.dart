import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/link-menu.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Items/drawer-item.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Views/Question/frequently-questions.dart';
import 'package:vodda_old/UI/Views/User/text-page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:url_launcher/url_launcher_string.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: size.height,
        width: (size.width - 50) < 350 ? size.width - 50 : 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(paddingSize),
              child: Row(
                children: [
                  UserController.user.value.avatar != null
                      ? Img(
                        UserController.user.value.avatar!,
                        width: 65,
                        height: 65,
                        radius: 100,
                        isNetwork: true,
                      )
                      : Container(
                        width: 65,
                        height: 65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: appColor.withOpacity(0.2),
                        ),
                        child: Img(
                          userIcon,
                          width: 25,
                          height: 32,
                          color: appColor,
                        ),
                      ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${UserController.user.value.fname ?? ''} ${UserController.user.value.lname ?? ''}',
                        style: AppController.fontStyle(
                          fontTypes.heading3,
                          itemColor2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${UserController.user.value.mobile ?? ''}',
                        style: AppController.fontStyle(
                          fontTypes.text1,
                          itemColor4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MyDivider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // DrawerItem(editIcon,'ویرایش مشخصات'),
                    // DrawerItem(paymentIcon,'پرداخت ها'),
                    // DrawerItem(sucssessDrawerIcon,'ثبت نام به عنوان استاد'),
                    // DrawerItem(heartIcon,'لیست علاقه مندی ها'),
                    // DrawerItem(percentDrawerIcon,'تخفیف های فعال'),
                    // DrawerItem(callDrawerIcon,'ارتباط باما / پشتیبانی'),
                    // DrawerItem(instagramDrawerIcon,'صفحه اینستاگرام'),
                    // DrawerItem('ثبت نام استاد',Img(wrenchIcon,width:20 ,height: 20,color: appColor,),),
                    for (LinkMenu link in MainController.sidebarLinks)
                      DrawerItem(
                        link.title ?? '',
                        Img(
                          link.icon!,
                          width: 20,
                          height: 20,
                          color: appColor,
                          isNetwork: true,
                        ),
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => TextPage(link),
                            ),
                          );
                        },
                      ),
                    DrawerItem(
                      'تماس با پشتیبانی',
                      Img(
                        callDrawerIcon,
                        width: 20,
                        height: 20,
                        color: appColor,
                      ),
                      onClick: () {
                        launchUrlString(
                          "tel:${MainController.setting['help_number']}",
                        );
                      },
                    ),
                    DrawerItem(
                      'سوالات متداول',
                      Img(questionIcon, width: 20, height: 20, color: appColor),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => FrequentlyQuestions(),
                          ),
                        );
                      },
                    ),

                    UserController.user.value.id == null
                        ? Container()
                        : DrawerItem(
                          'خروج از حساب کاربری',
                          Img(
                            logoutDrawerIcon,
                            width: 20,
                            height: 20,
                            color: appColor,
                          ),
                          onClick: () {
                            UserController.logout();
                          },
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
