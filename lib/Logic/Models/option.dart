class Option {
  int? id;
  String? title;
  int? price;
  int? questionId;
  int? targetQuestionId;
  int? time;

  Option(
      {this.id,
        this.title,
        this.price,
        this.questionId,
        this.targetQuestionId,
        this.time});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    questionId = json['question_id'];
    targetQuestionId = json['target_question_id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['question_id'] = this.questionId;
    data['target_question_id'] = this.targetQuestionId;
    data['time'] = this.time;
    return data;
  }
}
