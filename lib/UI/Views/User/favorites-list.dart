import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/category-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Lists/empty-list.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

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
                return UserController.myFavorites.value.length == 0
                    ? EmptyList(favoriteIcon)
                    : MyScroll(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                        ),
                        width: size.width,
                        child: Column(
                          children: [
                            for (var serviceId
                                in UserController.myFavorites.value)
                              if (ServiceController.services[serviceId]!
                                  .hasUserCity())
                                ServiceItem(
                                  ServiceController.services[serviceId]!,
                                ),
                          ],
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
