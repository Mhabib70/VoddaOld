import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

import '../../Views/Order/provider-resume.dart';

class ResumeItem extends StatelessWidget {
  Provider provider;
  ResumeItem(this.provider);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OrderController.getProviderCvFiles(provider);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProviderResume(provider)),
        );
      },
      child: Container(
        width: maxItemWidth,
        height: 75,
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: itemColor5, width: borderSize),
          color: whiteColor,
          boxShadow: shadow,
        ),
        child: Row(
          children: [
            Img(transactionIcon, width: 20, height: 20, color: appColor),
            SizedBox(width: 15),

            Text(
              'رزومه و نمونه کار',
              style: AppController.fontStyle(fontTypes.text2, itemColor1),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Spacer(),

            Icon(Icons.arrow_forward, size: 25, color: appColor),
            SizedBox(width: 25),
          ],
        ),
      ),
    );
  }
}
