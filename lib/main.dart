import 'dart:io';

import 'package:responsive_framework/responsive_framework.dart';
// import 'package:vodda_old/Logic/Controllers/app-controller.dart';
// import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/UI/Views/User/connection-error.dart';
// import 'package:vodda_old/laravel_echo/src/connector/connector.dart';
import 'package:universal_html/html.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Views/User/splash.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:vodda_old/default_bindings.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    final loader = document.getElementById('pre-loader');
    if (loader != null) {
      loader.remove();
    }
    // var response=await dio.get({'${baseUrl}/meta'});
    //   var head=document.querySelector('head');
    //   if(response!.statusCode==200){
    //     head!.children.add(response.data['data']);
    //   }
  }
  AwesomeNotifications().initialize(
    null, //'resource://drawable/res_app_icon',//
    [
      NotificationChannel(
        channelKey: 'alerts',
        channelName: 'Alerts',
        channelDescription: 'Notification tests as alerts',
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: GroupAlertBehavior.Children,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Private,
        defaultColor: appColor,
        ledColor: appColor,
      ),
    ],
    debug: false,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: appColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${appTitle}',
      color: appColor,

      theme: ThemeData(
        fontFamily: 'IRANYekan',
        primaryColor: appColor,
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      textDirection: TextDirection.rtl,
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: BouncingScrollWrapper.builder(context, child!),
            // defaultScale: true,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
      initialRoute: '/',
      initialBinding: DefaultBinding(),
      routes: {
        '/': (context) => Splash(),
        '/networkError': (context) => ConnectionError(),
      },
    );
  }
}
