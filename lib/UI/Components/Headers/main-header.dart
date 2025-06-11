import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Views/User/city-list.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../General/img.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  double padding;
  Function? openDrawer;
  MainHeader({this.padding = paddingSize, this.openDrawer});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: this.padding, right: this.padding),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Img(menuIcon,width:30,height: 20,onClick: (){
                  //   if(openDrawer!=null)
                  //     openDrawer!();
                  // },),
                  // Img(appLogo,width:80,color: appColor),
                  // SizedBox(width: 20,),
                  // Text('${appTitle}',style: AppController.fontStyle(fontTypes.heading2,itemColor1),),
                  InkWell(
                    onTap: () {
                      launchUrlString("https://goftino.com/c/Vpq2bC");
                    },
                    child: Row(
                      children: [
                        Img(smsIcon, width: 30, height: 30, color: appColor),
                        SizedBox(width: 10),
                        Text(
                          'چت با پشتیبان',
                          style: AppController.fontStyle(
                            fontTypes.heading5,
                            itemColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  size.width < maxItemWidth
                      ? Container()
                      : Container(
                        width: 800,
                        child: TabBar(
                          controller: MainController.tabController,
                          indicatorColor: appColor,
                          tabs: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'خانه',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  MainController.tabController!.index == 0
                                      ? appColor
                                      : itemColor3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'جستجو',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  MainController.tabController!.index == 2
                                      ? appColor
                                      : itemColor3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'دسته ها',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  MainController.tabController!.index == 1
                                      ? appColor
                                      : itemColor3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'درخواست ها',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  MainController.tabController!.index == 3
                                      ? appColor
                                      : itemColor3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'پروفایل',
                                style: AppController.fontStyle(
                                  fontTypes.heading3,
                                  MainController.tabController!.index == 4
                                      ? appColor
                                      : itemColor3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),

            // InkWell(
            //   onTap: (){
            //     launchUrlString(baseUrl);
            //   },
            //   child:
            //   Img(AppController.logo,height: 40,),
            // )
            InkWell(
              onTap: () {
                // launchUrlString("tel:${MainController.setting['help_number']}");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => CityList()),
                );
              },
              child: Obx(() {
                return Row(
                  children: [
                    Text(
                      '${UserController.userCities.value.length == 0
                          ? 'همه شهر ها'
                          : UserController.userCities.length == 1
                          ? UserController.userCities.values.first.city.name
                          : '${UserController.userCities.length} شهر'}',
                      style: AppController.fontStyle(fontTypes.text2, appColor),
                    ),
                    SizedBox(width: 10),
                    Img(locationIcon, width: 21, height: 24, color: appColor),
                    // Text('${MainController.setting['help_number']}',style: AppController.fontStyle(fontTypes.text2, appColor),),
                    // SizedBox(width: 10,),
                    // Img(backupIcon,color: appColor,)
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
