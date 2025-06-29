import 'package:flutter/foundation.dart' as web;
import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Controllers/user-controller.dart';
import 'package:vodda_old/Logic/Models/category.dart';

class Service {
  int? id;
  String? title;
  String? shortDescription;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? price;
  int? time;
  int? typePlace;
  int? typePay;
  int? typeTime;
  String? typePayTitle;
  int? type;
  int? providerCount;
  int? orderProgressCount;
  int? orderCount;
  int? orderIndex;
  int? type_online;
  int? negotiable;
  bool? isFavorite;
  List<int> cityIds = [];
  List<int> provinceIds = [];
  List<String> images = [];
  List<Category> breadcrumb = [];
  List<int> relatedIds = [];

  Service({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.price,
    this.time,
    this.type,
    this.typePlace,
    this.typePay,
    this.isFavorite,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    shortDescription = json['short_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    orderIndex = json['order_index'];
    type_online = json['type_online'];
    negotiable = json['negotiable'];
    price = json['price'];
    time = json['time'];
    type = json['type'];
    typePlace = json['type_place'];
    typeTime = json['type_time'];
    typePay = json['type_pay'];
    typePayTitle = json['type_pay_title'];
    isFavorite = json['is_favorite'];
    providerCount = json['provider_count'];
    orderCount = json['order_count'];
    orderProgressCount = json['order_in_progress_count'];

    // if(json['city_ids']!=null){
    //   for(var cityId in json['city_ids'])
    //     if(cityId!=null)
    //     cityIds.add(cityId);
    // }
    if (json['province_ids'] != null) {
      for (var provinceId in json['province_ids'])
        if (provinceId != null) provinceIds.add(provinceId);
    }
    if (json['images'] != null) {
      for (var image in json['images'])
        images.add(web.kIsWeb ? image['file_pwa'] : image['file']);
    }
    if (images.length == 0)
      images.add(Get.find<MainController>().setting['service_image']);
    setBreadcrumb();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['price'] = this.price;
    data['time'] = this.time;
    data['type'] = this.type;
    data['type_place'] = this.typePlace;
    data['type_pay'] = this.typePay;
    data['is_favorite'] = this.isFavorite;
    return data;
  }

  setBreadcrumb() {
    if (this.categoryId != null &&
        ServiceController.categories.keys.contains(this.categoryId)) {
      Category parent = ServiceController.categories[this.categoryId!]!;
      breadcrumb.add(parent);
      while (parent.categoryId != null &&
          ServiceController.categories.keys.contains(parent.categoryId)) {
        parent = ServiceController.categories[parent.categoryId!]!;
        breadcrumb.add(parent);
      }
      ;
    }
  }

  bool hasUserCity() {
    if (UserController.userCities.length == 0 || type == 3 || typePlace == 2)
      return true;
    for (int provinceId in provinceIds) {
      if (UserController.userCities.keys.contains(provinceId)) return true;
    }

    return false;
  }
}
