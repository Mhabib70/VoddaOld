import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/order-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/comment.dart';
import 'package:vodda_old/Logic/Models/cv-file.dart';
import 'package:vodda_old/Logic/Models/service.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';

class Provider {
  int? id;
  String? fname;
  String? lname;
  String? mobile;
  String? skill;
  int? provinceId;
  int? cityId;
  double? lat;
  double? long;
  int? serviceCount;
  int? online;
  String? avatar;
  String? rate;
  int? orderCount;
  int? orderProgressCount;
  List<int> serviceIds = [];
  List<Comment> comments = [];
  String? typeTitle;
  String? price;
  int? time;
  String? orderDescription;
  String? cv;
  bool? isMark;

  Map<int, CvFile> cvFiles = <int, CvFile>{};

  Provider({
    this.id,
    this.fname,
    this.lname,
    this.mobile,
    this.skill,
    this.serviceCount,
    this.avatar,
  });

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    mobile = json['mobile'];
    skill = json['skill'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    serviceCount = json['service_count'];
    online = json['online'];

    price = json['price'];
    time = json['time'];
    lat = json['lat'] == null ? null : double.parse(json['lat']);
    long = json['long'] == null ? null : double.parse(json['long']);
    avatar =
        json['avatar'] == null || json['avatar'] == ''
            ? MainController.setting['provider_image']
            : kIsWeb
            ? json['avatar_pwa']
            : json['avatar'];
    rate = json['rate'];
    typeTitle = json['type_title'];
    orderCount = json['order_count'];
    orderProgressCount = json['order_in_progress_count'];
    cv = json['cv'];
    isMark = json['is_mark'];
    if (json['services'] != null) {
      for (var serviceJson in json['services']) {
        Service service = Service.fromJson(serviceJson);
        ServiceController.services[service.id!] = service;
        serviceIds.add(service.id!);
      }
    }
    print('comments>>>>${json['comments']}');
    if (json['comments'] != null) {
      for (var commentJson in json['comments']) {
        Comment comment = Comment.fromJson(commentJson);
        comments.add(comment);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['mobile'] = this.mobile;
    data['skill'] = this.skill;
    data['service_count'] = this.serviceCount;
    data['avatar'] = this.avatar;
    data['cv'] = this.cv;
    return data;
  }

  bool hasUserCity() {
    if (UserController.userCities.length == 0) return true;
    if (UserController.userCities.keys.contains(provinceId)) return true;
    return false;
  }
}
