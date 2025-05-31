class Wallet {
  int? id;
  int? userId;
  int? amount;
  int? type;
  String? description;
  String? date;
  String? time;
  String? typeTitle;

  Wallet(
      {this.id,
        this.userId,
        this.amount,
        this.type,
        this.description,
        this.date,
        this.time,
        this.typeTitle});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    type = json['type'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    typeTitle = json['type_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['description'] = this.description;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type_title'] = this.typeTitle;
    return data;
  }
}
