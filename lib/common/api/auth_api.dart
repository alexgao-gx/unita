/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

/// Authorization APIs
class AuthAPI {
  /// Login
  static Future<AuthModel> login(String username, String password) async {
    var resp = await ApiClient()
        .post('/login', data: {'username': username, 'password': password});
    return resp.data != null ? AuthModel.fromJson(resp.data) : AuthModel();
  }

  /// Logout
  static Future logout() async {
    var resp = await ApiClient().get('/logout');
    return resp.data;
  }

  /// Create Account-Send Captcha
  static Future<String?> sendCaptchaWhenCreateAccount(String email,
      {String? username, String? password, String? confirmPassword}) async {
    var resp = await ApiClient().post('/sendCode', data: {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    });
    return resp.data;
  }

  /// Forget Password - Send Captcha
  static Future<String?> sendCaptchaWhenForgetPassword(String email) async {
    var resp = await ApiClient()
        .get('/forgotPass', queryParameters: {'username': email});
    return resp.data;
  }

  /// Register Account
  static Future<AuthModel> register(String email,
      {String? username,
      String? password,
      String? confirmPassword,
      String? captcha}) async {
    var resp = await ApiClient().post("/registerAndLogin", data: {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'confirmCode': captcha,
    });
    return AuthModel.fromJson(resp.data);
  }

  /// Reset Password
  static Future resetPassword(String email,
      {String? username,
      String? password,
      String? confirmPassword,
      String? captcha}) async {
    var resp = await ApiClient().post('/resetPass', data: {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'confirmCode': captcha,
    });
    return resp.data;
  }

  /// Fetch Signup Flow Data Source
  /// types: IdentifyEnum(身份),GenderEnum(性别),BornEnum(出生年月),TallUnitEnum(身高),WeightUnitEnum(体重),PregnantEnum(怀孕),DietEnum(饮食),AllergiesEnum(过敏),GoalsEnum(目标),GastroEnum(肠胃疾病),YesNoEnum(是否),MedicalEnum(其他急病)
  static Future<SignupFlowModel> fetchSignupFlows(List<String> types) async {
    var resp = await ApiClient()
        .get('/enum/list', queryParameters: {'types': types.join(',')});
    return SignupFlowModel.fromJson(resp.data);
  }
}
