class Addition {
  int? orderId;
  String? description;
  int? amount;
  int? id;
  bool accepted=false;
  Addition({this.orderId, this.description, this.amount, this.id});

  Addition.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    description = json['description'];
    amount = json['amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['id'] = this.id;
    return data;
  }
}
