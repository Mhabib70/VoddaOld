import 'package:vodda_old/Logic/Controllers/app-controller.dart';
import 'package:vodda_old/Logic/Controllers/main-controller.dart';
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
    province = MainController.provinces[provinceId]!;
    city = MainController.provinces[provinceId]!.cities[cityId!]!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    return data;
  }

  setModels() {
    province = MainController.provinces[provinceId]!;
    city = MainController.provinces[provinceId]!.cities[cityId!]!;
  }
}
