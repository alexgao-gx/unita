import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SignupFlowModel {
  List<EnumModel>? bornEnum;
  List<EnumModel>? identifyEnum;
  List<EnumModel>? allergiesEnum;
  List<EnumModel>? gastroEnum;
  List<EnumModel>? weightUnitEnum;
  List<EnumModel>? pregnantEnum;
  List<EnumModel>? goalsEnum;
  List<EnumModel>? tallUnitEnum;
  List<EnumModel>? yesNoEnum;
  List<EnumModel>? genderEnum;
  List<EnumModel>? dietEnum;
  List<EnumModel>? medicalEnum;
  List<EnumModel>? beverageslEnum;
  List<EnumModel>? bmShapeEnum;
  List<EnumModel>? bmApperanceEnum;
  List<EnumModel>? bmColorEnum;
  List<EnumModel>? bmFeelEnum;
  List<EnumModel>? serverityEnum;
  List<EnumModel>? painSymptomsEnum;
  List<EnumModel>? bloatedSymptomsEnum;
  List<EnumModel>? skinLevelEnum;
  List<EnumModel>? skinLocationEnum;
  List<EnumModel>? skinDescEnum;
  List<EnumModel>? periodLevelEnum;
  List<EnumModel>? periodDescEnum;
  List<EnumModel>? moodLevelEnum;
  List<EnumModel>? stressLevelEnum;
  List<EnumModel>? stressTypeEnum;
  List<EnumModel>? sleepHourEnum;
  List<EnumModel>? sleepFeelEnum;
  List<EnumModel>? workoutEnum;
  List<EnumModel>? dietDurationEnum; // Added
  List<EnumModel>? symptomReductionEnum; // Added

  SignupFlowModel(
      {this.bornEnum,
      this.identifyEnum,
      this.allergiesEnum,
      this.gastroEnum,
      this.weightUnitEnum,
      this.pregnantEnum,
      this.goalsEnum,
      this.tallUnitEnum,
      this.yesNoEnum,
      this.genderEnum,
      this.dietEnum,
      this.medicalEnum,
      this.bmShapeEnum,
      this.beverageslEnum,
      this.bmApperanceEnum,
      this.bmColorEnum,
      this.bmFeelEnum,
      this.serverityEnum,
      this.painSymptomsEnum,
      this.bloatedSymptomsEnum,
      this.skinLevelEnum,
      this.skinDescEnum,
      this.skinLocationEnum,
      this.periodLevelEnum,
      this.periodDescEnum,
      this.moodLevelEnum,
      this.stressLevelEnum,
      this.stressTypeEnum,
      this.sleepHourEnum,
      this.sleepFeelEnum, 
      this.workoutEnum,
      this.dietDurationEnum, // Added
      this.symptomReductionEnum, // Added})
    });

  SignupFlowModel.fromJson(Map<String, dynamic> json) {
    if (json['BornEnum'] != null) {
      bornEnum = <EnumModel>[];
      json['BornEnum'].forEach((v) {
        bornEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['IdentifyEnum'] != null) {
      identifyEnum = <EnumModel>[];
      json['IdentifyEnum'].forEach((v) {
        identifyEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['AllergiesEnum'] != null) {
      allergiesEnum = <EnumModel>[];
      json['AllergiesEnum'].forEach((v) {
        allergiesEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['GastroEnum'] != null) {
      gastroEnum = <EnumModel>[];
      json['GastroEnum'].forEach((v) {
        gastroEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['WeightUnitEnum'] != null) {
      weightUnitEnum = <EnumModel>[];
      json['WeightUnitEnum'].forEach((v) {
        weightUnitEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['PregnantEnum'] != null) {
      pregnantEnum = <EnumModel>[];
      json['PregnantEnum'].forEach((v) {
        pregnantEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['GoalsEnum'] != null) {
      goalsEnum = <EnumModel>[];
      json['GoalsEnum'].forEach((v) {
        goalsEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['TallUnitEnum'] != null) {
      tallUnitEnum = <EnumModel>[];
      json['TallUnitEnum'].forEach((v) {
        tallUnitEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['YesNoEnum'] != null) {
      yesNoEnum = <EnumModel>[];
      json['YesNoEnum'].forEach((v) {
        yesNoEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['GenderEnum'] != null) {
      genderEnum = <EnumModel>[];
      json['GenderEnum'].forEach((v) {
        genderEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['DietEnum'] != null) {
      dietEnum = <EnumModel>[];
      json['DietEnum'].forEach((v) {
        dietEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['MedicalEnum'] != null) {
      medicalEnum = <EnumModel>[];
      json['MedicalEnum'].forEach((v) {
        medicalEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BmShapeEnum'] != null) {
      bmShapeEnum = <EnumModel>[];
      json['BmShapeEnum'].forEach((v) {
        bmShapeEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BeverageslEnum'] != null) {
      beverageslEnum = <EnumModel>[];
      json['BeverageslEnum'].forEach((v) {
        beverageslEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BmApperanceEnum'] != null) {
      bmApperanceEnum = <EnumModel>[];
      json['BmApperanceEnum'].forEach((v) {
        bmApperanceEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BmColorEnum'] != null) {
      bmColorEnum = <EnumModel>[];
      json['BmColorEnum'].forEach((v) {
        bmColorEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BmFeelEnum'] != null) {
      bmFeelEnum = <EnumModel>[];
      json['BmFeelEnum'].forEach((v) {
        bmFeelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['ServerityEnum'] != null) {
      serverityEnum = <EnumModel>[];
      json['ServerityEnum'].forEach((v) {
        serverityEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['PainSymptomsEnum'] != null) {
      painSymptomsEnum = <EnumModel>[];
      json['PainSymptomsEnum'].forEach((v) {
        painSymptomsEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['BloatedSymptomsEnum'] != null) {
      bloatedSymptomsEnum = <EnumModel>[];
      json['BloatedSymptomsEnum'].forEach((v) {
        bloatedSymptomsEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SkinLevelEnum'] != null) {
      skinLevelEnum = <EnumModel>[];
      json['SkinLevelEnum'].forEach((v) {
        skinLevelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SkinDescEnum'] != null) {
      skinDescEnum = <EnumModel>[];
      json['SkinDescEnum'].forEach((v) {
        skinDescEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SkinLocationEnum'] != null) {
      skinLocationEnum = <EnumModel>[];
      json['SkinLocationEnum'].forEach((v) {
        skinLocationEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['PeriodLevelEnum'] != null) {
      periodLevelEnum = <EnumModel>[];
      json['PeriodLevelEnum'].forEach((v) {
        periodLevelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['PeriodDescEnum'] != null) {
      periodDescEnum = <EnumModel>[];
      json['PeriodDescEnum'].forEach((v) {
        periodDescEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['MoodLevelEnum'] != null) {
      moodLevelEnum = <EnumModel>[];
      json['MoodLevelEnum'].forEach((v) {
        moodLevelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['StressLevelEnum'] != null) {
      stressLevelEnum = <EnumModel>[];
      json['StressLevelEnum'].forEach((v) {
        stressLevelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['StressTypeEnum'] != null) {
      stressTypeEnum = <EnumModel>[];
      json['StressTypeEnum'].forEach((v) {
        stressTypeEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SleepHourEnum'] != null) {
      sleepHourEnum = <EnumModel>[];
      json['SleepHourEnum'].forEach((v) {
        sleepHourEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SleepFeelEnum'] != null) {
      sleepFeelEnum = <EnumModel>[];
      json['SleepFeelEnum'].forEach((v) {
        sleepFeelEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['WorkoutEnum'] != null) {
      workoutEnum = <EnumModel>[];
      json['WorkoutEnum'].forEach((v) {
        workoutEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['DietDurationEnum'] != null) {
      dietDurationEnum = <EnumModel>[];
      json['DietDurationEnum'].forEach((v) {
        dietDurationEnum!.add(new EnumModel.fromJson(v));
      });
    }
    if (json['SymptomReductionEnum'] != null) {
      symptomReductionEnum = <EnumModel>[];
      json['SymptomReductionEnum'].forEach((v) {
        symptomReductionEnum!.add(new EnumModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bornEnum != null) {
      data['BornEnum'] = this.bornEnum!.map((v) => v.toJson()).toList();
    }
    if (this.identifyEnum != null) {
      data['IdentifyEnum'] = this.identifyEnum!.map((v) => v.toJson()).toList();
    }
    if (this.allergiesEnum != null) {
      data['AllergiesEnum'] =
          this.allergiesEnum!.map((v) => v.toJson()).toList();
    }
    if (this.gastroEnum != null) {
      data['GastroEnum'] = this.gastroEnum!.map((v) => v.toJson()).toList();
    }
    if (this.weightUnitEnum != null) {
      data['WeightUnitEnum'] =
          this.weightUnitEnum!.map((v) => v.toJson()).toList();
    }
    if (this.pregnantEnum != null) {
      data['PregnantEnum'] = this.pregnantEnum!.map((v) => v.toJson()).toList();
    }
    if (this.goalsEnum != null) {
      data['GoalsEnum'] = this.goalsEnum!.map((v) => v.toJson()).toList();
    }
    if (this.tallUnitEnum != null) {
      data['TallUnitEnum'] = this.tallUnitEnum!.map((v) => v.toJson()).toList();
    }
    if (this.yesNoEnum != null) {
      data['YesNoEnum'] = this.yesNoEnum!.map((v) => v.toJson()).toList();
    }
    if (this.genderEnum != null) {
      data['GenderEnum'] = this.genderEnum!.map((v) => v.toJson()).toList();
    }
    if (this.dietEnum != null) {
      data['DietEnum'] = this.dietEnum!.map((v) => v.toJson()).toList();
    }
    if (this.medicalEnum != null) {
      data['MedicalEnum'] = this.medicalEnum!.map((v) => v.toJson()).toList();
    }
    if (this.bmShapeEnum != null) {
      data['BmShapeEnum'] = this.bmShapeEnum!.map((v) => v.toJson()).toList();
    }
    if (this.beverageslEnum != null) {
      data['BeverageslEnum'] =
          this.beverageslEnum!.map((v) => v.toJson()).toList();
    }
    if (this.bmApperanceEnum != null) {
      data['BmApperanceEnum'] =
          this.bmApperanceEnum!.map((v) => v.toJson()).toList();
    }
    if (this.bmColorEnum != null) {
      data['BmColorEnum'] = this.bmColorEnum!.map((v) => v.toJson()).toList();
    }
    if (this.bmFeelEnum != null) {
      data['BmFeelEnum'] = this.bmFeelEnum!.map((v) => v.toJson()).toList();
    }
    if (this.serverityEnum != null) {
      data['ServerityEnum'] =
          this.serverityEnum!.map((v) => v.toJson()).toList();
    }
    if (this.painSymptomsEnum != null) {
      data['PainSymptomsEnum'] =
          this.painSymptomsEnum!.map((v) => v.toJson()).toList();
    }
    if (this.bloatedSymptomsEnum != null) {
      data['BloatedSymptomsEnum'] =
          this.bloatedSymptomsEnum!.map((v) => v.toJson()).toList();
    }
    if (this.skinLevelEnum != null) {
      data['SkinLevelEnum'] =
          this.skinLevelEnum!.map((v) => v.toJson()).toList();
    }
    if (this.skinDescEnum != null) {
      data['SkinDescEnum'] = this.skinDescEnum!.map((v) => v.toJson()).toList();
    }
    if (this.skinLocationEnum != null) {
      data['SkinLocationEnum'] =
          this.skinLocationEnum!.map((v) => v.toJson()).toList();
    }
    if (this.periodLevelEnum != null) {
      data['PeriodLevelEnum'] =
          this.periodLevelEnum!.map((v) => v.toJson()).toList();
    }
    if (this.periodDescEnum != null) {
      data['PeriodDescEnum'] =
          this.periodDescEnum!.map((v) => v.toJson()).toList();
    }
    if (this.moodLevelEnum != null) {
      data['MoodLevelEnum'] =
          this.moodLevelEnum!.map((v) => v.toJson()).toList();
    }
    if (this.stressLevelEnum != null) {
      data['StressLevelEnum'] =
          this.stressLevelEnum!.map((v) => v.toJson()).toList();
    }
    if (this.stressTypeEnum != null) {
      data['StressTypeEnum'] =
          this.stressTypeEnum!.map((v) => v.toJson()).toList();
    }
    if (this.sleepHourEnum != null) {
      data['SleepHourEnum'] =
          this.sleepHourEnum!.map((v) => v.toJson()).toList();
    }
    if (this.sleepFeelEnum != null) {
      data['SleepFeelEnum'] =
          this.sleepFeelEnum!.map((v) => v.toJson()).toList();
    }
    // if (this.workoutEnum != null) {
    //   data['WorkoutEnum'] = this.workoutEnum!.map((v) => v.toJson()).toList();
    // }
    if (this.dietDurationEnum != null) {
      data['DietDurationEnum'] =
          this.dietDurationEnum!.map((v) => v.toJson()).toList();
    }
    if (this.symptomReductionEnum != null) {
      data['SymptomReductionEnum'] =
          this.symptomReductionEnum!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class EnumModel {
  String? text;
  String? value;
  String? color;
  RxBool isSelected = false.obs;

  EnumModel({this.text, this.value, this.color});

  EnumModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    color = json['color'];
    isSelected.value = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    data['color'] = this.color;
    data['isSelected'] = this.isSelected.value;
    return data;
  }
}
