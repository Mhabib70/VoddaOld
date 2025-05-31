import 'package:flutter/foundation.dart';
import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/service.dart';

class Category {
  int? id;
  String? title;
  String? type;
  bool? hasSub;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? icon;
  String? description;
  Category? parent;
  List<Category> categories = [];
  List<int> serviceIds = [];
  Category({
    this.id,
    this.title,
    this.type,
    this.hasSub,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    hasSub = json['has_sub'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon =
        json['icon'] == null || json['icon'] == ''
            ? MainController.setting['category_image']
            : kIsWeb
            ? json['icon_pwa']
            : json['icon'];
    description = json['description'];
    // if(json['services']!=null){
    //   for(var serviceJson in json['services']){
    //     Service service=Service.fromJson(serviceJson);
    //     ServiceController.services[service.id!]=service;
    //     serviceIds.add(service.id!);
    //   }
    // }
  }
}
