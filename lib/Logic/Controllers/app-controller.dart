import 'package:flutter/foundation.dart' as web;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Helpers/token-methods.dart';
import 'package:vodda_old/Logic/Models/category.dart';
import 'package:vodda_old/Logic/Models/city.dart';
import 'package:vodda_old/Logic/Models/link-menu.dart';
import 'package:vodda_old/Logic/Models/province.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/page-route.dart';
import 'package:vodda_old/UI/Views/Main/sub-list.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';
import 'package:vodda_old/UI/Views/User/login.dart';

enum fontTypes {
  heading1,
  heading2,
  heading3,
  heading4,
  heading5,
  text1,
  text2,
  light30,
  regular30,
  bold30,
  light26,
  regular26,
  bold26,
  light25,
  regular25,
  bold25,
  light24,
  regular24,
  bold24,
  light23,
  regular23,
  bold23,
  light22,
  regular22,
  bold22,
  light21,
  regular21,
  bold21,
  light20,
  regular20,
  bold20,
  light19,
  regular19,
  bold19,
  light18,
  regular18,
  bold18,
  light17,
  regular17,
  bold17,
  light16,
  regular16,
  bold16,
  light15,
  regular15,
  bold15,
  light14,
  regular14,
  bold14,
}

class AppController extends GetxController {
  static RxBool isLoading = false.obs;

  static RxList<String> loadingList = <String>[].obs;

  static startLoading(String loadingTag) {
    if (loadingTag != '' && loadingTag != null) loadingList.add(loadingTag);
    print('loadingList>>>${loadingList}');
  }

  static finishLoading(String loadingTag) {
    loadingList.remove(loadingTag);
    print('loadingList>>>${loadingList}');
  }

  static hasLoading(loadingTag) {
    if (loadingList.contains(loadingTag))
      return true;
    else
      return false;
  }

  static fontStyle(fontTypes fontType, Color itemColor) {
    switch (fontType) {
      case fontTypes.heading1:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w600,
          fontSize: 33,
        );
      case fontTypes.heading2:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w600,
          fontSize: 23,
        );
      case fontTypes.heading3:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w500,
          fontSize: 19,
        );
      case fontTypes.heading4:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        );
      case fontTypes.heading5:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        );
      case fontTypes.text1:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        );
      case fontTypes.text2:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        );
      case fontTypes.light30:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 30,
        );
      case fontTypes.regular30:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 30,
        );
      case fontTypes.bold30:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        );

      case fontTypes.light26:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 26,
        );
      case fontTypes.regular26:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 26,
        );
      case fontTypes.bold26:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        );

      case fontTypes.light25:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 25,
        );
      case fontTypes.regular25:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 25,
        );
      case fontTypes.bold25:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 25,
        );

      case fontTypes.light24:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 24,
        );
      case fontTypes.regular24:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        );
      case fontTypes.bold24:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        );

      case fontTypes.light23:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 23,
        );
      case fontTypes.regular23:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 23,
        );
      case fontTypes.bold23:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 23,
        );

      case fontTypes.light22:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 22,
        );
      case fontTypes.regular22:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 22,
        );
      case fontTypes.bold22:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        );

      case fontTypes.light21:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 21,
        );
      case fontTypes.regular21:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 21,
        );
      case fontTypes.bold21:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 21,
        );

      case fontTypes.light20:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 20,
        );
      case fontTypes.regular20:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        );
      case fontTypes.bold20:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        );

      case fontTypes.light19:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 19,
        );
      case fontTypes.regular19:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 19,
        );
      case fontTypes.bold19:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 19,
        );

      case fontTypes.light18:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        );
      case fontTypes.regular18:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        );
      case fontTypes.bold18:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        );

      case fontTypes.light17:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 17,
        );
      case fontTypes.regular17:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 17,
        );
      case fontTypes.bold17:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        );

      case fontTypes.light16:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        );
      case fontTypes.regular16:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
      case fontTypes.bold16:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );

      case fontTypes.light15:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 15,
        );
      case fontTypes.regular15:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        );
      case fontTypes.bold15:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        );

      case fontTypes.light14:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        );
      case fontTypes.regular14:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        );
      case fontTypes.bold14:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        );
      default:
        return TextStyle(
          color: itemColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        );
    }
  }

  static priceFormat(int value) {
    NumberFormat myFormat = NumberFormat.decimalPattern();
    return myFormat.format(value);
  }
}
