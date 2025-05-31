class Date {
  String? key;
  String? value;
  String? day;
  String? weekDay;
  String? month;
  List<String>? time;

  Date({this.key, this.value, this.day, this.weekDay, this.month, this.time});

  Date.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    day = json['day'];
    weekDay = json['week_day'];
    month = json['month'];
    time = json['time'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['day'] = this.day;
    data['week_day'] = this.weekDay;
    data['month'] = this.month;
    data['time'] = this.time;
    return data;
  }
}
