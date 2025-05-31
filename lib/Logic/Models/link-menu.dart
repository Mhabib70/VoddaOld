import 'package:flutter/foundation.dart';

class LinkMenu {
  int? id;
  String? title;
  String? description;
  String? icon;
  String? icon_api;

  LinkMenu({this.id, this.title, this.description, this.icon});

  LinkMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    icon = kIsWeb?json['icon_pwa']:json['icon_api'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}
