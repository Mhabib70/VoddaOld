import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/column-scroll.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Items/comment-item.dart';
import 'package:vodda_old/UI/Components/Items/icon-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Views/Question/question-index.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderIndex extends StatelessWidget {
  Provider provider;
  bool hasSelectBtn;
  ProviderIndex(this.provider, {super.key, this.hasSelectBtn = true});

  @override
  Widget build(BuildContext context) {
    OrderController.getProviderCvFiles(provider);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: size.height,
          child: Column(
            children: [
              BackHeader(title: 'مشخصات استاد'),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: SizedBox(
                    // padding: EdgeInsets.only(left: paddingSize,right: paddingSize),
                    width: maxItemWidth,
                    child: Column(
                      children: [
                        // SizedBox(height: 70,),
                        Img(
                          provider.avatar ?? '',
                          width: 120,
                          height: 120,
                          radius: 5,
                          isNetwork: true,
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          child: Text(
                            '${provider.fname} ${provider.lname}',
                            style: AppController.fontStyle(
                              fontTypes.heading1,
                              itemColor2,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Img(locationIcon, width: 30, height: 30),
                              SizedBox(width: 10),
                              Text(
                                provider.city ?? "",
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor4,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey,
                                margin: EdgeInsets.only(left: 20, right: 20),
                              ),
                              Img(
                                sucssessDrawerIcon,
                                color:
                                    provider.typeTitle == 'ویژه'
                                        ? Colors.blue[400]
                                        : provider.typeTitle == 'حرفه ای'
                                        ? appColor
                                        : Colors.red,
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: 5),
                              Text(
                                provider.typeTitle ?? "",
                                style: AppController.fontStyle(
                                  fontTypes.heading5,
                                  itemColor4,
                                ),
                              ),
                              // Icon(Icons.check_circle_rounded,color: provider.typeTitle=='ویژه'?Colors.blue:provider.typeTitle=='حرفه ای'?Colors.green:Colors.yellow,),
                              // SizedBox(width: 20,)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: maxItemWidth,
                            height: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconItem(
                                  rateIcon,
                                  'امتیاز (از 5 ) :',
                                  '${provider.rate}',
                                ),
                                IconItem(
                                  payIcon,
                                  'تعداد سفارشات:',
                                  '${provider.orderCount}',
                                ),
                                IconItem(
                                  progressIcon,
                                  'در حال انجام :',
                                  '${provider.orderProgressCount}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // provider.cv==null?Container():
                        //     Column(
                        //       children: [
                        //         Text('رزومه :',style: AppController.fontStyle(fontTypes.heading4, itemColor2),),
                        //         SizedBox(height: 10,),
                        //         Text(provider.cv!,style: AppController.fontStyle(fontTypes.heading5, itemColor2),),
                        //         SizedBox(height: 30,),
                        //       ],
                        //     ),
                        Expanded(
                          child: DefaultTabController(
                            length: 4,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: maxItemWidth,
                                  alignment: Alignment.centerRight,
                                  child: TabBar(
                                    labelColor: itemColor1,
                                    unselectedLabelColor: itemColor3,
                                    indicatorWeight: 3,
                                    indicatorColor: appColor,
                                    // onTap: (index){
                                    //   OrderController.getMyOrders(tabIndex: index+1,refresh: false);
                                    // },
                                    tabs: [
                                      Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'خدمات',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'معرفی',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'آثار',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'نظرات',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      GetBuilder<ServiceController>(
                                        builder:
                                            (serviceController) => ColumnScroll(
                                              children: [
                                                SizedBox(height: 20),
                                                for (int serviceId
                                                    in provider.serviceIds)
                                                  ServiceItem(
                                                    serviceController
                                                        .services[serviceId]!,
                                                  ),
                                              ],
                                            ),
                                      ),
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                20.0,
                                              ),
                                              child: Text(
                                                provider.cv ?? '',
                                                textAlign: TextAlign.right,
                                                style: AppController.fontStyle(
                                                  fontTypes.text2,
                                                  itemColor2,
                                                ),
                                                maxLines: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Loading(
                                        getLoadedComponent: () {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 20),
                                                Container(
                                                  width: size.width,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                    bottom: 15,
                                                  ),
                                                  child: Wrap(
                                                    direction: Axis.horizontal,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .start,
                                                    spacing: 5,
                                                    runSpacing: 5,
                                                    children: [
                                                      for (var file in provider
                                                          .cvFiles
                                                          .values
                                                          .where(
                                                            (element) =>
                                                                element.confirmed ==
                                                                    1 &&
                                                                element.isVideo ==
                                                                    1,
                                                          ))
                                                        InkWell(
                                                          onTap: () async {
                                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlay()));
                                                            if (!await launchUrl(
                                                              Uri.parse(
                                                                baseUrl +
                                                                    file.file!,
                                                              ),
                                                              mode:
                                                                  LaunchMode
                                                                      .externalApplication,
                                                            ))
                                                              throw 'Could not launch ${file.file!}';
                                                          },
                                                          child: Container(
                                                            width: 120,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color:
                                                                      itemColor1,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                            child: Img(
                                                              playIcon,
                                                            ),
                                                          ),
                                                        ),

                                                      for (var file in provider
                                                          .cvFiles
                                                          .values
                                                          .where(
                                                            (element) =>
                                                                element.confirmed ==
                                                                    1 &&
                                                                element.isVideo !=
                                                                    1,
                                                          ))
                                                        Container(
                                                          width: 120,
                                                          height: 100,

                                                          child: Img(
                                                            file.file!,
                                                            width: 200,
                                                            height: 100,
                                                            radius: 5,
                                                            isNetwork: true,
                                                            onClick: () async {
                                                              if (!await launchUrl(
                                                                Uri.parse(
                                                                  baseUrl +
                                                                      file.file!,
                                                                ),
                                                                mode:
                                                                    LaunchMode
                                                                        .externalApplication,
                                                              ))
                                                                throw 'Could not launch ${file.file!}';
                                                            },
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      ColumnScroll(
                                        children: [
                                          SizedBox(height: 20),
                                          for (var comment in provider.comments)
                                            CommentItem(comment),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //   ResumeItem(provider),
                        //
                        //   provider.comments.length>0?Column(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Expanded(child: CommentItem(provider.comments[0])),
                        //         SizedBox(width: 20,),
                        //         InkWell(
                        //           onTap:(){
                        //             Navigator.push(context, MaterialPageRoute(builder: (builder)=>CommentsList(provider)));
                        //           },
                        //           child: Container(
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                     width:50,
                        //                     height: 50,
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.circular(100),
                        //                       border: Border.all(color: appColor,width: 3)
                        //                     ),
                        //                     child: Icon(Icons.arrow_forward,size: 30,color: appColor,)),
                        //                 SizedBox(height: 10,),
                        //                 Text('مشاهده همه',style: AppController.fontStyle(fontTypes.heading5, appColor),)
                        //               ],
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     SizedBox(height: 50,),
                        //   ],
                        // ):Container(),
                        // Text('سرویس های در دسترس :',style: AppController.fontStyle(fontTypes.heading5, itemColor4),),
                        // SizedBox(height: 20,),
                        // Column(
                        //   children: [
                        //     for(int serviceId in provider.serviceIds)
                        //       ServiceItem(ServiceController.services[serviceId]!),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              if (hasSelectBtn)
                Container(
                  margin: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                    bottom: paddingSize,
                  ),
                  child: Btn(
                    btnType.primary,
                    text: 'انتخاب',
                    onClick: () {
                      if (provider.orderDescription == null)
                        chooseProvider();
                      else
                        showBottomModal(
                          context,
                          450,
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        '${provider.orderDescription}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading4,
                                          itemColor2,
                                        ),
                                        maxLines: null,
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                width: maxItemWidth,
                                padding: EdgeInsets.only(bottom: paddingSize),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Btn(
                                      btnType.primary,
                                      text: 'پذیرفتن',
                                      onClick: () {
                                        chooseProvider();
                                      },
                                      isHalf: true,
                                    ),
                                    Btn(
                                      btnType.secondary,
                                      text: 'بستن',
                                      onClick: () {
                                        Navigator.pop(context);
                                      },
                                      isHalf: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          title: 'توضیحات استاد',
                        );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  chooseProvider() {
    OrderController o = Get.put(OrderController());
    if (o.order.id == null) {
      o.order.providerId = provider.id;
      o.getQuestions();
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (builder) => QuestionIndex()),
      );
    } else {
      OrderController.acceptProvider(o.order.id!, provider.id!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    }
  }
}
