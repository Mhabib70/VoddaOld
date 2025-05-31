class SocketNotification {
  String? token;
  String? type;
  String? fId;
  String? isShowAlert;
  String? isAudioAlert;
  String? message;
  String? status;

  SocketNotification(
      {this.token, this.type, this.fId, this.isShowAlert, this.message});

  SocketNotification.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    fId = json['f_id'];
    isShowAlert = json['is_show_alert'];
    isAudioAlert = json['is_audio_alert'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    data['f_id'] = this.fId;
    data['is_show_alert'] = this.isShowAlert;
    data['message'] = this.message;
    return data;
  }
}
