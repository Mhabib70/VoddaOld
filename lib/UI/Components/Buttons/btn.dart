import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:flutter/material.dart';

enum btnType { primary, secondary, mini }

class Btn extends StatelessWidget {
  Function? onClick;
  btnType type;
  bool isHalf;
  bool hasLoading;
  String? text;
  double? width;
  double? height;
  double radius;
  fontTypes fontType;
  Btn(
    this.type, {
    this.text,
    this.onClick,
    this.isHalf = false,
    this.width,
    this.height,
    this.fontType = fontTypes.heading4,
    this.radius = 8,
    this.hasLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width:
            this.isHalf
                ? ((size.width < maxItemWidth ? size.width : maxItemWidth) -
                        (2 * paddingSize)) /
                    2.05
                : this.width ?? maxItemWidth,
        height: height ?? 55,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color:
                this.type == btnType.secondary
                    ? itemColor5
                    : Colors.transparent,
            width: borderSize,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (this.onClick != null) this.onClick!();
          },
          child: Obx(() {
            return AppController.isLoading.value && hasLoading
                ? Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: whiteColor,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  this.text ?? '',
                  style: AppController.fontStyle(
                    fontType,
                    type == btnType.primary
                        ? whiteColor
                        : type == btnType.mini
                        ? appColor
                        : itemColor2,
                  ),
                );
          }),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              type == btnType.primary
                  ? appColor
                  : type == btnType.mini
                  ? appColor.withOpacity(0.15)
                  : whiteColor,
            ),
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
