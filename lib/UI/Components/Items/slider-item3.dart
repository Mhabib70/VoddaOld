import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Views/Order/provider-index.dart';
import 'package:vodda_old/UI/Views/Order/service-index.dart';

class SliderItem3 extends StatelessWidget {
  Provider provoider = Provider();
  SliderItem3(this.provoider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => ProviderIndex(provoider, hasSelectBtn: false),
          ),
        );
      },
      child: Container(
        height: 180,
        width: 120,
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(75),
            topRight: Radius.circular(75),
          ),
          color: slider3Color.withOpacity(0.5),
          // boxShadow: shadow3,
          border: Border.all(color: itemColor5, width: 1.5),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            provoider.avatar != null
                ? Img(
                  provoider.avatar!,
                  width: 80,
                  height: 80,
                  isNetwork: true,
                  radius: 80,
                )
                : Container(height: 80),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${provoider.fname ?? ''} ${provoider.lname ?? ''}',
                        style: AppController.fontStyle(
                          fontTypes.regular14,
                          itemColor1,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            // Row(
            //   mainAxisAlignment:
            //   MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Text('ثبت سفارش',
            //             style: AppController.fontStyle(fontTypes.text1, appColor)),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios,
            //           size: 10,
            //           color: appColor,
            //         ),
            //       ],
            //     ),
            //     // Row(
            //     //   children: [
            //     //     Text('9.2',
            //     //         style: AppController.fontStyle(fontType.text1, itemColor4)),
            //     //     Icon(
            //     //       Icons.star_outline,
            //     //       size: 15,
            //     //       color: appColor,
            //     //     ),
            //     //   ],
            //     // )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
