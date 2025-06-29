import 'package:flutter/material.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
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
      child:
          true
              ? Container(
                height: 270,
                width: 200,
                margin: EdgeInsets.only(top: 10, bottom: 35, left: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    provoider.avatar != null
                        ? Stack(
                          children: [
                            Img(
                              provoider.avatar!,
                              width: 80,
                              height: 80,
                              isNetwork: true,
                              radius: 80,
                            ),
                            Positioned(
                              top: 0,
                              right: 60,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: whiteColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      provoider.online == 1
                                          ? successColor
                                          : itemColor4,
                                ),
                              ),
                            ),
                          ],
                        )
                        : Container(height: 80),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Img(locationIcon, width: 20),
                        SizedBox(width: 10),
                        Text(
                          '${provoider.city ?? ""}',
                          style: AppController.fontStyle(
                            fontTypes.heading5,
                            itemColor4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 30,
                          color: Colors.amber.withOpacity(0.15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${provoider.rate}',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 15,
                                ),
                              ),
                              Icon(
                                Icons.star_outlined,
                                size: 15,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 30,
                          color: Colors.lightBlueAccent.withOpacity(0.15),
                          child: Text(
                            '${provoider.orderCount} سفارش',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${provoider.fname ?? ''} ${provoider.lname ?? ''}',
                          style: AppController.fontStyle(
                            fontTypes.regular16,
                            itemColor1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${provoider.skill ?? ''}',
                            style: AppController.fontStyle(
                              fontTypes.light14,
                              itemColor3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : Container(
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
                    //*****************************************
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
                    //     Row(
                    //       children: [
                    //         Text('9.2',
                    //             style: AppController.fontStyle(fontTypes.text1, itemColor4)),
                    //         Icon(
                    //           Icons.star_outline,
                    //           size: 15,
                    //           color: appColor,
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
    );
  }
}
