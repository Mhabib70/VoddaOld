class CvFile {
  int? id;
  int? providerId;
  String? file;
  int? isVideo;
  int? confirmed;

  CvFile({this.id, this.providerId, this.file, this.isVideo});

  CvFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    file = json['file'];
    isVideo = json['is_video'];
    confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['file'] = this.file;
    data['is_video'] = this.isVideo;
    return data;
  }
}