import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading extends StatelessWidget {
  double? width, height;
  Function? getLoadedComponent;

  Loading({this.getLoadedComponent, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return AppController.isLoading.value
          ? Container(
            width: width != null ? width : size.width,
            height: height != null ? height : size.height,
            child: Stack(
              children: [
                // this.getLoadedComponent!=null?getLoadedComponent!():Container(),
                Container(
                  color: backgroundColor.withOpacity(0.9),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: appColor,
                      strokeWidth: 4,
                    ),
                  ),
                ),
              ],
            ),
          )
          : this.getLoadedComponent != null
          ? getLoadedComponent!()
          : Container();
    });
  }
}
