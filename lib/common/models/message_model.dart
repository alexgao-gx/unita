class MessageModel {
  int? id;
  String? isDeleted;
  String? creator;
  String? modifier;
  String? createTime;
  String? modifiyTime;
  String? title;
  String? content;
  String? source;
  String? localc;

  MessageModel(
      {this.id,
        this.isDeleted,
        this.creator,
        this.modifier,
        this.createTime,
        this.modifiyTime,
        this.title,
        this.content,
        this.source,
        this.localc});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDeleted = json['isDeleted'];
    creator = json['creator'];
    modifier = json['modifier'];
    createTime = json['createTime'];
    modifiyTime = json['modifiyTime'];
    title = json['title'];
    content = json['content'];
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
    data['title'] = this.title;
    data['content'] = this.content;
    data['source'] = this.source;
    data['localc'] = this.localc;
    return data;
  }
}
