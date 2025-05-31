class Payment {
  int? id;
  int? amount;
  String? refrenceId;
  String? message;
  int? status;
  String? statusTitle;
  String? payFor;
  String? date;
  String? time;

  Payment(
      {this.id,
        this.amount,
        this.refrenceId,
        this.message,
        this.status,
        this.statusTitle,
        this.payFor,
        this.date});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    refrenceId = json['refrence_id'];
    message = json['message'];
    status = json['status'];
    statusTitle = json['status_title'];
    payFor = json['pay_for'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['refrence_id'] = this.refrenceId;
    data['message'] = this.message;
    data['status'] = this.status;
    data['status_title'] = this.statusTitle;
    data['pay_for'] = this.payFor;
    data['date'] = this.date;
    return data;
  }
}
