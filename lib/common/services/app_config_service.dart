

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

import '../api/auth_api.dart';
enum SignUpFlowsType {
  IdentifyEnum, // (身份)
  GenderEnum, // (性别)
  BornEnum, // (出生年月)
  TallUnitEnum, //(身高)
  WeightUnitEnum, // (体重)
  PregnantEnum, // (怀孕)
  DietEnum, // (饮食)
  AllergiesEnum, // (过敏)
  GoalsEnum, // (目标)
  GastroEnum, // (肠胃疾病)
  YesNoEnum, // (是否)
  MedicalEnum // (其他急病)
}

class AppConfigService extends GetxService {
  final Rx<SignupFlowModel> _signupFlow =
      SignupFlowModel().obs;
  /// App Signup Flow Data Source
  SignupFlowModel get signupFlow => _signupFlow.value;

  Future<void> fetchConfigs() async {
    await _fetchSignupFlows();
  }

  Future<void> _fetchSignupFlows() async {
    _signupFlow.value = await AuthAPI.fetchSignupFlows(
        SignUpFlowsType.values.map((v) => v.name).toList());
  }

}
