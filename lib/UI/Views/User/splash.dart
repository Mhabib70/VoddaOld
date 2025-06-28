import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:get/get.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:video_player/video_player.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    Get.find<MainController>().getInitData();
    // @smae1993 Commented
    // _controller = VideoPlayerController.asset('assets/media/splash.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {
    //       if (!kIsWeb) _controller.play();
    //     });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(splashImage),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child:
                      // kIsWeb?
                      // !kIsWeb ||
                      Uri.base.queryParametersAll.length == 0
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(appLogo, width: 180, height: 180),
                              SizedBox(height: 50),
                              Text(
                                '${appTitle}',
                                style: AppController.fontStyle(
                                  fontTypes.bold19,
                                  itemColor1,
                                ),
                              ),
                              SizedBox(height: 20),

                              Text(
                                'اولین اپلیکیشن تخصصی قرآن کریم',
                                style: AppController.fontStyle(
                                  fontTypes.bold14,
                                  itemColor1,
                                ),
                              ),
                            ],
                          )
                          : Container(),
                  // :
                  // Center(
                  //   child: Container(
                  //       height: 350,
                  //       child: VideoPlayer(_controller)),
                  // ),
                ),

                Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: appColor2,
                    strokeWidth: 6,
                  ),
                ),
                // SizedBox(height: 80,),
                Container(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    'درحال بارگذاری ...',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // Container(
            //   width: size.width,
            //   height: size.height,
            //   child: VideoPlayer(_controller),
            // ),
          ],
        ),
      ),
    );
  }
}
