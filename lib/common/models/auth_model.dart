class AuthModel {
  AuthModel({
    this.idToken,
    this.accessToken,
    this.refreshToken,
    this.session,
  });
  String? idToken;
  String? accessToken;
  String? refreshToken;
  String? session;

  get isAuth => idToken?.isNotEmpty ?? false;

  AuthModel.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idToken'] = idToken;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['session'] = session;
    return data;
  }
}
