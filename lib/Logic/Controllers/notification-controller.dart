import 'dart:async';
import 'dart:io';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/token-methods.dart';
import 'package:vodda_old/Logic/Models/notification.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Popups/snackbar.dart';
import 'package:vodda_old/laravel_echo/laravel_echo.dart';
import 'package:vodda_old/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:universal_html/html.dart' as html;

import 'package:awesome_notifications/awesome_notifications.dart';

// import 'dart:js' as js;

class NotificationController extends GetxController
    with WidgetsBindingObserver {
  static final backgroundService = FlutterBackgroundService();
  // static bool _isinitial=true;

  @pragma('vm:entry-point')
  static initSocket({bool isBackgroundSocket = false}) async {
    // if(isBackgroundSocket)
    //   showNotificationApp('initSocketBackground', errorColor);//check: remove

    print('init socket');
    // if(_isinitial){
    HttpOverrides.global = new MyHttpOverrides();

    IO.Socket socket = IO.io(
      'https://chatbama.ir:6001',
      IO.OptionBuilder().disableAutoConnect().setTransports([
        'websocket',
      ]).build(),
    );

    // Create echo instance
    Echo echo = new Echo(
      broadcaster: EchoBroadcasterType.SocketIO,
      client: socket,
    );

    String? userToken = await Token.getNotifToken();

    echo.channel('user-channel${userToken}').listen('.UserEvent', (e) async {
      SocketNotification notification = SocketNotification.fromJson(e['data']);
      print('socket>>>>${e['data']}>>>isbackground>>>${isBackgroundSocket}');
      if (!isBackgroundSocket) {
        switch (notification.type) {
          case 'update_user':
            UserController.getUser();
            break;
          case 'update_user_order':
            OrderController.getOrder(int.parse(notification.fId!));
            UserController.getUser();
            break;
          case 'update_order':
            OrderController.getOrder(int.parse(notification.fId!));
            break;
          case 'cancel_order':
            OrderController.getOrder(int.parse(notification.fId!));
            UserController.getUser();
            break;
          case 'update_provider_order':
            await OrderController.getOrder(int.parse(notification.fId!));
            OrderController.getOrderProviders(int.parse(notification.fId!));
            break;
          case 'add_transaction':
            await UserController.getPayList(false);
            await UserController.getWalletList(false);
            await UserController.getUser();
            break;
        }
        //check: back
        // if(notification.isAudioAlert=='1'){
        //   print("play audio");
        //   AssetsAudioPlayer.newPlayer().open(
        //       Audio("assets/mp3/notif.mpeg")
        //   );
        // }
      }

      print('listen alert');

      if (notification.isShowAlert == '1') {
        showNotificationWeb(notification.message);
        switch (notification.status) {
          case 'error':
            if (isBackgroundSocket)
              showNotificationApp(notification.message!, errorColor);
            else
              showSnackbar(snackTypes.error, notification.message);
            break;
          case 'success':
            if (isBackgroundSocket)
              showNotificationApp(notification.message!, successColor);
            else
              showSnackbar(snackTypes.success, notification.message);
            break;
          case 'info':
            if (isBackgroundSocket)
              showNotificationApp(notification.message!, infoColor);
            else
              showSnackbar(snackTypes.info, notification.message);
            break;
          case 'warning':
            if (isBackgroundSocket)
              showNotificationApp(notification.message!, warningColor);
            else
              showSnackbar(snackTypes.warning, notification.message);
            break;
        }
      }
    });

    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     echo.leaveChannel('user-channel${userToken}');

    //     socket.clearListeners();
    //   }
    // });
    // }

    // _isinitial=false;
  }

  static Future<void> initBackgroundService() async {
    // if(!await backgroundService.isRunning()){

    print('initBackgroundService');

    await backgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStartBackground,
        // auto start service
        autoStart: false,
        isForegroundMode: false,
        notificationChannelId: 'alerts',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStartBackground,

        // you have to enable background fetch capability on xcode project
        onBackground: (ServiceInstance service) {
          WidgetsFlutterBinding.ensureInitialized();
          print('FLUTTER BACKGROUND FETCH');

          return true;
        },
      ),
    );

    // backgroundService.startService();

    // }
  }

  @pragma('vm:entry-point')
  static void onStartBackground(ServiceInstance service) async {
    print('***onStartBackgroundService**');

    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    initSocket(isBackgroundSocket: true);

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        print('setAsForeground');
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        print('setAsBackground');
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    // Timer.periodic(const Duration(seconds: 10), (timer) async {//check: remove
    //
    //   // print('hello');
    //
    //
    //   // if (service is AndroidServiceInstance) {
    //   //   service.setForegroundNotificationInfo(
    //   //     title: "My App Service",
    //   //     content: "Updated at ${DateTime.now()}",
    //   //   );
    //   // }
    //   //
    //   // /// you can see this log in logcat
    //   // // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    //   //
    //   // // test using external plugin
    //   // // final deviceInfo = DeviceInfoPlugin();
    //   // String? device;
    //   // if (Platform.isAndroid) {
    //   //   // final androidInfo = await deviceInfo.androidInfo;
    //   //   device = 'androidInfo.model';
    //   // }
    //   //
    //   // if (Platform.isIOS) {
    //   //   // final iosInfo = await deviceInfo.iosInfo;
    //   //   device = 'iosInfo.model';
    //   // }
    //   //
    //   // service.invoke(
    //   //   'update',
    //   //   {
    //   //     "current_date": DateTime.now().toIso8601String(),
    //   //     "device": device,
    //   //   },
    //   // );
    // });
  }

  static Future<bool> displayNotificationPermission() async {
    bool userAuthorized = false;
    BuildContext context = Get.context!;
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'Get Notified!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/animated-bell.gif',
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Allow Awesome Notifications to send you beautiful notifications!',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Deny',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                userAuthorized = true;
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Allow',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @pragma('vm:entry-point')
  static showNotificationApp(String text, Color color) async {
    print('notifText>>$text');
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    print('notifAllowed>>>${isAllowed}');
    if (!isAllowed) isAllowed = await displayNotificationPermission();
    if (!isAllowed) return;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1, // -1 is replaced by a random number
        channelKey: 'alerts',
        title: text,
        // body:"aaaaaa",
        // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        // largeIcon:
        // 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        // 'asset://assets/logos/logo.png',
        notificationLayout: NotificationLayout.Default,
        payload: {'notificationId': '1234567890'},
      ),
      actionButtons: [
        // NotificationActionButton(key: 'REDIRECT', label: 'Redirect',),
        // NotificationActionButton(
        //     key: 'REPLY',
        //     label: 'Reply Message',
        //     requireInputText: true,
        //     actionType: ActionType.SilentAction
        // ),
        NotificationActionButton(
          key: 'بستن',
          label: 'بستن',
          actionType: ActionType.DismissAction,
          isDangerousOption: true,
        ),
      ],
    );
  }

  static showNotificationWeb(var text) {
    if (kIsWeb) {
      // js.context.callMethod('persistentNotification',[text]);
      var element = html.document.getElementById('notificationDiv');
      element!.innerHtml = text;
      element.click();
      element.innerHtml = '';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    if (kIsWeb || !Platform.isAndroid) {
      print('onInitNotif');
      initSocket(isBackgroundSocket: false);
    } else {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32 ||
          await Permission.notification.request().isGranted) {
        print('onInitNotif');
        initSocket(isBackgroundSocket: false);
        await initBackgroundService();
        backgroundService.invoke('stopService');
      }
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    print('onCloseNotif');
    if (!kIsWeb) backgroundService.startService();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // document.getElementById('elementId')!.onClick;
    switch (state) {
      case AppLifecycleState.resumed:
        print('appResume');
        if (!kIsWeb && Platform.isAndroid)
          backgroundService.invoke('stopService');
        break;
      case AppLifecycleState.inactive:
        print('appInactive');
        if (!kIsWeb && Platform.isAndroid) backgroundService.startService();
        break;
      case AppLifecycleState.paused:
        print('appPause');
        if (!kIsWeb && Platform.isAndroid) backgroundService.startService();
        break;
      case AppLifecycleState.detached:
        print('appDeatached');
        if (!kIsWeb && Platform.isAndroid) backgroundService.startService();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
