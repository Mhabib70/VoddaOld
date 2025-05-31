class Comment {
  int? id;
  int? value;
  String? description;
  int? orderId;
  int? providerId;
  String? userName;
  String? date;

  Comment(
      {this.id,
        this.value,
        this.description,
        this.orderId,
        this.providerId,
        this.userName,
        this.date});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    description = json['description'];
    orderId = json['order_id'];
    providerId = json['provider_id'];
    userName = json['user_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['description'] = this.description;
    data['order_id'] = this.orderId;
    data['provider_id'] = this.providerId;
    data['user_name'] = this.userName;
    data['date'] = this.date;
    return data;
  }
}
