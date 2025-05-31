import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Helpers/api-methods.dart';
import 'package:vodda_old/Logic/Models/addition.dart';
import 'package:vodda_old/Logic/Models/answer.dart';
import 'package:vodda_old/Logic/Models/cv-file.dart';
import 'package:vodda_old/Logic/Models/date.dart';
import 'package:vodda_old/Logic/Models/order-document-file.dart';
import 'package:vodda_old/Logic/Models/order-document.dart';
import 'package:vodda_old/Logic/Models/order.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/question.dart';
import 'package:vodda_old/Logic/Models/rate.dart';
import 'package:vodda_old/Public/api-urls.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';
import 'package:vodda_old/UI/Components/Buttons/btn.dart';
import 'package:vodda_old/UI/Components/General/img.dart';
import 'package:vodda_old/UI/Components/Inputs/input.dart';
import 'package:vodda_old/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_old/UI/Components/Popups/snackbar.dart';
import 'package:vodda_old/UI/Components/Selectors/radio-group.dart';
import 'package:vodda_old/UI/Components/Selectors/select-pay.dart';
import 'package:vodda_old/UI/Components/Selectors/star-rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderController extends GetxController {
  int step = 1;
  int questionIndex = 0;

  Order order = Order();

  List<Question> questions = [];

  int addPrice = 0;
  int addTime = 0;

  RxInt addressId = 0.obs;

  RxBool isImmediate = false.obs;
  static RxInt statusPay = 0.obs;
  RxList<String> times = <String>[].obs;
  Map<String, Date> dates = <String, Date>{};

  static Map<int, Provider> providers = <int, Provider>{};
  static String providerText = '';
  static RxList<Provider> seachedProviders = <Provider>[].obs;

  static RxMap<int, Order> myOrders = <int, Order>{}.obs;
  static Map<int, int> tabPageinations = {1: 1, 2: 1, 3: 1, 4: 1};

  static Rx<Duration> timerDuration =
      Duration(hours: 00, minutes: 00, seconds: 00).obs;
  static var timer = Timer(Duration(days: 999), () {});

  getQuestions() async {
    // getTimes();
    AppController.isLoading.value = true;
    // await getDates();
    var response = await RestApi.post(
      questionUrl,
      body: {'service_id': order.serviceId, 'provider_id': order.providerId},
    );
    await RestApi.responseHandler(
      response: response,
      successCallback: () async {
        questions = [];
        order.answers = [];
        order.priceValue = int.parse(response!.data['data']['price']);
        order.timespan = response.data['data']['time'];
        //sometimes laravel sends morph relations in map instead of list
        if (response.data['data']['questions'].runtimeType == Map) {
          Map.from(response.data['data']['questions']).forEach((key, value) {
            Question question = Question.fromJson(value);
            questions.add(question);
            Answer answer = Answer(
              questionId: question.id,
              type: question.type!,
            );

            if (question.type == 3 || question.type == 2) {
              answer.value = [];
            }
            order.answers.add(answer);
          });
        } else {
          for (var json in response.data['data']['questions']) {
            Question question = Question.fromJson(json);
            questions.add(question);
            Answer answer = Answer(
              questionId: question.id,
              type: question.type!,
            );

            if (question.type == 3 || question.type == 2) {
              answer.value = [];
            }
            order.answers.add(answer);
          }
        }
        for (int i = 0; i < questions.length; i++) {
          if (questions[i].targetQuestionId != 0 &&
              questions[i].targetQuestionId != -1 &&
              questions[i].targetQuestionId != null) {
            order.answers[i].nextQuestionIndex = questions.indexWhere(
              (element) => questions[i].targetQuestionId == element.id,
            );
          }
        }

        if (questions.length == 0) {
          if (ServiceController.services[order.serviceId]!.typePlace != 1) {
            if (ServiceController.services[order.serviceId]!.typeTime == 0) {
              step = 4;
            } else {
              await getDates();
              step = 3;
            }
          } else
            step = 2;
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  bool validation(isNext) {
    if (questionIndex == questions.length && questionIndex != 0) return true;
    if (isNext &&
        questions.length > 0 &&
        questions[questionIndex].required == 1 &&
        (order.answers[questionIndex].value == null ||
            ((questions[questionIndex].type == 2 ||
                    questions[questionIndex].type == 3) &&
                order.answers[questionIndex].value.length == 0))) {
      showSnackbar(snackTypes.error, 'لطفا اطلاعات مورد نیاز را وارد کنید');
      return false;
    } else if (isNext &&
        questions.length > 0 &&
        questions[questionIndex].type == 2 &&
        questions[questionIndex].max != 0 &&
        order.answers[questionIndex].value.length >
            questions[questionIndex].max) {
      showSnackbar(
        snackTypes.error,
        'حداکثر ${questions[questionIndex].max} فایل میتوانید انتخاب کنید',
      );
      return false;
    } else if (isNext && step == 2 && addressId.value == 0) {
      showSnackbar(snackTypes.error, 'لطفا آدرس خود را انتخاب کنید');
      return false;
    } else if (isNext &&
        step == 3 &&
        !isImmediate.value &&
        (order.date == null || order.time == null)) {
      showSnackbar(snackTypes.error, 'لطفا تاریخ و بازه زمانی را انتخاب کنید');
      return false;
    }
    return true;
  }

  computeCost() {
    addPrice = 0;
    addTime = 0;
    if (questions.length > 0) {
      int index = 0;
      while (index != questionIndex) {
        addPrice += order.answers[index].price;
        addTime += order.answers[index].time;
        if (order.answers[index].nextQuestionIndex != null) {
          index = order.answers[index].nextQuestionIndex!;
        } else
          index++;
      }
      addPrice += order.answers[questionIndex].price;
      addTime += order.answers[questionIndex].time;
    }
  }

  changeStep({bool isNext = true}) async {
    if (!validation(isNext)) return;

    if (isNext &&
        questions.length > 0 &&
        (questionIndex < questions.length - 1 ||
            order.answers[questionIndex].nextQuestionIndex != null) &&
        step == 1 &&
        questions[questionIndex].targetQuestionId != -1) {
      if (order.answers[questionIndex].nextQuestionIndex != null) {
        int nextIndex = order.answers[questionIndex].nextQuestionIndex!;
        order.answers[nextIndex].preQuestionIndex = questionIndex;
        questionIndex = nextIndex;
      } else
        questionIndex++;

      computeCost();

      //because of init value textfield problem in flutter version 3 we  must build twice
      int? questionType = questions[questionIndex].type;
      questions[questionIndex].type = null;
      update(); //for build input of answer again with correct init value
      Future.delayed(Duration(milliseconds: 300), () {
        questions[questionIndex].type = questionType;
        update();
      });
      return;
    } else if (!isNext &&
        questions.length > 0 &&
        questionIndex > 0 &&
        step == 1) {
      if (order.answers[questionIndex].preQuestionIndex != null) {
        questionIndex = order.answers[questionIndex].preQuestionIndex!;
      } else
        questionIndex--;

      computeCost();
      //because of init value textfield problem in flutter version 3 we  must build twice
      int? questionType = questions[questionIndex].type;
      questions[questionIndex].type = null;
      update(); //for build input of answer again with correct init value
      Future.delayed(Duration(milliseconds: 300), () {
        questions[questionIndex].type = questionType;
        update();
      });
      return;
    }
    computeCost();
    int updatedStep = isNext ? step + 1 : step - 1;
    if (updatedStep == 5) {
      if ((ServiceController.services[order.serviceId]!.typePay == 0 ||
              ServiceController.services[order.serviceId]!.typePay == 1) &&
          order.priceValue != 0) {
        showBottomModal(
          Get.context!,
          550,
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'روش پرداخت را انتخاب کنید :',
                      style: AppController.fontStyle(
                        fontTypes.heading3,
                        itemColor3,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${AppController.priceFormat(((order.priceValue + addPrice) * (100 - (order.gift!.giftPercent ?? 0)) / 100).toInt())} تومان',
                      style: AppController.fontStyle(
                        fontTypes.heading1,
                        appColor,
                      ),
                    ),
                    SizedBox(height: 30),
                    SelectPay(
                      order.typePay!,
                      ((order.priceValue + addPrice) *
                              (100 - (order.gift!.giftPercent ?? 0)) /
                              100)
                          .toInt(),
                      (value) {
                        order.typePay = value;
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              Btn(
                btnType.primary,
                text: ' ثبت سفارش',
                onClick: () async {
                  Navigator.pop(Get.context!);
                  createOrder();
                },
              ),
              SizedBox(height: paddingSize),
            ],
          ),
        );
      } else {
        order.typePay = ServiceController.services[order.serviceId]!.typePay;
        createOrder();
      }
      return;
    }

    while ((ServiceController.services[order.serviceId]!.typePlace != 1 &&
            updatedStep == 2) ||
        (ServiceController.services[order.serviceId]!.typeTime == 0 &&
            updatedStep == 3)) {
      isNext ? updatedStep++ : updatedStep--;
    }
    if (isNext && updatedStep == 3) {
      getDates();
    }

    if (updatedStep < 1 || (questions.length == 0 && updatedStep == 1)) {
      Navigator.pop(Get.context!);
      return;
    }

    step = updatedStep;
    update();
  }

  getTitle() {
    switch (step) {
      case 1:
        return 'ثبت سفارش';
      case 2:
        return 'انتخاب آدرس';
      case 3:
        return 'انتخاب زمان';
      case 4:
        return 'تکمیل سفارش';
      case 5:
        return 'تکمیل سفارش';
    }
  }

  getDates() async {
    AppController.isLoading.value = true;
    var response;
    if (order.providerId != null &&
        ServiceController.services[order.serviceId]!.typeTime == 3)
      response = await RestApi.post(
        reserveProviderUrl,
        body: {
          'time': order.timespan + addTime,
          'provider_id': order.providerId,
        },
      );
    else
      response = await RestApi.post(
        dateUrl,
        body: {'service_id': order.serviceId, 'provider_id': order.providerId},
      );

    RestApi.responseHandler(
      response: response,
      successCallback: () {
        dates = <String, Date>{};
        if (order.providerId != null &&
            ServiceController.services[order.serviceId]!.typeTime == 3) {
          for (var json in response.data['data']) {
            Date date = Date.fromJson(json);
            dates[date.value!] = date;
          }
          // Map.from(response.data['data']).forEach((key, value) {
          //   Date date=Date.fromJson(value);
          //   dates[date.value!] = date;
          // });
        } else {
          for (var json in response.data['data']) {
            Date date = Date.fromJson(json);
            dates[date.value!] = date;
          }
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  // getTimes() async {
  //   var response = await RestApi.post(timeUrl,
  //       body: {'service_id': order.serviceId, 'provider_id': order.providerId});
  //   RestApi.responseHandler(
  //       response: response,
  //       successCallback: () {
  //         times = [];
  //         for (var value in response!.data['data']) {
  //           times.add(value);
  //         }
  //       });
  //   update();
  // }

  createOrder() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(createOrderUrl, body: order.toJson());
    await RestApi.responseHandler(
      response: response,
      successCallback: () async {
        Order o = Order.fromJson(response!.data['data']);
        order.id = o.id;
        order.code = o.code;
        statusPay.value = o.statusPay!;
        if (ServiceController.services[order.serviceId]!.typePay == 0 ||
            ServiceController.services[order.serviceId]!.typePay == 1)
          if ((order.priceValue + addPrice) > 0)
            await paymentOrder(order, 0);
          else
            statusPay.value = 1;
        step = 5;
        UserController.getUser();
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static paymentOrder(Order order, int additionId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      payOrderUrl,
      body: {
        'order_id': order.id,
        'type': order.typePay,
        'addition_id': additionId,
      },
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Order order = Order.fromJson(response!.data['data']['order']);
        statusPay.value = order.statusPay!;
        myOrders[order.id!] = order;
        //update:
        if (response.data['data']['pay_link'] != null)
          launchUrlString(
            baseUrl + response.data['data']['pay_link'],
            mode: LaunchMode.externalApplication,
          );
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static findProvider(String text) {
    seachedProviders.value = [];
    if (text != '')
      for (var provider in providers.values) {
        if ('${provider.fname!}${provider.lname!}'.removeAllWhitespace.contains(
          text.removeAllWhitespace,
        ))
          seachedProviders.add(provider);
      }
  }

  static getServiceProviders(int serviceId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      serviceProviderListUrl,
      body: {'service_id': serviceId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        providers = <int, Provider>{};
        for (var json in response!.data['data']) {
          Provider provider = Provider.fromJson(json);
          providers[provider.id!] = provider;
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static getOrderProviders(int orderId) async {
    OrderController o = Get.put(OrderController());
    if (orderId == o.order.id) {
      //for socket api if current page is updated order's providers get new list

      AppController.isLoading.value = true;

      var response = await RestApi.post(
        orderProviderListUrl,
        body: {'order_id': orderId},
      );
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          providers = <int, Provider>{};
          for (var json in response!.data['data']) {
            Provider provider = Provider.fromJson(json['provider']);
            provider.price = json['price'];
            provider.orderDescription = json['description'];
            providers[provider.id!] = provider;
          }
        },
      );
      AppController.isLoading.value = false;
    }
  }

  static acceptProvider(int orderId, int providerId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      acceptProviderUrl,
      body: {'order_id': orderId, 'provider_id': providerId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        OrderController.myOrders[orderId] = Order.fromJson(
          response!.data['data'],
        );
        Navigator.pop(Get.context!);
      },
    );
    AppController.isLoading.value = false;
  }

  static getProviderCvFiles(Provider provider) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(getCvFilesUrl, body: {'id': provider.id});
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        provider.cvFiles = <int, CvFile>{};
        for (var json in response!.data['data']) {
          CvFile cvFile = CvFile.fromJson(json);
          provider.cvFiles[cvFile.id!] = cvFile;
        }
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
  }

  static setMarkProvider(int providerId) async {
    var response = await RestApi.post(
      setMarkProviderUrl,
      body: {'provider_id': providerId},
    );
    RestApi.responseHandler(response: response);
  }

  // static getMyOrders() async {
  //   AppController.isLoading.value = true;
  //   var response = await RestApi.get(orderListUrl);
  //   RestApi.responseHandler(
  //       response: response,
  //       successCallback: () {
  //         myOrders.value = <int, Order>{};
  //         for (var json in response!.data['data']) {
  //           Order order = Order.fromJson(json);
  //           myOrders[order.id!] = order;
  //         }
  //       },printResponse: true);
  //   AppController.isLoading.value = false;
  // }

  static getMyOrders({int tabIndex = 1, bool refresh = false}) async {
    if (refresh) {
      myOrders.value = <int, Order>{};
      tabPageinations = {1: 1, 2: 1, 3: 1, 4: 1};
    }
    if (UserController.user.value.id != null) {
      if (refresh) {
        myOrders.value = <int, Order>{};
        tabPageinations = {1: 1, 2: 1, 3: 1, 4: 1};
      }
      if (tabPageinations[tabIndex] != 0) {
        // AppController.isLoading.value = true;
        AppController.startLoading('orderTab${tabIndex}');
        var response = await RestApi.post(
          orderListUrl,
          body: {
            'page': tabPageinations[tabIndex],
            'number': 5,
            'state': tabIndex,
          },
        );
        RestApi.responseHandler(
          response: response,
          successCallback: () {
            if (response!.data['data'].length == 0)
              tabPageinations[tabIndex] = 0;
            else {
              for (var json in response.data['data']) {
                Order order = Order.fromJson(json);
                myOrders[order.id!] = order;
              }
              tabPageinations[tabIndex] = tabPageinations[tabIndex]! + 1;
            }
          },
          printResponse: true,
        );
        // AppController.isLoading.value = false;
        AppController.finishLoading('orderTab${tabIndex}');
      }
    }
  }

  static getOrder(int orderId, {bool hasLoading = false}) async {
    if (hasLoading) AppController.isLoading.value = true;

    var response = await RestApi.post(getOrderUrl, body: {'order_id': orderId});
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Order order = Order.fromJson(response!.data['data']);
        myOrders[order.id!] = order;
        OrderController o = Get.put(OrderController());
        if (order.id == o.order.id) {
          o.order = order;
          statusPay.value = order.statusPay!;
        }
      },
      printResponse: true,
    );

    if (hasLoading) AppController.isLoading.value = false;
  }

  static cancelOrder(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      cancelOrderRequestUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        showBottomModal(
          Get.context!,
          300,
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    response!.data['data'] == null
                        ? 'آیا از لغو سفارش خود مطمین هستید؟'
                        : response.data['data']['description'],
                    style: AppController.fontStyle(
                      fontTypes.heading5,
                      itemColor1,
                    ),
                  ),
                ),
              ),
              Btn(
                btnType.primary,
                text: 'تایید / ادامه',
                onClick: () async {
                  Navigator.pop(Get.context!);
                  var response = await RestApi.post(
                    cancelOrderRegisterUrl,
                    body: {'order_id': orderId},
                  );
                  RestApi.responseHandler(
                    response: response,
                    successCallback: () {
                      myOrders[orderId] = Order.fromJson(
                        response!.data['data'],
                      );
                      UserController.getUser();
                    },
                  );
                },
              ),
              SizedBox(height: paddingSize),
            ],
          ),
          title: 'لغو درخواست',
        );
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static setRate(Rate rate) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(setRateUrl, body: rate.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOrders[rate.orderId!] = Order.fromJson(response!.data['data']);
      },
    );
    AppController.isLoading.value = false;
  }

  static meetProvider(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      meetProviderUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        showSnackbar(snackTypes.info, response!.data['message']);
        await launchUrl(
          Uri.parse(response.data['data']),
          mode: LaunchMode.externalApplication,
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static callProvider(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      callProviderUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        showSnackbar(snackTypes.info, response!.data['message']);
      },
    );
    AppController.isLoading.value = false;
  }

  static callPrivate(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      callPrivateUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        showSnackbar(snackTypes.info, response!.data['message']);
      },
    );
    AppController.isLoading.value = false;
  }

  static confirmOrder(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      confirmOrderUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOrders[orderId] = Order.fromJson(response!.data['data']);
        UserController.getUser();

        Rate rate = Rate(orderId: orderId);
        showBottomModal(
          Get.context!,
          400,
          Column(
            children: [
              SizedBox(height: 10),
              Text(
                'ثبت امتیاز :',
                style: AppController.fontStyle(fontTypes.heading3, itemColor2),
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
                lable: 'نظرتان را اینجا بنویسید ...',
                initValue: rate.description,
                icon1: Container(
                  child: Icon(Icons.edit_outlined, size: 20, color: itemColor4),
                  width: 50,
                  height: 125,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 5),
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
                  Navigator.pop(Get.context!);
                  setRate(rate);
                },
              ),
            ],
          ),
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static additionOrder(Addition addition, Order order) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      additionOrderUrl,
      body: {
        'order_id': addition.orderId,
        'description': addition.description,
        'amount': addition.amount,
      },
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        addition = Addition.fromJson(response!.data['data']);
        print('>>>>>${response}');
        showBottomModal(
          Get.context!,
          550,
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'روش پرداخت را انتخاب کنید :',
                      style: AppController.fontStyle(
                        fontTypes.heading3,
                        itemColor3,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${AppController.priceFormat(addition.amount!)} تومان',
                      style: AppController.fontStyle(
                        fontTypes.heading1,
                        appColor,
                      ),
                    ),
                    SizedBox(height: 30),
                    SelectPay(order.typePay!, addition.amount!, (value) {
                      order.typePay = value;
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              Btn(
                btnType.primary,
                text: ' پرداخت',
                onClick: () async {
                  Navigator.pop(Get.context!);
                  paymentOrder(order, addition.id!);
                },
              ),
              SizedBox(height: paddingSize),
            ],
          ),
        );
      },
    );
    AppController.isLoading.value = false;
  }

  checkGiftCode() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      giftCodeUrl,
      body: {'service_id': order.serviceId, 'code': order.gift!.giftTitle},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        order.gift!.giftPercent = response!.data['data'];
      },
    );
    AppController.isLoading.value = false;
  }

  static getExportOrder(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(exportOrderUrl, body: {'id': orderId});
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        await launchUrl(
          Uri.parse(response!.data['data']),
          mode: LaunchMode.externalApplication,
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static setTime(Order order) {
    timer.cancel();
    timerDuration.value = Duration(seconds: 0);
    if (order.state == 2 &&
        ServiceController.services[order.serviceId]!.typePlace == 2) {
      DateTime dateTime = DateTime.parse('${order.date} ${order.time}');

      if (dateTime.difference(DateTime.now()).inSeconds > 0) {
        timerDuration.value = Duration(
          seconds: dateTime.difference(DateTime.now()).inSeconds,
        );
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          final seconds = timerDuration.value.inSeconds - 1;
          if (seconds < 0) {
            timer.cancel();
          } else {
            timerDuration.value = Duration(seconds: seconds);
          }
        });
      }
    }
  }

  static getTime() {
    final hours = timerDuration.value.inHours.toString().padLeft(2, '0');
    final minutes = timerDuration.value.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = timerDuration.value.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  static getOrderDocuments(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.get(
      getOrderDocuemntsUrl,
      query: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        OrderController.myOrders[orderId]!.documents = <int, OrderDocument>{};
        for (var json in response!.data['data']) {
          OrderDocument orderDocument = OrderDocument.fromJson(json);
          OrderController.myOrders[orderId]!.documents[orderDocument.id!] =
              orderDocument;
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static addOrderDocument(OrderDocument orderDocument) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      storeOrderDocuemntUrl,
      body: orderDocument.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        Navigator.of(Get.context!).pop();
        OrderDocument o = OrderDocument.fromJson(response!.data['data']);
        OrderController.myOrders[orderDocument.orderId]!.documents[o.id!] = o;
        for (OrderDocumentFile orderDocumentFile
            in orderDocument.documentFiles) {
          orderDocumentFile.orderDocumentId = o.id;
          await addOrderDocumentFile(orderDocumentFile);
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static addOrderDocumentFile(OrderDocumentFile orderDocumentFile) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      storeDocuemntFileUrl,
      body: orderDocumentFile.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        OrderDocumentFile o = OrderDocumentFile.fromJson(
          response!.data['data'],
        );
        OrderController
            .myOrders[orderDocumentFile.orderId]!
            .documents[orderDocumentFile.orderDocumentId!]!
            .fileUrls
            .add(o.file!);
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }
}
