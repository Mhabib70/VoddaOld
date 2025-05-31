class Gift {
  String? giftTitle;
  int? giftPercent;
  int? price;
  int? giftPrice;

  Gift({this.giftTitle, this.giftPercent, this.price, this.giftPrice});

  Gift.fromJson(Map<String, dynamic> json) {
    giftTitle = json['gift_title'];
    giftPercent = json['gift_percent'];
    price = json['price'];
    giftPrice = json['gift_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gift_title'] = this.giftTitle;
    data['gift_percent'] = this.giftPercent;
    data['price'] = this.price;
    data['gift_price'] = this.giftPrice;
    return data;
  }
}
