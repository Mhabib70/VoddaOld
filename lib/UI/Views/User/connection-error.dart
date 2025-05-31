import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/User/splash.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Img(connectionerrorIcon, width: 180, height: 170, color: appColor),
          SizedBox(height: 50),
          Text(
            'خطا در برقراری ارتباط !',
            style: AppController.fontStyle(fontTypes.heading1, appColor),
          ),
          SizedBox(height: 5),
          Text(
            'اتصال به اینترنت برقرار نیست ...',
            style: AppController.fontStyle(fontTypes.heading3, itemColor2),
          ),
          SizedBox(height: 45),
          Btn(
            btnType.primary,
            height: 45,
            width: 150,
            text: 'تلاش مجدد',
            fontType: fontTypes.heading4,
            radius: 30,
            onClick: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          SizedBox(height: 20),
          Btn(
            btnType.secondary,
            height: 45,
            width: 150,
            text: 'بستن برنامه',
            fontType: fontTypes.heading4,
            radius: 30,
            onClick: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
