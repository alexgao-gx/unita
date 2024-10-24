class PaymentModel {
  String? cardNo;
  String? cvv;
  String? expireDate;
  int? id;
  String? name;

  PaymentModel({this.cardNo, this.cvv, this.expireDate, this.id, this.name});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    cardNo = json['cardNo'];
    cvv = json['cvv'];
    expireDate = json['expireDate'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNo'] = this.cardNo;
    data['cvv'] = this.cvv;
    data['expireDate'] = this.expireDate;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
