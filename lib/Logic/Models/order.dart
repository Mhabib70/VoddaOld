import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/addition.dart';
import 'package:vodda_old/Logic/Models/answer.dart';
import 'package:vodda_old/Logic/Models/gift.dart';
import 'package:vodda_old/Logic/Models/order-document.dart';
import 'package:vodda_old/Logic/Models/order-question.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Public/images.dart';
import 'package:vodda_old/Public/styles.dart';

class Order {
  int? id;
  int? userId;
  int? serviceId;
  int? providerId;
  String? address;
  String? date;
  String? time;
  int? typeDate;
  String? code;
  int? state;
  int? acceptedProviderId;
  String? price;
  int? durationTime;
  int? canceled;
  int? cityId;
  String? description;
  String? providerDescription;
  int? typePay;
  String? servicePrice;
  int? type;
  String? typeTitle;
  String? fullAddress;
  String? fullDate;
  String? fullTime;
  String? typePayTitle;
  int? typeCall;
  String? stateTitle;
  int? statusPay;
  int? countProvider;
  var rate;
  bool? isRate;
  String? userName;
  double? lat;
  double? long;
  List<Answer> answers = [];
  int? addressId;
  Provider? provider;
  List<Addition> additions = [];
  Gift? gift = Gift();
  int priceValue = 0;
  int timespan = 0;
  Map<int, OrderQuestion>? questions;
  String? stateIcon;
  Color? stateColor;

  Map<int, OrderDocument> documents = <int, OrderDocument>{};

  Order({
    this.serviceId,
    this.providerId,
    this.answers = const [],
    this.addressId,
    this.date,
    this.time,
    this.typeDate = 1,
    this.typePay = 0,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    address = json['address'];
    date = json['date'];
    time = json['time'];
    typeDate = json['type_date'];
    code = json['code'];
    state = json['state'];
    statusPay = json['status_pay'];
    price = json['total_price'];
    durationTime = json['duration_time'];
    canceled = json['canceled'];
    cityId = json['city_id'];
    description = json['description'];
    providerDescription = json['provider_description'];
    typePay = json['type_pay'] ?? 0;
    servicePrice = json['service_price'];
    type = json['type'];
    typeTitle = json['type_title'];
    typeCall = json['type_call'];
    fullAddress = json['full_address'];
    fullDate = json['full_date'];
    fullTime = json['full_time'];
    typePayTitle = json['type_pay_title'];
    stateTitle = json['state_title'];
    countProvider = json['count_provider'];
    rate = json['rate'];
    isRate = json['is_rate'];
    userName = json['user_name'];
    setColorIconState();
    if (json['service'] != null) {
      Service service = Service.fromJson(json['service']);
      Get.find<ServiceController>().services[serviceId!] = service;
    }
    if (json['provider'] != null) {
      provider = Provider.fromJson(json['provider']);
    }
    if (json['accepted_provider'] != null) {
      provider = Provider.fromJson(json['accepted_provider']);
    }
    if (json['lat_long'] != null) {
      lat = double.parse(json['lat_long'].split(',').first);
      long = double.parse(json['lat_long'].split(',').last);
    }
    if (json['additions'] != null) {
      additions = [];
      for (var addition in json['additions'])
        additions.add(Addition.fromJson(addition));
    }
    print('orderQuestions>>>${json['questions']}');
    if (json['questions'] != null) {
      questions = <int, OrderQuestion>{};
      json['questions'].forEach((v) {
        OrderQuestion question = OrderQuestion.fromJson(v);
        if (question.typeQuestion == 2 || question.typeQuestion == 3) {
          print("Path image:${question.path_image}");
          if (questions!.containsKey(question.questionId))
            // questions![question.questionId]!.res.add(question.typeQuestion==2?question.path_image:question.res);
            questions![question.questionId]!.res.add(question.res);
          else {
            // question.res=[question.typeQuestion==2?question.path_image:question.res];
            question.res = [question.res];
            questions![question.questionId!] = question;
          }
        } else
          questions![question.questionId!] = question;
      });
    }

    gift = json['gift'] == null ? null : Gift.fromJson(json['gift']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['provider_id'] = this.providerId;
    if (this.answers != null) {
      data['answer'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['address_id'] = this.addressId;
    data['date'] = this.typeDate == 0 ? null : this.date;
    data['time'] = this.typeDate == 0 ? null : this.time;
    data['type_date'] = this.typeDate;
    data['type_pay'] = this.typePay;
    data['description'] = this.description;
    data['provider_description'] = this.providerDescription;
    data['gift_code'] = this.gift!.giftTitle;
    return data;
  }

  setColorIconState() {
    switch (state) {
      case 1:
        stateIcon = waitingstateIcon;
        stateColor = waitingStateColor;
        break;
      case 2:
        stateIcon = doingstateIcon;
        stateColor = doingStateColor;
        break;
      case 3:
        stateIcon = donestateIcon;
        stateColor = doneStateColor;
        break;
      default:
        stateIcon = cancelstateIcon;
        stateColor = errorColor;
    }
  }
}
