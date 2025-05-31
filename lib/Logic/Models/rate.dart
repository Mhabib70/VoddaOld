class Rate {
  int? orderId;
  int? value;
  String? description;
  int? id;

  Rate({this.orderId, this.value=0, this.description, this.id});

  Rate.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    value = json['value'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['value'] = this.value;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}
