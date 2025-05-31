import 'package:flutter/foundation.dart';
import 'package:vodda_old/Logic/Models/address.dart';
import 'package:vodda_old/Logic/Models/user-city.dart';

class User {
  int? id;
  String? mobile;
  String? createdAt;
  String? updatedAt;
  String? fname;
  String? lname;
  String? avatar;
  String? code;
  String? inviteCode;
  int sex = 1;
  int? score;
  int? scorePrice;
  int walletTotal = 0;
  bool? isCompleted;
  int? orderCount;
  int? orderDoneCount;
  int? orderProgressCount;
  String? notificationToken;
  Address address = Address();

  User({
    this.id,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.fname,
    this.lname,
    this.sex = 1,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fname = json['fname'];
    lname = json['lname'];
    avatar = kIsWeb ? json['avatar_pwa'] : json['avatar'];
    sex = json['sex'];
    score = json['score'];
    scorePrice = json['score_price'];
    code = json['code'];
    inviteCode = json['invite_code'];
    walletTotal = json['wallet_total'] ?? 0;
    orderCount = json['order_count'];
    orderProgressCount = json['order_in_progress_count'];
    orderDoneCount = json['order_done_count'];
    isCompleted = json['is_completed'];
    address.provinceId = json['province_id'];
    notificationToken = json['notification_token'];
    address.cityId = json['city_id'];
    address.place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['sex'] = this.sex;
    data['invite_code'] = this.inviteCode;
    data['is_completed'] = this.isCompleted;
    data['province_id'] = this.address.provinceId;
    data['city_id'] = this.address.cityId;
    data['place'] = this.address.place;
    data['lat'] = this.address.lat;
    data['long'] = this.address.long;
    return data;
  }
}
