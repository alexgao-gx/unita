import 'log_model.dart';

class LogReqModel {
  FoodInfoReqModel? foodInfo;
  BowelMovementInfo? bowelMovementInfo;
  List<BeveragesInfo>? beveragesInfo;
  SymptomsInfo? symptomsInfo;
  SkinInfo? skinInfo;
  MedicationInfoReqModel? medicationInfo;
  PeriodInfo? periodInfo;
  WellnessHealthInfo? wellnessHealthInfo;
  String? logType;
  String? userId;

  LogReqModel(
      {this.userId, // Include userId in constructor
      this.foodInfo,
      this.bowelMovementInfo,
      this.beveragesInfo,
      this.symptomsInfo,
      this.skinInfo,
      this.medicationInfo,
      this.periodInfo,
      this.wellnessHealthInfo,
      this.logType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId; // Include userId in toJson
    if (this.foodInfo != null) {
      data['foodInfo'] = this.foodInfo!.toJson();
    }
    if (this.bowelMovementInfo != null) {
      data['bowelMovementInfo'] = this.bowelMovementInfo!.toJson();
    }
    if (this.beveragesInfo != null) {
      data['beveragesInfo'] =
          this.beveragesInfo!.map((v) => v.toJson()).toList();
    }
    if (this.symptomsInfo != null) {
      data['symptomsInfo'] = this.symptomsInfo!.toJson();
    }
    if (this.skinInfo != null) {
      data['skinInfo'] = this.skinInfo!.toJson();
    }
    if (this.medicationInfo != null) {
      data['medInfo'] = this.medicationInfo!.toJson();
    }
    if (this.periodInfo != null) {
      data['periodInfo'] = this.periodInfo!.toJson();
    }
    if (this.wellnessHealthInfo != null) {
      data['wellnessHealthInfo'] = this.wellnessHealthInfo!.toJson();
    }
    data['logType'] = this.logType;
    return data;
  }
}

class FoodInfoReqModel {
  List<FoodInfo>? breakfastFoodInfo;
  List<FoodInfo>? lunchFoodInfo;
  List<FoodInfo>? dinnerFoodInfo;
  List<FoodInfo>? snackFoodInfo;

  FoodInfoReqModel(
      {this.breakfastFoodInfo,
      this.lunchFoodInfo,
      this.dinnerFoodInfo,
      this.snackFoodInfo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakfastFoodInfo != null) {
      data['B'] = this.breakfastFoodInfo!.map((v) => v.toJson()).toList();
    }
    if (this.lunchFoodInfo != null) {
      data['L'] = this.lunchFoodInfo!.map((v) => v.toJson()).toList();
    }
    if (this.dinnerFoodInfo != null) {
      data['D'] = this.dinnerFoodInfo!.map((v) => v.toJson()).toList();
    }
    if (this.snackFoodInfo != null) {
      data['S'] = this.snackFoodInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicationInfoReqModel {
  String? logDate;
  String? logTime;
  List<MedicationModel>? medicationInfo;

  MedicationInfoReqModel({this.logDate, this.logTime, this.medicationInfo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    if (this.medicationInfo != null) {
      data['medInfo'] = this.medicationInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
