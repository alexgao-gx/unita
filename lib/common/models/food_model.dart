class FoodModel {
  String? code;
  String? name;
  num? serving;

  FoodModel({this.code, this.name, this.serving});

  FoodModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    serving = json['serving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['serving'] = this.serving;
    return data;
  }
}
