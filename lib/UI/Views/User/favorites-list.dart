import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          children: [
            BackHeader(title: 'لیست علاقه مندی ها'),
            Expanded(
              child: Obx(() {
                return UserController.myFavorites.value.isEmpty
                    ? EmptyList(favoriteIcon)
                    : MyScroll(
                      child: GetBuilder<ServiceController>(
                        builder:
                            (serviceController) => Container(
                              padding: EdgeInsets.only(
                                left: paddingSize,
                                right: paddingSize,
                              ),
                              width: size.width,
                              child: Column(
                                children: [
                                  for (var serviceId
                                      in UserController.myFavorites.value)
                                    if (serviceController.services[serviceId]!
                                        .hasUserCity())
                                      ServiceItem(
                                        serviceController.services[serviceId]!,
                                      ),
                                ],
                              ),
                            ),
                      ),
                    );
              }),
            ),
            // true?Container(
            //   height: 95,
            //   padding: EdgeInsets.only(left: paddingSize,right: paddingSize),
            //   child: Btn(btnType.primary,text: 'بازگشت به صفحه اصلی',),
            // ):Container()
          ],
        ),
      ),
    );
  }
}
