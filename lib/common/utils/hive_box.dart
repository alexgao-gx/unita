import 'package:hive/hive.dart';
import '../models/user_model.dart';

class HiveBox {
  static late ConfigBox config;
  static late UserBox user;
  static late AuthBox auth;

  static Future<void> initBoxes() async {
    config = ConfigBox(await Hive.openBox('config'));
    user = UserBox(await Hive.openBox('user'));
    auth = AuthBox(await Hive.openBox('auth'));
  }
}

class ConfigBox {
  final Box box;

  ConfigBox(this.box);

  static const isNotFirstInstalledKey = 'isNotFirstInstalledKey';

  /// 非首次安装进入
  bool get isNotFirstInstalled => box.containsKey(isNotFirstInstalledKey);

  Future<void> setNotFirstInstalled(bool value) =>
      box.put(isNotFirstInstalledKey, value);
}

class UserBox {
  final Box box;

  UserBox(this.box);

  static const userKey = 'user';

  bool containsUser() => box.containsKey(userKey);

  UserModel getUser() {
    return UserModel.fromJson(box.get(userKey));
  }

  setUser(UserModel user) => box.put(userKey, user.toJson());
}

class AuthBox {
  final Box box;

  AuthBox(this.box);

  static const authKey = 'auth';

  bool containsAuth() => box.containsKey(authKey);

  Map<String, dynamic> getAuth() {
    return box.get(authKey)?.cast<String, dynamic>() ?? {};
  }

  setAuth(Map<String, dynamic> auth) => box.put(authKey, auth);

  clearAuth() => box.delete(authKey);
}
