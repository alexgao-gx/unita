class AddressModel {
  String? address;
  int? id;
  String? name;
  String? phone;
  String? prefix;
  String? room;
  String? zipCode;

  AddressModel(
      {this.address,
        this.id,
        this.name,
        this.phone,
        this.prefix,
        this.room,
        this.zipCode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    prefix = json['prefix'];
    room = json['room'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['prefix'] = this.prefix;
    data['room'] = this.room;
    data['zipCode'] = this.zipCode;
    return data;
  }
}
