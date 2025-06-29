import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
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
  String? city;
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
    city =
        Get.find<MainController>()
            .provinces[provinceId]
            ?.cities[cityId]
            ?.name ??
        "";
    serviceCount = json['service_count'];
    online = json['online'];

    price = json['price'];
    time = json['time'];
    lat = json['lat'] == null ? null : double.parse(json['lat']);
    long = json['long'] == null ? null : double.parse(json['long']);
    avatar =
        json['avatar'] == null || json['avatar'] == ''
            ? Get.find<MainController>().setting['provider_image']
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
        Get.find<ServiceController>().services[service.id!] = service;
        serviceIds.add(service.id!);
      }
      serviceIds.sort(
        (a, b) => Get.find<ServiceController>().services[b]!.orderIndex!
            .compareTo(Get.find<ServiceController>().services[a]!.orderIndex!),
      );
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
