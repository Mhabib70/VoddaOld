import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

class ServiceItem extends StatelessWidget {
  Service serviceModel = Service();
  ServiceItem(this.serviceModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ServiceController.getRelatedServices(serviceModel.id!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => ServiceIndex(serviceModel)),
        );
      },
      child: Container(
        width: maxItemWidth,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: itemColor5, width: borderSize),
          color: whiteColor,
          boxShadow: shadow2,
        ),
        child: Row(
          children: [
            Img(
              serviceModel.images[0],
              width: 80,
              height: 80,
              isNetwork: true,
              radius: 40,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${serviceModel.title ?? ''}',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor1,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  // Container(
                  //   child: Text(
                  //       '${serviceModel.description??''}',
                  //       style: AppController.fontStyle(fontTypes.text2, itemColor4),
                  //       overflow: TextOverflow
                  //           .ellipsis,maxLines: 2,),
                  // ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Img(callIcon, color: appColor, width: 15, height: 15),
                      SizedBox(width: 10),
                      Text(
                        '${serviceModel.providerCount ?? ''}',
                        style: AppController.fontStyle(
                          fontTypes.text2,
                          itemColor4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
