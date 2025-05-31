import 'package:flutter/foundation.dart';

class OrderQuestion {
  int? id;
  int? orderId;
  String? question;
  var res;
  int? typeQuestion;
  String? price;
  String? path_image;
  int? time;
  int? questionId;

  OrderQuestion(
      {this.id,
        this.orderId,
        this.question,
        this.res,
        this.typeQuestion,
        this.price,
        this.time,
        this.questionId});

  OrderQuestion.fromJson(Map<String, dynamic> json) {
    print("jsonnnnn:${json}");
    id = json['id'];
    orderId = json['order_id'];
    question = json['question'];
    typeQuestion = json['type_question'];
    res =typeQuestion==2?( kIsWeb? json['image_pwa']:json['path_image']) :json['res'];
    price = json['price'];
    time = json['time'];
    path_image = json['path_image'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['question'] = this.question;
    data['res'] = this.res;
    data['type_question'] = this.typeQuestion;
    data['price'] = this.price;
    data['time'] = this.time;
    data['question_id'] = this.questionId;
    return data;
  }
}
