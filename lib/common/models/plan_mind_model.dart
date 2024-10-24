class PlanMindModel {
  String? code;
  String? duration;
  String? name;
  String? source;
  String? url;

  PlanMindModel({this.code, this.duration, this.name, this.source, this.url});

  PlanMindModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    duration = json['duration'];
    name = json['name'];
    source = json['source'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['duration'] = this.duration;
    data['name'] = this.name;
    data['source'] = this.source;
    data['url'] = this.url;
    return data;
  }
}
