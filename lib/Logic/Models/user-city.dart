import 'package:get/get.dart';
import 'package:vodda_old/Logic/Controllers/main_controller.dart';
import 'package:vodda_old/Logic/Models/city.dart';
import 'package:vodda_old/Logic/Models/province.dart';

class UserCity {
  int? provinceId;
  int? cityId;
  late Province province;
  late City city;

  UserCity();

  UserCity.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    cityId = json['city_id'];
    province = Get.find<MainController>().provinces[provinceId]!;
    city = Get.find<MainController>().provinces[provinceId]!.cities[cityId!]!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    return data;
  }

  setModels() {
    province = Get.find<MainController>().provinces[provinceId]!;
    city = Get.find<MainController>().provinces[provinceId]!.cities[cityId!]!;
  }
}
