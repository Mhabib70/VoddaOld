class AppVersion {
  String? version;
  String? group;
  String? link;
  bool required=false;
  String? title;
  String? name;
  String? text;

  AppVersion(
      {this.version,
        this.group,
        this.link,
        this.required=false,
        this.title,
        this.name,
        this.text});

  AppVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    group = json['group'];
    link = json['link'];
    required = json['required']=="1";
    title = json['title'];
    name = json['name'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['group'] = this.group;
    data['link'] = this.link;
    data['required'] = this.required;
    data['title'] = this.title;
    data['name'] = this.name;
    data['text'] = this.text;
    return data;
  }
}
