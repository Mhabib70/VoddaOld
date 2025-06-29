import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/service.dart';

import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

class SliderItem2 extends StatelessWidget {
  Service service = Service();
  SliderItem2(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ServiceController>().getRelatedServices(service.id!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => ServiceIndex(service)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, bottom: 35, top: 15),
        width: 150,
        height: 210,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent.withOpacity(0.5),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            service.images.length > 0
                ? Img(
                  service.images[0],
                  width: 120,
                  height: 120,
                  isNetwork: true,
                )
                : Container(width: 120, height: 120),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${service.title ?? ''}',
                    style: AppController.fontStyle(
                      fontTypes.bold14,
                      itemColor1,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(height: 20,
            //   child: Row(
            //     children: [
            //       Text('ثبت سفارش',
            //           style: AppController.fontStyle(fontTypes.text1, appColor)),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Icon(
            //         Icons.arrow_forward_ios,
            //         size: 10,
            //         color: appColor,
            //       ),
            //     ],
            //   ),
            // )

            // Row(
            //   children: [
            //     Icon(
            //       Icons.percent,
            //       size: 10,
            //       color: appColor,
            //     ),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     Text('تا 25 درصد تخفیف',
            //         style: AppController.fontStyle(fontType.text1, appColor)),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
