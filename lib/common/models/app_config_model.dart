class AppConfigModel {
  AppConfigModel({
    this.kefuQrCode,
    this.dlQrCode,
    this.qbImgUrl,
  });
  String? kefuQrCode;
  String? dlQrCode;
  String? qbImgUrl;

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    kefuQrCode = json['kefuQrCode'];
    dlQrCode = json['dlQrCode'];
    qbImgUrl = json['qbImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['kefuQrCode'] = kefuQrCode;
    data['dlQrCode'] = dlQrCode;
    data['qbImgUrl'] = qbImgUrl;
    return data;
  }
}
