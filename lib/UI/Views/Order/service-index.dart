import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/token-methods.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Models/tag.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn-with-icon.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Headers/sercive-header.dart';
import 'package:vodda_old/UI/Components/Items/breadcrumb-item.dart';
import 'package:vodda_old/UI/Components/Items/description-item.dart';
import 'package:vodda_old/UI/Components/Items/icon-item.dart';
import 'package:vodda_old/UI/Components/Items/menu-item.dart';
import 'package:vodda_old/UI/Components/Items/slider-item1.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Sliders/detail-slider.dart';
import 'package:vodda_old/UI/Components/Sliders/slider-types-.dart';
import 'package:vodda_old/UI/Views/Order/providers-list.dart';
import 'package:vodda_old/UI/Views/Question/question-index.dart';
import 'package:vodda_old/UI/Views/User/edit-profile.dart';
import 'package:vodda_old/UI/Views/User/login.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceIndex extends StatelessWidget {
  Service serviceModel = Service();
  ServiceIndex(this.serviceModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: maxItemWidth,
          height: size.height,
          child: Loading(
            getLoadedComponent:
                () => Column(
                  children: [
                    Column(
                      children: [
                        ServiceHeader(
                          serviceModel.isFavorite!,
                          setFavorite: () {
                            if (serviceModel.isFavorite!)
                              UserController.deleteFavorites(serviceModel);
                            else
                              UserController.addFavorites(serviceModel);
                          },
                        ),
                        // DetailSlider(serviceModel.images),
                      ],
                    ),
                    // SizedBox(height: 20,),
                    Expanded(
                      child: MyScroll(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailSlider(serviceModel.images),
                              Text(
                                '${serviceModel.title ?? ''}',
                                style: AppController.fontStyle(
                                  fontTypes.heading2,
                                  itemColor1,
                                ),
                              ),
                              SizedBox(height: 10),
                              serviceModel.price == '0'
                                  ? Text(
                                    'بدون هزینه',
                                    style: AppController.fontStyle(
                                      fontTypes.heading4,
                                      itemColor2,
                                    ),
                                  )
                                  : Row(
                                    children: [
                                      Text(
                                        ' قیمت ',
                                        style: AppController.fontStyle(
                                          fontTypes.heading4,
                                          itemColor2,
                                        ),
                                      ),
                                      serviceModel.type == 1 &&
                                              serviceModel.negotiable == 1
                                          ? Text(
                                            'توافقی',
                                            style: AppController.fontStyle(
                                              fontTypes.heading3,
                                              itemColor1,
                                            ),
                                          )
                                          : Row(
                                            children: [
                                              Text(
                                                '${AppController.priceFormat(int.parse(serviceModel.price!))}',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading3,
                                                  itemColor1,
                                                ),
                                              ),
                                              // Text('تا ',style: AppController.fontStyle(fontType.heading4, itemColor2),),
                                              // Text('1,064,0000 ',style: AppController.fontStyle(fontType.heading3, itemColor1),),
                                              Text(
                                                ' تومان',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading4,
                                                  itemColor2,
                                                ),
                                              ),
                                            ],
                                          ),
                                    ],
                                  ),
                              SizedBox(height: 15),
                              Text(
                                serviceModel.shortDescription ?? '',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor3,
                                ),
                              ),
                              SizedBox(height: 30),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: maxItemWidth,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    boxShadow: shadow,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconItem(
                                        payIcon,
                                        'تعداد سفارشات:',
                                        '${serviceModel.orderCount}',
                                      ),
                                      IconItem(
                                        progressIcon,
                                        'در حال انجام :',
                                        '${serviceModel.orderProgressCount}',
                                      ),
                                      IconItem(
                                        callIcon,
                                        'تعداد اساتید :',
                                        '${serviceModel.providerCount}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(height: 20,),
                              // Text('دسته بندی',style: AppController.fontStyle(fontTypes.heading5, itemColor2),),
                              // SizedBox(height: 10,),
                              // ScrollConfiguration(
                              //     behavior: ScrollConfiguration.of(context).copyWith(
                              //       dragDevices: {
                              //         PointerDeviceKind.touch,
                              //         PointerDeviceKind.mouse,
                              //       },
                              //     ),
                              //     child: SingleChildScrollView(
                              //       scrollDirection: Axis.horizontal,
                              //       reverse: true,
                              //       child: Row(
                              //         children: [
                              //           for (int i = 0; i < serviceModel.breadcrumb.length; i++)
                              //             BreadcrumbItem(serviceModel.breadcrumb[i]),
                              //         ],
                              //       ),
                              //     )),
                              SizedBox(height: 20),
                              Text(
                                'توضیحات',
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor2,
                                ),
                              ),
                              SizedBox(height: 10),
                              DescriptionItem(serviceModel.description),
                              SizedBox(height: 20),
                              // serviceModel.relatedIds.length==0?Container():Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text('سرویس های مرتبط',style: AppController.fontStyle(fontTypes.heading5, itemColor2),),
                              //     SizedBox(height: 10,),
                              //     ScrollConfiguration(
                              //         behavior: ScrollConfiguration.of(context).copyWith(
                              //           dragDevices: {
                              //             PointerDeviceKind.touch,
                              //             PointerDeviceKind.mouse,
                              //           },
                              //         ),
                              //         child: SingleChildScrollView(
                              //           scrollDirection: Axis.horizontal,
                              //           child: Row(
                              //             children: [
                              //               Wrap(
                              //                 direction: Axis.vertical,
                              //                 children: [
                              //                   for (int i = 0; i < serviceModel.relatedIds.length; i++)
                              //                     if(ServiceController.services[serviceModel.relatedIds[i]]!.hasUserCity())
                              //                     SliderItem1(ServiceController.services[serviceModel.relatedIds[i]]!,width: 350,),
                              //                 ],
                              //               ),
                              //             ],
                              //           ),
                              //         )),
                              //   ],
                              // )
                              // ListMenuItem(successIcon, 'راهنمای سفارش و دریافت خدمات',onClick: (){
                              //   launchUrlString(AppController.setting['guide_link']);
                              // },),
                              // ListMenuItem(alertIcon, 'قوانین و مقررات',onClick: (){
                              //   launchUrlString(AppController.setting['rule_link']);
                              // },),
                              // ListMenuItem(questionIcon, 'پرسش و پاسخ',onClick: (){
                              //   launchUrlString(AppController.setting['repeated_question_link']);
                              // },),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(paddingSize),
                      child: Btn(
                        btnType.primary,
                        width: maxItemWidth,
                        text: 'ثبت سفارش',
                        onClick: () async {
                          if (UserController.user.value.id == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (builder) => Login()),
                            );
                          } else if (UserController.user.value.isCompleted !=
                              true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => EditProfile(),
                              ),
                            );
                          } else {
                            Get.delete<OrderController>();
                            OrderController o = Get.put(OrderController());
                            o.order.serviceId = serviceModel.id;
                            o.order.providerId = null;
                            // o.order.priceValue=int.parse(serviceModel.price!);
                            // o.order.timespan=serviceModel.time!;
                            if (serviceModel.type == 1) {
                              OrderController.getServiceProviders(
                                serviceModel.id!,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ProvidersList(),
                                ),
                              );
                            } else if (serviceModel.type == 2) {
                              showBottomModal(
                                context,
                                340,
                                Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Text(
                                      'در این مرحله باید انتخاب کنید که سفارش شما به صورت فراخوان ثبت شود یا خودتان به صورت دستی استاد را انتخاب کنید :',
                                      style: AppController.fontStyle(
                                        fontTypes.heading4,
                                        itemColor2,
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      width: maxItemWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BtnIcon(
                                            icon: Img(
                                              bellIcon,
                                              width: 45,
                                              height: 45,
                                              color: appColor,
                                            ),
                                            text: 'فراخوان',
                                            onclick: () {
                                              Navigator.pop(context);
                                              o.getQuestions();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (builder) =>
                                                          QuestionIndex(),
                                                ),
                                              );
                                            },
                                          ),
                                          BtnIcon(
                                            icon: Img(
                                              manualIcon,
                                              width: 45,
                                              height: 45,
                                              color: appColor,
                                            ),
                                            text: 'انتخابی',
                                            onclick: () {
                                              Navigator.pop(context);
                                              OrderController.getServiceProviders(
                                                serviceModel.id!,
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (builder) =>
                                                          ProvidersList(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              //type 0 and 3
                              o.getQuestions();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => QuestionIndex(),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
