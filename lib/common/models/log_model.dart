import 'package:get/get.dart';

class LogModel {
  List<BeveragesInfo>? beveragesInfo;
  List<BowelMovementInfo>? bowelMovementInfo;
  List<LogFoodInfo>? logFoodInfo;
  MedInfo? medInfo;
  PeriodInfo? periodInfo;
  SkinInfo? skinInfo;
  SymptomsInfo? symptomsInfo;
  WellnessHealthInfo? wellnessHealthInfo;

  LogModel(
      {this.beveragesInfo,
        this.bowelMovementInfo,
        this.logFoodInfo,
        this.medInfo,
        this.periodInfo,
        this.skinInfo,
        this.symptomsInfo,
        this.wellnessHealthInfo});

  LogModel.fromJson(Map<String, dynamic> json) {
    if (json['beveragesInfo'] != null) {
      beveragesInfo = <BeveragesInfo>[];
      json['beveragesInfo'].forEach((v) {
        beveragesInfo!.add(new BeveragesInfo.fromJson(v));
      });
    }
    if (json['bowelMovementInfo'] != null) {
      bowelMovementInfo = <BowelMovementInfo>[];
      json['bowelMovementInfo'].forEach((v) {
        bowelMovementInfo!.add(new BowelMovementInfo.fromJson(v));
      });
    }
    if (json['logFoodInfo'] != null) {
      logFoodInfo = <LogFoodInfo>[];
      json['logFoodInfo'].forEach((v) {
        logFoodInfo!.add(new LogFoodInfo.fromJson(v));
      });
    }
    medInfo =
    json['medInfo'] != null ? new MedInfo.fromJson(json['medInfo']) : null;
    periodInfo = json['periodInfo'] != null
        ? new PeriodInfo.fromJson(json['periodInfo'])
        : null;
    skinInfo = json['skinInfo'] != null
        ? new SkinInfo.fromJson(json['skinInfo'])
        : null;
    symptomsInfo = json['symptomsInfo'] != null
        ? new SymptomsInfo.fromJson(json['symptomsInfo'])
        : null;
    wellnessHealthInfo = json['wellnessHealthInfo'] != null
        ? new WellnessHealthInfo.fromJson(json['wellnessHealthInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.beveragesInfo != null) {
      data['beveragesInfo'] =
          this.beveragesInfo!.map((v) => v.toJson()).toList();
    }
    if (this.bowelMovementInfo != null) {
      data['bowelMovementInfo'] =
          this.bowelMovementInfo!.map((v) => v.toJson()).toList();
    }
    if (this.logFoodInfo != null) {
      data['logFoodInfo'] = this.logFoodInfo!.map((v) => v.toJson()).toList();
    }
    if (this.medInfo != null) {
      data['medInfo'] = this.medInfo!.toJson();
    }
    if (this.periodInfo != null) {
      data['periodInfo'] = this.periodInfo!.toJson();
    }
    if (this.skinInfo != null) {
      data['skinInfo'] = this.skinInfo!.toJson();
    }
    if (this.symptomsInfo != null) {
      data['symptomsInfo'] = this.symptomsInfo!.toJson();
    }
    if (this.wellnessHealthInfo != null) {
      data['wellnessHealthInfo'] = this.wellnessHealthInfo!.toJson();
    }
    return data;
  }
}

class BeveragesInfo {
  String? beverageCode;
  String? beverageEngName;
  String? beverageName;
  String? logDate;
  String? logTime;
  String? servingSize;

  BeveragesInfo(
      {this.beverageCode,
        this.beverageEngName,
        this.beverageName,
        this.logDate,
        this.logTime,
        this.servingSize});

  BeveragesInfo.fromJson(Map<String, dynamic> json) {
    beverageCode = json['beverageCode'];
    beverageEngName = json['beverageEngName'];
    beverageName = json['beverageName'];
    logDate = json['logDate'];
    logTime = json['logTime'];
    servingSize = json['servingSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beverageCode'] = this.beverageCode;
    data['beverageEngName'] = this.beverageEngName;
    data['beverageName'] = this.beverageName;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    data['servingSize'] = this.servingSize;
    return data;
  }
}

class BowelMovementInfo {
  String? apperance;
  String? color;
  String? createTime;
  String? creator;
  String? feeling;
  int? id;
  String? isDeleted;
  String? logDate;
  String? logTime;
  String? modifier;
  String? modifiyTime;
  int? shape;
  int? tenantId;
  int? userId;

  BowelMovementInfo(
      {this.apperance,
        this.color,
        this.createTime,
        this.creator,
        this.feeling,
        this.id,
        this.isDeleted,
        this.logDate,
        this.logTime,
        this.modifier,
        this.modifiyTime,
        this.shape,
        this.tenantId,
        this.userId});

  BowelMovementInfo.fromJson(Map<String, dynamic> json) {
    apperance = json['apperance'];
    color = json['color'];
    createTime = json['createTime'];
    creator = json['creator'];
    feeling = json['feeling'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    logDate = json['logDate'];
    logTime = json['logTime'];
    modifier = json['modifier'];
    modifiyTime = json['modifiyTime'];
    shape = json['shape'];
    tenantId = json['tenantId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apperance'] = this.apperance;
    data['color'] = this.color;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['feeling'] = this.feeling;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    data['modifier'] = this.modifier;
    data['modifiyTime'] = this.modifiyTime;
    data['shape'] = this.shape;
    data['tenantId'] = this.tenantId;
    data['userId'] = this.userId;
    return data;
  }
}

class LogFoodInfo {
  List<FoodInfo>? foodInfo;
  String? foodMeal;

  LogFoodInfo({this.foodInfo, this.foodMeal});

  LogFoodInfo.fromJson(Map<String, dynamic> json) {
    if (json['foodInfo'] != null) {
      foodInfo = <FoodInfo>[];
      json['foodInfo'].forEach((v) {
        foodInfo!.add(new FoodInfo.fromJson(v));
      });
    }
    foodMeal = json['foodMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodInfo != null) {
      data['foodInfo'] = this.foodInfo!.map((v) => v.toJson()).toList();
    }
    data['foodMeal'] = this.foodMeal;
    return data;
  }
}

class FoodInfo {
  String? foodCode;
  String? foodEngName;
  String? foodName;
  String? foodServingSize;
  String? logDate;
  String? logTime;

  FoodInfo(
      {this.foodCode,
        this.foodEngName,
        this.foodName,
        this.foodServingSize,
        this.logDate,
        this.logTime});

  FoodInfo.fromJson(Map<String, dynamic> json) {
    foodCode = json['foodCode'];
    foodEngName = json['foodEngName'];
    foodName = json['foodName'];
    foodServingSize = json['foodServingSize'];
    logDate = json['logDate'];
    logTime = json['logTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodCode'] = this.foodCode;
    data['foodEngName'] = this.foodEngName;
    data['foodName'] = this.foodName;
    data['foodServingSize'] = this.foodServingSize;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    return data;
  }
}

class MedInfo {
  String? logDate;
  String? logTime;
  List<MedicationModel>? medInfo;

  MedInfo({this.logDate, this.logTime, this.medInfo});

  MedInfo.fromJson(Map<String, dynamic> json) {
    logDate = json['logDate'];
    logTime = json['logTime'];
    if (json['medInfo'] != null) {
      medInfo = <MedicationModel>[];
      json['medInfo'].forEach((v) {
        medInfo!.add(new MedicationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    if (this.medInfo != null) {
      data['medInfo'] = this.medInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicationModel {
  String? code;
  String? engName;
  String? name;
  num? servingSize;

  MedicationModel({this.code, this.engName, this.name, this.servingSize});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    engName = json['engName'];
    name = json['name'];
    servingSize = json['servingSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['engName'] = this.engName;
    data['name'] = this.name;
    data['servingSize'] = this.servingSize;
    return data;
  }
}


class PeriodInfo {
  String? flowDescription;
  int? flowLevel;
  int? id;
  String? logDate;
  String? logTime;

  PeriodInfo(
      {this.flowDescription,
        this.flowLevel,
        this.id,
        this.logDate,
        this.logTime});

  PeriodInfo.fromJson(Map<String, dynamic> json) {
    flowDescription = json['flowDescription'];
    flowLevel = json['flowLevel'];
    id = json['id'];
    logDate = json['logDate'];
    logTime = json['logTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flowDescription'] = this.flowDescription;
    data['flowLevel'] = this.flowLevel;
    data['id'] = this.id;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    return data;
  }
}

class SkinInfo {
  int? conditions;
  String? description;
  int? id;
  String? location;
  String? logDate;
  String? logTime;

  SkinInfo(
      {this.conditions,
        this.description,
        this.id,
        this.location,
        this.logDate,
        this.logTime});

  SkinInfo.fromJson(Map<String, dynamic> json) {
    conditions = json['conditions'];
    description = json['description'];
    id = json['id'];
    location = json['location'];
    logDate = json['logDate'];
    logTime = json['logTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conditions'] = this.conditions;
    data['description'] = this.description;
    data['id'] = this.id;
    data['location'] = this.location;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    return data;
  }
}

class SymptomsInfo {
  int? bloatedServerity;
  String? bloatedSymptoms;
  String? createTime;
  String? creator;
  int? id;
  String? isDeleted;
  String? logDate;
  String? logTime;
  String? modifier;
  String? modifiyTime;
  int? tenantId;
  String? tummyPainLocations;
  int? tummyPainServerity;
  String? tummyPainTypes;
  int? userId;

  SymptomsInfo(
      {this.bloatedServerity,
        this.bloatedSymptoms,
        this.createTime,
        this.creator,
        this.id,
        this.isDeleted,
        this.logDate,
        this.logTime,
        this.modifier,
        this.modifiyTime,
        this.tenantId,
        this.tummyPainLocations,
        this.tummyPainServerity,
        this.tummyPainTypes,
        this.userId});

  SymptomsInfo.fromJson(Map<String, dynamic> json) {
    bloatedServerity = json['bloatedServerity'];
    bloatedSymptoms = json['bloatedSymptoms'];
    createTime = json['createTime'];
    creator = json['creator'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    logDate = json['logDate'];
    logTime = json['logTime'];
    modifier = json['modifier'];
    modifiyTime = json['modifiyTime'];
    tenantId = json['tenantId'];
    tummyPainLocations = json['tummyPainLocations'];
    tummyPainServerity = json['tummyPainServerity'];
    tummyPainTypes = json['tummyPainTypes'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bloatedServerity'] = this.bloatedServerity;
    data['bloatedSymptoms'] = this.bloatedSymptoms;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    data['modifier'] = this.modifier;
    data['modifiyTime'] = this.modifiyTime;
    data['tenantId'] = this.tenantId;
    data['tummyPainLocations'] = this.tummyPainLocations;
    data['tummyPainServerity'] = this.tummyPainServerity;
    data['tummyPainTypes'] = this.tummyPainTypes;
    data['userId'] = this.userId;
    return data;
  }
}

class WellnessHealthInfo {
  int? id;
  String? logDate;
  String? logTime;
  int? moodLevel;
  String? sleepFeeling;
  String? sleepHours;
  String? stressFeeling;
  int? stressLevel;
  List<Workout>? workout;

  WellnessHealthInfo(
      {this.id,
        this.logDate,
        this.logTime,
        this.moodLevel,
        this.sleepFeeling,
        this.sleepHours,
        this.stressFeeling,
        this.stressLevel,
        this.workout});

  WellnessHealthInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logDate = json['logDate'];
    logTime = json['logTime'];
    moodLevel = json['moodLevel'];
    sleepFeeling = json['sleepFeeling'];
    sleepHours = json['sleepHours'];
    stressFeeling = json['stressFeeling'];
    stressLevel = json['stressLevel'];
    if (json['workout'] != null) {
      workout = <Workout>[];
      json['workout'].forEach((v) {
        workout!.add(new Workout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logDate'] = this.logDate;
    data['logTime'] = this.logTime;
    data['moodLevel'] = this.moodLevel;
    data['sleepFeeling'] = this.sleepFeeling;
    data['sleepHours'] = this.sleepHours;
    data['stressFeeling'] = this.stressFeeling;
    data['stressLevel'] = this.stressLevel;
    if (this.workout != null) {
      data['workout'] = this.workout!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workout {
  String? code;
  String? engName;
  String? hours;
  String? name;

  Workout({this.code, this.engName, this.hours, this.name});

  Workout.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    engName = json['engName'];
    hours = json['hours'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['engName'] = this.engName;
    data['hours'] = this.hours;
    data['name'] = this.name;
    return data;
  }
}
