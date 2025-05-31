import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

enum snackTypes { error, info, success, warning }

showSnackbar(snackTypes snackType, message) {
  print('<<<<<showSnackbar>>>>>');

  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    borderRadius: 50,
    maxWidth: Get.width < 400 ? Get.width - 30 : 370,
    titleText: Container(),
    messageText: Container(
      width: Get.width < 400 ? Get.width - 30 : 370,
      height: 35,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgIcon(iconPath: errorIcon,width: 16,height:18 ,),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    padding: EdgeInsets.only(right: 15, left: 15),
    margin: EdgeInsets.only(top: 70),
    backgroundColor:
        snackType == snackTypes.error
            ? errorColor
            : snackType == snackTypes.success
            ? successColor
            : snackType == snackTypes.info
            ? infoColor
            : warningColor,
  );
}
