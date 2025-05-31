import 'dart:convert';

import 'package:vodda_old/Logic/Models/order-document-file.dart';

class OrderDocument {
  int? id;
  int? orderId;
  String? description;
  List<OrderDocumentFile> documentFiles = [];
  List<String> fileUrls = [];

  OrderDocument({this.id, this.orderId, this.description});

  OrderDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    description = json['description'];
    if (json['files'] != null) {
      for (var filejson in json['files']) {
        OrderDocumentFile orderDocumentFile = OrderDocumentFile.fromJson(
          filejson,
        );

        fileUrls.add(orderDocumentFile.file!);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['description'] = this.description;
    return data;
  }

  setFiles(List<dynamic> images) {
    documentFiles = [];
    for (var image in images) {
      OrderDocumentFile orderDocumentFile = OrderDocumentFile();
      orderDocumentFile.orderId = this.orderId;
      orderDocumentFile.file = base64.encode(image);
      documentFiles.add(orderDocumentFile);
    }
  }
}
