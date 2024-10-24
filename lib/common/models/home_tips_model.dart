class HomeTipsModel {
  int? id;
  String? isDeleted;
  String? creator;
  String? modifier;
  String? createTime;
  String? modifiyTime;
  int? seq;
  String? tips;
  String? source;
  String? localc;

  HomeTipsModel(
      {this.id,
        this.isDeleted,
        this.creator,
        this.modifier,
        this.createTime,
        this.modifiyTime,
        this.seq,
        this.tips,
        this.source,
        this.localc});

  HomeTipsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDeleted = json['isDeleted'];
    creator = json['creator'];
    modifier = json['modifier'];
    createTime = json['createTime'];
    modifiyTime = json['modifiyTime'];
    seq = json['seq'];
    tips = json['tips'];
    source = json['source'];
    localc = json['localc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['creator'] = this.creator;
    data['modifier'] = this.modifier;
    data['createTime'] = this.createTime;
    data['modifiyTime'] = this.modifiyTime;
    data['seq'] = this.seq;
    data['tips'] = this.tips;
    data['source'] = this.source;
    data['localc'] = this.localc;
    return data;
  }
}
