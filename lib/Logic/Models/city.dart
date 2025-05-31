class City {
  int? id;
  int? provinceId;
  int? countyId;
  String? name;

  City({this.id, this.provinceId, this.countyId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    countyId = json['county_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['county_id'] = this.countyId;
    data['name'] = this.name;
    return data;
  }
}
