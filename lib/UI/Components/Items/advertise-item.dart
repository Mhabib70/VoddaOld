import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Models/advertise.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Main/advertise-page.dart';

class AdvertiseItem extends StatelessWidget {
  final Advertise? advertise;
  const AdvertiseItem(this.advertise, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (advertise != null && advertise?.image2 != null) {
          Get.to(() => AdvertisePage(advertise!.image2!));
        }
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.only(left: 10, right: 10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: appColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 3, color: appColor),
              ),
              child:
                  advertise != null && advertise!.image1 != null
                      ? Img(
                        advertise!.image1!,
                        width: 60,
                        height: 60,
                        isNetwork: true,
                        color: appColor,
                        radius: 100,
                      )
                      : Container(),
            ),
            SizedBox(width: 10),
            Text(
              advertise?.title ?? '',
              style: AppController.fontStyle(fontTypes.regular14, itemColor1),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
