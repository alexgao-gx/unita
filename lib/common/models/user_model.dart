class UserModel {
  String? allergies;
  String? birth;
  int? coin;
  String? createTime;
  String? creator;
  String? diet;
  String? dietDuration; // Added field
  String? email;
  String? gastrointestinal;
  String? gender;
  String? goals;
  String? headImg;
  int? userId;
  String? identify;
  String? isDeleted;
  String? medical;
  String? symptomReduction; // Added field
  String? modifier;
  String? modifiyTime;
  String? otherMedical;
  String? password;
  String? pregnant;
  String? tall;
  String? tallUnit;
  int? tenantId;
  String? username;
  String? weight;
  String? weightUnit;

  UserModel({
    this.allergies,
    this.birth,
    this.coin,
    this.createTime,
    this.creator,
    this.diet,
    this.dietDuration, // Added parameter
    this.email,
    this.gastrointestinal,
    this.gender,
    this.goals,
    this.headImg,
    this.userId,
    this.identify,
    this.isDeleted,
    this.medical,
    this.symptomReduction, // Added parameter
    this.modifier,
    this.modifiyTime,
    this.otherMedical,
    this.password,
    this.pregnant,
    this.tall,
    this.tallUnit,
    this.tenantId,
    this.username,
    this.weight,
    this.weightUnit,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    allergies = json['allergies'];
    birth = json['birth'];
    coin = json['coin'];
    createTime = json['createTime'];
    creator = json['creator'];
    diet = json['diet'];
    dietDuration = json['dietDuration']; // Parse from JSON
    email = json['email'];
    gastrointestinal = json['gastrointestinal'];
    gender = json['gender'];
    goals = json['goals'];
    headImg = json['headImg'];
    userId = json['userId'];
    identify = json['identify'];
    isDeleted = json['isDeleted'];
    medical = json['medical'];
    symptomReduction = json['symptomReduction']; // Parse from JSON
    modifier = json['modifier'];
    modifiyTime = json['modifiyTime'];
    otherMedical = json['otherMedical'];
    password = json['password'];
    pregnant = json['pregnant'];
    tall = json['tall'];
    tallUnit = json['tallUnit'];
    tenantId = json['tenantId'];
    username = json['username'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allergies'] = allergies;
    data['birth'] = birth;
    data['coin'] = coin;
    data['createTime'] = createTime;
    data['creator'] = creator;
    data['diet'] = diet;
    data['dietDuration'] = dietDuration; // Added to JSON
    data['email'] = email;
    data['gastrointestinal'] = gastrointestinal;
    data['gender'] = gender;
    data['goals'] = goals;
    data['headImg'] = headImg;
    data['userId'] = userId;
    data['identify'] = identify;
    data['isDeleted'] = isDeleted;
    data['medical'] = medical;
    data['symptomReduction'] = symptomReduction; // Added to JSON
    data['modifier'] = modifier;
    data['modifiyTime'] = modifiyTime;
    data['otherMedical'] = otherMedical;
    data['password'] = password;
    data['pregnant'] = pregnant;
    data['tall'] = tall;
    data['tallUnit'] = tallUnit;
    data['tenantId'] = tenantId;
    data['username'] = username;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    return data;
  }
}
