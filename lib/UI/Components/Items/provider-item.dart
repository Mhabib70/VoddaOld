import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Views/Order/provider-index.dart';
import 'package:vodda_old/UI/Views/Question/question-index.dart';

class ProviderItem extends StatefulWidget {
  Provider providerModel = Provider();
  bool hasSelectBtn;
  ProviderItem(this.providerModel, {Key? key, this.hasSelectBtn = true})
    : super(key: key);

  @override
  State<ProviderItem> createState() => _ProviderItemState();
}

class _ProviderItemState extends State<ProviderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (builder) => ProviderIndex(
                  widget.providerModel,
                  hasSelectBtn: widget.hasSelectBtn,
                ),
          ),
        );
      },
      child: Container(
        width: maxItemWidth,
        color: whiteColor,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Img(
                              widget.providerModel.avatar ?? '',
                              width: 55,
                              height: 55,
                              isNetwork: true,
                              radius: 50,
                            ),
                            Positioned(
                              top: 75,
                              right: 0,
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
                                      widget.providerModel.online == 1
                                          ? successColor
                                          : itemColor4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${widget.providerModel.fname} ${widget.providerModel.lname}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading3,
                                      itemColor2,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(width: 5),
                                  Img(
                                    sucssessDrawerIcon,
                                    color:
                                        widget.providerModel.typeTitle == 'ویژه'
                                            ? Colors.blue[400]
                                            : widget.providerModel.typeTitle ==
                                                'حرفه ای'
                                            ? appColor
                                            : Colors.red,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${widget.providerModel.typeTitle}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading3,
                                      itemColor2,
                                    ),
                                    maxLines: 2,
                                  ),

                                  // Icon(Icons.check_circle_rounded,color: widget.providerModel.typeTitle=='ویژه'?Colors.blue:widget.providerModel.typeTitle=='حرفه ای'?Colors.green:Colors.yellow,),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outline,
                                    size: 20,
                                    color: appColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'امتیاز : ${widget.providerModel.rate}',
                                    style: AppController.fontStyle(
                                      fontTypes.heading5,
                                      itemColor4,
                                    ),
                                  ),
                                ],
                              ),
                              widget.providerModel.price == null
                                  ? Container()
                                  : Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_outlined,
                                        size: 15,
                                        color: appColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${AppController.priceFormat(int.parse(widget.providerModel.price!))} تومان',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                              widget.providerModel.time == null
                                  ? Container()
                                  : Row(
                                    children: [
                                      Icon(
                                        Icons.timer_sharp,
                                        size: 15,
                                        color: appColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${((widget.providerModel.time)! / 60).toInt() > 0 ? '${((widget.providerModel.time)! / 60).toInt()} ساعت ' : ''} ${((widget.providerModel.time)! / 60).toInt() > 0 && (widget.providerModel.time)! % 60 > 0 ? 'و' : ''} ${(widget.providerModel.time)! % 60 > 0 ? '${(widget.providerModel.time)! % 60} دقیقه' : ''}',
                                        style: AppController.fontStyle(
                                          fontTypes.heading5,
                                          itemColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Img(
                        widget.providerModel.isMark!
                            ? favoritedIcon
                            : favoriteIcon,
                        width: 15,
                        height: 20,
                        color: itemColor1,
                        onClick: () {
                          setState(() {
                            widget.providerModel.isMark =
                                !widget.providerModel.isMark!;
                          });
                          OrderController.setMarkProvider(
                            widget.providerModel.id!,
                          );
                        },
                      ),
                      widget.hasSelectBtn
                          ? Btn(
                            btnType.mini,
                            width: 75,
                            height: 30,
                            radius: 30,
                            fontType: fontTypes.heading5,
                            text: 'انتخاب',
                            onClick: () {
                              if (widget.providerModel.orderDescription == null)
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
                                                '${widget.providerModel.orderDescription}',
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
                                        padding: EdgeInsets.only(
                                          bottom: paddingSize,
                                        ),
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
                          )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            MyDivider(),
          ],
        ),
      ),
    );
  }

  chooseProvider() {
    OrderController o = Get.put(OrderController());
    if (o.order.id == null) {
      o.order.providerId = widget.providerModel.id;
      o.getQuestions();
      Navigator.pushReplacement(
        Get.context!,
        MaterialPageRoute(builder: (builder) => QuestionIndex()),
      );
    } else {
      Navigator.pop(Get.context!);
      OrderController.acceptProvider(o.order.id!, widget.providerModel.id!);
    }
  }
}
