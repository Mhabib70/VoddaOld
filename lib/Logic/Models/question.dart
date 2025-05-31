import 'package:vodda_old/Logic/Models/option.dart';

class Question {
  int? id;
  String? title;
  int? type;
  int? max;
  int? required;
  int? targetQuestionId;
  List<Option>? options;

  Question({
    this.id,
    this.title,
    this.type,
    this.max,
    this.required,
    this.options,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    max = json['max'];
    required = json['required'];
    targetQuestionId = json['target_question_id'];
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options!.add(new Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['max'] = this.max;
    data['required'] = this.required;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
