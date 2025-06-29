import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Controllers/service_controller.dart';
import 'package:vodda_old/Logic/Models/provider.dart';
import 'package:vodda_old/Logic/Models/service.dart';

class Tag {
  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? type;
  int? orderIndex;
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
    orderIndex = json['order_index'];
    type = json['type'];
    if (json['services'] != null) {
      for (var serviceJson in json['services']) {
        if (serviceJson['service'] != null) {
          Service serviceModel = Service.fromJson(serviceJson['service']);
          Get.find<ServiceController>().services[serviceModel.id!] =
              serviceModel;
          serviceIds.add(serviceModel.id!);
        }
      }
      serviceIds.sort(
        (a, b) => Get.find<ServiceController>().services[b]!.orderIndex!
            .compareTo(Get.find<ServiceController>().services[a]!.orderIndex!),
      );
    }
    if (json['providers'] != null) {
      for (var providerJson in json['providers']) {
        if (providerJson['provider'] != null) {
          Provider providerModel = Provider.fromJson(providerJson['provider']);
          try {
            Get.find<MainController>().tagProviders[providerModel.id!] =
                providerModel;
          } catch (e) {}

          providerIds.add(providerModel.id!);
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    return data;
  }
}
