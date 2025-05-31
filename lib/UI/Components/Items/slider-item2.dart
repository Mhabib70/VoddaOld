import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
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
        ServiceController.getRelatedServices(service.id!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => ServiceIndex(service)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, bottom: 35, top: 35),
        child: Column(
          children: [
            service.images.length > 0
                ? Img(
                  service.images[0],
                  width: 120,
                  height: 120,
                  isNetwork: true,
                )
                : Container(width: 120, height: 120),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${service.title ?? ''}',
                style: AppController.fontStyle(fontTypes.bold14, itemColor1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
