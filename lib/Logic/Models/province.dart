import 'package:vodda_old/Logic/Models/city.dart';

class Province {
  int? id;
  String? name;
  Map<int, City> cities = <int, City>{};
  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['cities'] != null) {
      for (var cityJson in json['cities']) {
        City city = City.fromJson(cityJson);
        cities[city.id!] = city;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
