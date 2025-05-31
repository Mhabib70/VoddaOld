import 'package:vodda_old/Logic/Controllers/main-controller.dart';
import 'package:vodda_old/Logic/Controllers/service-controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';

class Tag {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? type;
  List<int> serviceIds = [];
  List<int> providerIds = [];

  Tag({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.serviceIds = const [],
  });

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    if (json['services'] != null) {
      for (var serviceJson in json['services']) {
        if (serviceJson['service'] != null) {
          Service serviceModel = Service.fromJson(serviceJson['service']);
          ServiceController.services[serviceModel.id!] = serviceModel;
          this.serviceIds.add(serviceModel.id!);
        }
      }
    }
    if (json['providers'] != null) {
      for (var providerJson in json['providers']) {
        if (providerJson['provider'] != null) {
          Provider providerModel = Provider.fromJson(providerJson['provider']);
          MainController.tagProviders[providerModel.id!] = providerModel;
          this.providerIds.add(providerModel.id!);
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}
