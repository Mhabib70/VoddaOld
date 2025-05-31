import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/addition.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Logic/Models/rate.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/General/my-scroll.dart';
import 'package:vodda_old/UI/Components/General/myDivider.dart';
import 'package:vodda_old/UI/Components/Headers/back-header.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Items/addition-item.dart';
import 'package:vodda_old/UI/Components/Items/answer-item.dart';
import 'package:vodda_old/UI/Components/Items/map-item.dart';
import 'package:vodda_old/UI/Components/Items/overview-item.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/loading.dart';
import 'package:vodda_old/UI/Components/Selectors/checkbox.dart';
import 'package:vodda_old/UI/Components/Selectors/select-pay.dart';
import 'package:vodda_old/UI/Components/Selectors/star-rating.dart';
import 'package:vodda_old/UI/Views/Order/order-document-list.dart';
import 'package:vodda_old/UI/Views/Order/provider-index.dart';
import 'package:vodda_old/UI/Views/Order/providers-list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderIndex extends StatelessWidget {
  int orderId;
  OrderIndex(this.orderId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: Loading(
          getLoadedComponent:
              () => Obx(() {
                Order order = OrderController.myOrders.value[orderId]!;

                order.setColorIconState();
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          BackHeader(title: 'جزئیات سفارش'),
                          Expanded(
                            child: MyScroll(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: paddingSize,
                                  right: paddingSize,
                                ),
                                width: size.width,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${ServiceController.services[order.serviceId]!.title}',
                                                style: AppController.fontStyle(
                                                  fontTypes.heading3,
                                                  itemColor1,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Img(
                                                    order.stateIcon!,
                                                    width: 18,
                                                    height: 18,
                                                    color: order.stateColor,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'وضعیت : ${order.stateTitle}',
                                                    style:
                                                        AppController.fontStyle(
                                                          fontTypes.heading5,
                                                          order.stateColor!,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Img(
                                            ServiceController
                                                .services[order.serviceId]!
                                                .images[0],
                                            width: 80,
                                            height: 80,
                                            radius: 5,
                                            isNetwork: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    order.state == 0 || order.state == 3
                                        ? Container()
                                        : Container(
                                          width: maxItemWidth,
                                          decoration: BoxDecoration(
                                            boxShadow: shadow,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: whiteColor,
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Img(
                                                    infoIcon,
                                                    width: 45,
                                                    height: 45,
                                                    color: appColor2,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      order.statusPay == 0
                                                          ? 'این سفارش بدون پرداخت ثبت شده است . جهت تکمیل فرآیند درخواست به استادین اقدام به پرداخت نمایید .'
                                                          : 'درصورتی که علاوه بر این خدمات درخواست دیگری از استاد دارید , آن را اینجا ثبت کنید :',
                                                      style:
                                                          AppController.fontStyle(
                                                            fontTypes.heading4,
                                                            itemColor4,
                                                          ),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Btn(
                                                btnType.primary,
                                                width: 150,
                                                height: 35,
                                                radius: 30,
                                                text:
                                                    order.statusPay == 0
                                                        ? 'پرداخت'
                                                        : 'درخواست جدید',
                                                onClick: () {
                                                  if (order.statusPay == 0 &&
                                                      order.price != 0 &&
                                                      (ServiceController
                                                                  .services[order
                                                                      .serviceId]!
                                                                  .typePay ==
                                                              0 ||
                                                          ServiceController
                                                                  .services[order
                                                                      .serviceId]!
                                                                  .typePay ==
                                                              1)) {
                                                    showBottomModal(
                                                      Get.context!,
                                                      550,
                                                      Column(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  'روش پرداخت را انتخاب کنید :',
                                                                  style: AppController.fontStyle(
                                                                    fontTypes
                                                                        .heading3,
                                                                    itemColor3,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '${AppController.priceFormat(int.parse(order.price!))} تومان',
                                                                  style: AppController.fontStyle(
                                                                    fontTypes
                                                                        .heading1,
                                                                    appColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                SelectPay(
                                                                  order
                                                                      .typePay!,
                                                                  int.parse(
                                                                    order
                                                                        .price!,
                                                                  ),
                                                                  (value) {
                                                                    order.typePay =
                                                                        value;
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          Btn(
                                                            btnType.primary,
                                                            text: ' پرداخت',
                                                            onClick: () async {
                                                              Navigator.pop(
                                                                Get.context!,
                                                              );
                                                              OrderController.paymentOrder(
                                                                order,
                                                                0,
                                                              );
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: paddingSize,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    Addition newAddition =
                                                        Addition(
                                                          orderId: orderId,
                                                        );
                                                    showBottomModal(
                                                      context,
                                                      450,
                                                      Column(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Input(
                                                                  lable:
                                                                      'موضوع درخواست',
                                                                  initValue:
                                                                      newAddition
                                                                          .description,
                                                                  icon1: Container(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: Img(
                                                                      editIcon,
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      color:
                                                                          itemColor4,
                                                                    ),
                                                                  ),
                                                                  onChange: (
                                                                    text,
                                                                  ) {
                                                                    newAddition
                                                                            .description =
                                                                        text;
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Input(
                                                                  lable: 'مبلغ',
                                                                  initValue:
                                                                      newAddition
                                                                          .amount,
                                                                  icon1: Container(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: Img(
                                                                      moneyIcon,
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      color:
                                                                          itemColor4,
                                                                    ),
                                                                  ),
                                                                  isNumber:
                                                                      true,
                                                                  icon2: Container(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child: Center(
                                                                      child: Text(
                                                                        'تومان',
                                                                        style: AppController.fontStyle(
                                                                          fontTypes
                                                                              .heading5,
                                                                          itemColor4,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onChange: (
                                                                    text,
                                                                  ) {
                                                                    if (text !=
                                                                        '')
                                                                      newAddition
                                                                              .amount =
                                                                          int.parse(
                                                                            text,
                                                                          );
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                CheckBox(
                                                                  'در رابطه با این مبلغ , هماهنگی های لازم را با استاد انجام داده و به توافق رسیده ایم .',
                                                                  fontType:
                                                                      fontTypes
                                                                          .heading4,
                                                                  onClick: (
                                                                    val,
                                                                  ) {
                                                                    newAddition
                                                                            .accepted =
                                                                        val;
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Btn(
                                                            btnType.primary,
                                                            text:
                                                                'ثبت درخواست / ادامه',
                                                            onClick: () {
                                                              if (newAddition
                                                                  .accepted) {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                                OrderController.additionOrder(
                                                                  newAddition,
                                                                  order,
                                                                );
                                                              }
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: paddingSize,
                                                          ),
                                                        ],
                                                      ),
                                                      title:
                                                          'افزودن درخواست جدید',
                                                    );
                                                  }
                                                },
                                              ),
                                              order.additions.length == 0
                                                  ? Container()
                                                  : Column(
                                                    children: [
                                                      SizedBox(height: 20),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'درخواست های اضافه :',
                                                            style:
                                                                AppController.fontStyle(
                                                                  fontTypes
                                                                      .heading4,
                                                                  itemColor1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      for (var addition
                                                          in order.additions)
                                                        AdditionItem(addition),
                                                    ],
                                                  ),
                                            ],
                                          ),
                                        ),
                                    order.state == 1 && order.provider == null
                                        ? Column(
                                          children: [
                                            SizedBox(height: 20),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Img(
                                                        userIcon,
                                                        width: 18,
                                                        height: 22,
                                                        color: appColor,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'تعداد پیشنهادات استادین : ',
                                                        style:
                                                            AppController.fontStyle(
                                                              fontTypes
                                                                  .heading5,
                                                              itemColor3,
                                                            ),
                                                      ),
                                                      Text(
                                                        '${order.countProvider}',
                                                        style:
                                                            AppController.fontStyle(
                                                              fontTypes
                                                                  .heading4,
                                                              itemColor1,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Btn(
                                                    btnType.mini,
                                                    width: 120,
                                                    height: 25,
                                                    radius: 30,
                                                    fontType: fontTypes.text1,
                                                    text: 'انتخاب استاد',
                                                    onClick: () {
                                                      Get.delete<
                                                        OrderController
                                                      >();
                                                      OrderController o =
                                                          Get.put(
                                                            OrderController(),
                                                          );
                                                      o.order = order;
                                                      OrderController.getOrderProviders(
                                                        order.id!,
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
                                            SizedBox(height: 20),
                                            MyDivider(),
                                          ],
                                        )
                                        : Container(),
                                    SizedBox(height: 20),
                                    OverviewItem(
                                      bellIcon,
                                      title: 'نوع درخواست :',
                                      value: '${order.typeTitle ?? ''}',
                                    ),
                                    order.fullDate == null
                                        ? Container()
                                        : Column(
                                          children: [
                                            OverviewItem(
                                              dateIcon,
                                              title: 'تاریخ دریافت خدمات :',
                                              value: '${order.fullDate ?? ''}',
                                            ),
                                            OverviewItem(
                                              clockIcon,
                                              title: 'ساعت :',
                                              value: '${order.fullTime ?? ''}',
                                            ),
                                          ],
                                        ),

                                    order.fullAddress == null ||
                                            order.lat == null
                                        ? Container()
                                        : Column(
                                          children: [
                                            OverviewItem(
                                              locationIcon,
                                              title: 'آدرس :',
                                              value:
                                                  '${order.fullAddress ?? ''}',
                                              isRow: false,
                                            ),
                                            MapItem(
                                              order.lat!,
                                              order.long!,
                                              '${order.fullAddress ?? ''}',
                                            ),
                                          ],
                                        ),
                                    OverviewItem(
                                      moneyIcon,
                                      title: 'هزینه خدمات :',
                                      value:
                                          '${AppController.priceFormat(int.parse(order.price!))} تومان',
                                    ),
                                    order.gift == null
                                        ? Container()
                                        : OverviewItem(
                                          percentDrawerIcon,
                                          title: 'تخفیف :',
                                          value:
                                              '${AppController.priceFormat(order.gift!.giftPrice!)} تومان',
                                        ),
                                    order.durationTime == 0
                                        ? Container()
                                        : OverviewItem(
                                          clockIcon,
                                          title: 'زمان موردنیاز :',
                                          value:
                                              ' ${((order.durationTime)! / 60).toInt() > 0 ? '${((order.durationTime)! / 60).toInt()} ساعت ' : ''}${((order.durationTime)! / 60).toInt() > 0 && (order.durationTime)! % 60 > 0 ? 'و' : ''}${(order.durationTime)! % 60 > 0 ? '${(order.durationTime)! % 60}دقیقه' : ''}',
                                        ),
                                    OverviewItem(
                                      payIcon,
                                      title: 'روش پرداخت :',
                                      value: '${order.typePayTitle ?? ''}',
                                    ),
                                    order.description == null ||
                                            order.description == ''
                                        ? Container()
                                        : OverviewItem(
                                          transactionIcon,
                                          title: 'توضیحات سفارش:',
                                          value: '${order.description ?? ''}',
                                          isRow: false,
                                        ),
                                    order.providerDescription == null ||
                                            order.providerDescription == ''
                                        ? Container()
                                        : OverviewItem(
                                          transactionIcon,
                                          title: 'توضیحات استاد:',
                                          value:
                                              '${order.providerDescription ?? ''}',
                                          isRow: false,
                                        ),
                                    SizedBox(height: 20),
                                    order.provider != null
                                        ? Column(
                                          children: [
                                            MyDivider(),
                                            SizedBox(height: 20),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'نام استاد : ',
                                                            style:
                                                                AppController.fontStyle(
                                                                  fontTypes
                                                                      .heading5,
                                                                  itemColor3,
                                                                ),
                                                          ),
                                                          Text(
                                                            '${order.provider!.fname} ${order.provider!.lname}',
                                                            style:
                                                                AppController.fontStyle(
                                                                  fontTypes
                                                                      .heading4,
                                                                  itemColor1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Btn(
                                                        btnType.mini,
                                                        width: 150,
                                                        height: 30,
                                                        radius: 30,
                                                        fontType:
                                                            fontTypes.heading5,
                                                        text: 'مشاهده مشخصات',
                                                        onClick: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    builder,
                                                                  ) => ProviderIndex(
                                                                    order
                                                                        .provider!,
                                                                    hasSelectBtn:
                                                                        false,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(height: 10),
                                                      order.typeCall == null ||
                                                              order.typeCall ==
                                                                  0
                                                          ? Container()
                                                          : InkWell(
                                                            onTap: () {
                                                              if (order
                                                                      .typeCall ==
                                                                  1)
                                                                launchUrlString(
                                                                  'tel:${order.provider!.mobile}',
                                                                );
                                                              else
                                                                OrderController.callPrivate(
                                                                  orderId,
                                                                );
                                                            },
                                                            child: Container(
                                                              width: 150,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                color: appColor
                                                                    .withOpacity(
                                                                      0.15,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      30,
                                                                    ),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    '${order.typeCall == 1 ? order.provider!.mobile : 'تماس'}',
                                                                    style: AppController.fontStyle(
                                                                      fontTypes
                                                                          .heading5,
                                                                      appColor,
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    Icons.call,
                                                                    color:
                                                                        appColor,
                                                                    size: 15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ],
                                                  ),
                                                  Img(
                                                    order.provider!.avatar!,
                                                    isNetwork: true,
                                                    width: 80,
                                                    height: 80,
                                                    radius: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        : Container(),
                                    SizedBox(height: 10),
                                    if (order.state != 0 && order.state != 3)
                                      Container(
                                        width: maxItemWidth,
                                        decoration: BoxDecoration(
                                          boxShadow: shadow,
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          color: whiteColor,
                                        ),
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Img(
                                                  infoIcon,
                                                  width: 45,
                                                  height: 45,
                                                  color: appColor,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    'جهت ارسال عکس و توضیحات تکمیلی از این قسمت استفاده کنید',
                                                    style:
                                                        AppController.fontStyle(
                                                          fontTypes.text2,
                                                          itemColor2,
                                                        ),
                                                    maxLines: null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Btn(
                                              btnType.primary,
                                              width: 170,
                                              height: 35,
                                              text: 'اطلاعات تکمیلی',
                                              onClick: () {
                                                OrderController.getOrderDocuments(
                                                  order.id!,
                                                );
                                                Get.to(
                                                  () =>
                                                      OrderDocumentList(order),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 10),
                                    if (order.questions != null)
                                      for (var question
                                          in order.questions!.values)
                                        answerItem(question),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    order.state == 2 || order.state == 3
                        ? Container(
                          width: maxItemWidth,
                          margin: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                            bottom: paddingSize,
                          ),
                          child: Row(
                            children: [
                              ServiceController
                                              .services[order.serviceId]!
                                              .typePlace !=
                                          2 ||
                                      OrderController
                                              .timerDuration
                                              .value
                                              .inSeconds ==
                                          0
                                  ? Expanded(
                                    child: Btn(
                                      btnType.primary,
                                      text:
                                          order.state == 2
                                              ? 'تایید انجام کار'
                                              : order.isRate == false
                                              ? 'امتیاز دهی'
                                              : 'دانلود فاکتور',
                                      onClick: () {
                                        if (order.state == 2) {
                                          OrderController.confirmOrder(
                                            order.id!,
                                          );
                                        } else if (order.isRate == false) {
                                          Rate rate = Rate(orderId: order.id);

                                          showBottomModal(
                                            context,
                                            400,
                                            Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  'ثبت امتیاز :',
                                                  style:
                                                      AppController.fontStyle(
                                                        fontTypes.heading3,
                                                        itemColor2,
                                                      ),
                                                ),
                                                SizedBox(height: 20),
                                                StarRating(
                                                  size: 40,
                                                  onRatingChanged: (value) {
                                                    rate.value = value.toInt();
                                                  },
                                                ),
                                                SizedBox(height: 30),
                                                Input(
                                                  lable:
                                                      'نظرتان را اینجا بنویسید ...',
                                                  initValue: rate.description,
                                                  icon1: Container(
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      size: 20,
                                                      color: itemColor4,
                                                    ),
                                                    width: 50,
                                                    height: 125,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    padding: EdgeInsets.only(
                                                      top: 5,
                                                    ),
                                                  ),
                                                  lines: 5,
                                                  onChange: (text) {
                                                    rate.description = text;
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                Btn(
                                                  btnType.primary,
                                                  text: 'ثبت امتیاز',
                                                  onClick: () {
                                                    Navigator.pop(context);
                                                    OrderController.setRate(
                                                      rate,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          OrderController.getExportOrder(
                                            orderId,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                  : Container(),
                              order.state == 2 &&
                                      ServiceController
                                              .services[order.serviceId]!
                                              .typePlace ==
                                          2
                                  ? Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Btn(
                                            btnType.primary,
                                            text:
                                                OrderController
                                                            .timerDuration
                                                            .value
                                                            .inSeconds !=
                                                        0
                                                    ? OrderController.getTime()
                                                    : 'تماس',
                                            onClick: () {
                                              if (OrderController
                                                      .timerDuration
                                                      .value
                                                      .inSeconds ==
                                                  0)
                                                if (ServiceController
                                                        .services[order
                                                            .serviceId!]!
                                                        .type_online ==
                                                    0)
                                                  OrderController.meetProvider(
                                                    orderId,
                                                  );
                                                else
                                                  OrderController.callProvider(
                                                    orderId,
                                                  );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Container(),
                            ],
                          ),
                        )
                        : Container(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
