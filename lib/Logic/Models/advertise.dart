class Advertise {
  String? title;
  String? group;
  String? image1;
  String? image1Api;
  String? image1Pwa;
  String? image2;
  String? image2Api;
  String? image2Pwa;

  Advertise(
      {this.title,
        this.group,
        this.image1,
        this.image1Api,
        this.image1Pwa,
        this.image2,
        this.image2Api,
        this.image2Pwa});

  Advertise.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    group = json['group'];
    image1 = json['image1'];
    image1Api = json['image1_api'];
    image1Pwa = json['image1_pwa'];
    image2 = json['image2'];
    image2Api = json['image2_api'];
    image2Pwa = json['image2_pwa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['group'] = this.group;
    data['image1'] = this.image1;
    data['image1_api'] = this.image1Api;
    data['image1_pwa'] = this.image1Pwa;
    data['image2'] = this.image2;
    data['image2_api'] = this.image2Api;
    data['image2_pwa'] = this.image2Pwa;
    return data;
  }
}
