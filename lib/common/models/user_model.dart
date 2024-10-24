/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

class UserModel {
  String? allergies;
  String? birth;
  int? coin;
  String? createTime;
  String? creator;
  String? diet;
  String? email;
  String? gastrointestinal;
  String? gender;
  String? goals;
  String? headImg;
  int? id;
  String? identify;
  String? isDeleted;
  String? medical;
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

  UserModel(
      {this.allergies,
        this.birth,
        this.coin,
        this.createTime,
        this.creator,
        this.diet,
        this.email,
        this.gastrointestinal,
        this.gender,
        this.goals,
        this.headImg,
        this.id,
        this.identify,
        this.isDeleted,
        this.medical,
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
        this.weightUnit});

  UserModel.fromJson(Map<String, dynamic> json) {
    allergies = json['allergies'];
    birth = json['birth'];
    coin = json['coin'];
    createTime = json['createTime'];
    creator = json['creator'];
    diet = json['diet'];
    email = json['email'];
    gastrointestinal = json['gastrointestinal'];
    gender = json['gender'];
    goals = json['goals'];
    headImg = json['headImg'];
    id = json['id'];
    identify = json['identify'];
    isDeleted = json['isDeleted'];
    medical = json['medical'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allergies'] = this.allergies;
    data['birth'] = this.birth;
    data['coin'] = this.coin;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['diet'] = this.diet;
    data['email'] = this.email;
    data['gastrointestinal'] = this.gastrointestinal;
    data['gender'] = this.gender;
    data['goals'] = this.goals;
    data['headImg'] = this.headImg;
    data['id'] = this.id;
    data['identify'] = this.identify;
    data['isDeleted'] = this.isDeleted;
    data['medical'] = this.medical;
    data['modifier'] = this.modifier;
    data['modifiyTime'] = this.modifiyTime;
    data['otherMedical'] = this.otherMedical;
    data['password'] = this.password;
    data['pregnant'] = this.pregnant;
    data['tall'] = this.tall;
    data['tallUnit'] = this.tallUnit;
    data['tenantId'] = this.tenantId;
    data['username'] = this.username;
    data['weight'] = this.weight;
    data['weightUnit'] = this.weightUnit;
    return data;
  }
}
