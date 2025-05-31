import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/comment.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/comment-item.dart';
import 'package:vodda_old/UI/Components/Items/icon-item.dart';
import 'package:vodda_old/UI/Components/Items/resume-item.dart';
import 'package:vodda_old/UI/Components/Items/service-item.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Views/Order/comments-list.dart';
import 'package:vodda_old/UI/Views/Question/question-index.dart';

class ProviderIndex extends StatelessWidget {
  Provider provider;
  bool hasSelectBtn;
  ProviderIndex(this.provider, {Key? key, this.hasSelectBtn = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: MyScroll(
                  child: Container(
                    width: size.width,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: paddingSize,
                        right: paddingSize,
                      ),
                      width: maxItemWidth,
                      child: Column(
                        children: [
                          SizedBox(height: 70),
                          Img(
                            provider.avatar ?? '',
                            width: 120,
                            height: 120,
                            radius: 5,
                            isNetwork: true,
                          ),
                          SizedBox(height: 25),
                          Text(
                            '${provider.fname} ${provider.lname}',
                            style: AppController.fontStyle(
                              fontTypes.heading1,
                              itemColor2,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${provider.typeTitle ?? ""}',
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              itemColor4,
                            ),
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: Container(
                              width: maxItemWidth,
                              height: 90,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                          SizedBox(height: 30),
                          // provider.cv==null?Container():
                          //     Column(
                          //       children: [
                          //         Text('رزومه :',style: AppController.fontStyle(fontTypes.heading4, itemColor2),),
                          //         SizedBox(height: 10,),
                          //         Text(provider.cv!,style: AppController.fontStyle(fontTypes.heading5, itemColor2),),
                          //         SizedBox(height: 30,),
                          //       ],
                          //     ),
                          ResumeItem(provider),

                          provider.comments.length > 0
                              ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommentItem(
                                          provider.comments[0],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (builder) =>
                                                      CommentsList(provider),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                  border: Border.all(
                                                    color: appColor,
                                                    width: 3,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  size: 30,
                                                  color: appColor,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'مشاهده همه',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading5,
                                                  appColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                ],
                              )
                              : Container(),
                          Text(
                            'سرویس های در دسترس :',
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              itemColor4,
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              for (int serviceId in provider.serviceIds)
                                ServiceItem(
                                  ServiceController.services[serviceId]!,
                                ),
                            ],
                          ),
                        ],
                      ),
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
