class Address {
  int? id;
  String? title;
  int? provinceId;
  int? cityId;
  String? place;
  String? fullAddress;
  int? userId;
  double? lat;
  double? long;

  Address(
      {this.id,
        this.title,
        this.provinceId,
        this.cityId,
        this.place,
        this.userId,
        this.lat,
        this.long});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    place = json['place'];
    fullAddress = json['full_address'];
    userId = json['user_id'];
    lat = json['lat']==null?null:double.parse(json['lat']);
    long = json['long']==null?null:double.parse(json['long']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['place'] = this.place;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
