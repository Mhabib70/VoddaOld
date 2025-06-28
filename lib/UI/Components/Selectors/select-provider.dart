import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/Popups/alert-dialog.dart';
import 'package:vodda_old/UI/Views/Order/provider-index.dart';
// import 'package:mapir_raster/mapir_raster.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/api-urls.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
// import 'package:vodda_old/UI/Views/Question/question-index.dart';

class SelectProviderAddress extends StatefulWidget {
  SelectProviderAddress({Key? key}) : super(key: key);

  @override
  State<SelectProviderAddress> createState() => _SelectProviderAddressState();
}

class _SelectProviderAddressState extends State<SelectProviderAddress> {
  MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///TODO: Emrani removed this
        // MapirMap(
        //   apiKey: mapApiKey,
        //   options: MapOptions(center: UserController.myPosition, zoom: 11.0),
        //   mapController: controller,

        //   layers: [
        //     MarkerLayerOptions(
        //       markers: [
        //         for (Provider provider in OrderController.providers.values)
        //           if (provider.hasUserCity() &&
        //               provider.lat != null &&
        //               provider.long != null)
        //             Marker(
        //               width: 40.0,
        //               height: 40.0,
        //               point: LatLng(provider.lat!, provider.long!),
        //               builder:
        //                   (ctx) => Img(
        //                     mapIcon,
        //                     width: 40,
        //                     height: 40,
        //                     color: appColor,
        //                     onClick: () {
        //                       showAlertDialog(
        //                         context,
        //                         title: 'مشخصات متخصص',
        //                         child: Column(
        //                           children: [
        //                             Container(
        //                               margin: EdgeInsets.only(
        //                                 left: 10,
        //                                 right: 10,
        //                               ),
        //                               child: Text(
        //                                 '${provider.fname} ${provider.lname}',
        //                                 style: AppController.fontStyle(
        //                                   fontTypes.heading3,
        //                                   itemColor1,
        //                                 ),
        //                                 maxLines: 2,
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                             ),
        //                             Row(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.center,
        //                               children: [
        //                                 Icon(
        //                                   Icons.star,
        //                                   size: 20,
        //                                   color: appColor,
        //                                 ),
        //                                 SizedBox(width: 5),
        //                                 Text(
        //                                   'امتیاز : ${provider.rate}',
        //                                   style: AppController.fontStyle(
        //                                     fontTypes.heading5,
        //                                     itemColor4,
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                             SizedBox(height: 15),
        //                             if (provider.price != null)
        //                               Row(
        //                                 children: [
        //                                   Row(
        //                                     children: [
        //                                       Icon(
        //                                         Icons.monetization_on_outlined,
        //                                         size: 15,
        //                                         color: appColor,
        //                                       ),
        //                                       SizedBox(width: 5),
        //                                       Text(
        //                                         '${AppController.priceFormat(int.parse(provider.price!))} تومان',
        //                                         style: AppController.fontStyle(
        //                                           fontTypes.heading5,
        //                                           itemColor4,
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   SizedBox(width: 10),
        //                                   Row(
        //                                     children: [
        //                                       Icon(
        //                                         Icons.timer_sharp,
        //                                         size: 15,
        //                                         color: appColor,
        //                                       ),
        //                                       SizedBox(width: 5),
        //                                       Text(
        //                                         '${((provider.time)! / 60).toInt() > 0 ? '${((provider.time)! / 60).toInt()} ساعت ' : ''} ${((provider.time)! / 60).toInt() > 0 && (provider.time)! % 60 > 0 ? 'و' : ''} ${(provider.time)! % 60 > 0 ? '${(provider.time)! % 60} دقیقه' : ''}',
        //                                         style: AppController.fontStyle(
        //                                           fontTypes.heading5,
        //                                           itemColor4,
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                             SizedBox(height: 15),
        //                             Row(
        //                               children: [
        //                                 Btn(
        //                                   btnType.primary,
        //                                   text: 'جزییات',
        //                                   width: 80,
        //                                   height: 40,
        //                                   onClick: () async {
        //                                     // OrderController orderController=Get.put(OrderController());
        //                                     // if(orderController.order.id==null){
        //                                     //   orderController.order.providerId=provider.id;
        //                                     //   orderController.getQuestions();
        //                                     //   Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (builder)=>QuestionIndex()));
        //                                     // }
        //                                     // else{
        //                                     //   Navigator.pop(Get.context!);
        //                                     //   OrderController.acceptProvider(orderController.order.id!,provider.id!);
        //                                     // }
        //                                     Navigator.pop(Get.context!);
        //                                     Navigator.push(
        //                                       context,
        //                                       MaterialPageRoute(
        //                                         builder:
        //                                             (s) =>
        //                                                 ProviderIndex(provider),
        //                                       ),
        //                                     );
        //                                   },
        //                                 ),
        //                                 Btn(
        //                                   btnType.secondary,
        //                                   text: 'بستن',
        //                                   width: 80,
        //                                   height: 40,
        //                                   onClick: () {
        //                                     Navigator.pop(Get.context!);
        //                                   },
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                       );
        //                     },
        //                   ),
        //             ),
        //       ],
        //     ),
        //   ],
        // ),
        Positioned(
          bottom: 50,
          right: paddingSize,
          child: InkWell(
            onTap: () async {
              if (kIsWeb) {
                await Get.find<UserController>().getMyLocation();
                controller.move(UserController.myPosition, 15);
              } else {
                Map<Permission, PermissionStatus> statuses =
                    await [Permission.location].request();
                if (await Permission
                    .locationWhenInUse
                    .serviceStatus
                    .isEnabled) {
                  await Get.find<UserController>().getMyLocation();
                  controller.move(UserController.myPosition, 15);
                }
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: shadow,
              ),
              child: Center(
                child: Icon(Icons.my_location, size: 30, color: itemColor2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
