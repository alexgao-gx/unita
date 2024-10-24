class HomeLogInfoModel {
  int? currTimes;
  int? totalTimes;
  int? perTimes;
  num? progress;
  List<HistoryInfo>? historyInfo;
  MindInfo? mindInfo;
  MindInfo? bodyInfo;
  bool? dietFlag;
  bool? herbFlag;

  HomeLogInfoModel(
      {this.currTimes,
        this.totalTimes,
        this.perTimes,
        this.progress,
        this.historyInfo,
        this.mindInfo,
        this.bodyInfo, this.dietFlag, this.herbFlag});

  HomeLogInfoModel.fromJson(Map<String, dynamic> json) {
    currTimes = json['currTimes'];
    totalTimes = json['totalTimes'];
    perTimes = json['perTimes'];
    progress = json['progress'];
    if (json['historyInfo'] != null) {
      historyInfo = <HistoryInfo>[];
      json['historyInfo'].forEach((v) {
        historyInfo!.add(new HistoryInfo.fromJson(v));
      });
    }
    mindInfo = json['mindInfo'] != null
        ? new MindInfo.fromJson(json['mindInfo'])
        : null;
    bodyInfo = json['bodyInfo'] != null
        ? new MindInfo.fromJson(json['bodyInfo'])
        : null;
    dietFlag = json['dietFlag'];
    herbFlag = json['herbFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currTimes'] = this.currTimes;
    data['totalTimes'] = this.totalTimes;
    data['perTimes'] = this.perTimes;
    data['progress'] = this.progress;
    if (this.historyInfo != null) {
      data['historyInfo'] = this.historyInfo!.map((v) => v.toJson()).toList();
    }
    if (this.mindInfo != null) {
      data['mindInfo'] = this.mindInfo!.toJson();
    }
    if (this.bodyInfo != null) {
      data['bodyInfo'] = this.bodyInfo!.toJson();
    }
    data['dietFlag'] = this.dietFlag;
    data['herbFlag'] = this.herbFlag;
    return data;
  }
}

class HistoryInfo {
  String? day;
  num? progress;
  bool? currentDay;
  bool? future;

  HistoryInfo({this.day, this.progress, this.currentDay, this.future});

  HistoryInfo.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    progress = json['progress'];
    currentDay = json['currentDay'];
    future = json['future'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['progress'] = this.progress;
    data['currentDay'] = this.currentDay;
    data['future'] = this.future;
    return data;
  }
}

class MindInfo {
  int? currTimes;
  int? totalTimes;
  int? perTimes;

  MindInfo({this.currTimes, this.totalTimes, this.perTimes});

  MindInfo.fromJson(Map<String, dynamic> json) {
    currTimes = json['currTimes'];
    totalTimes = json['totalTimes'];
    perTimes = json['perTimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currTimes'] = this.currTimes;
    data['totalTimes'] = this.totalTimes;
    data['perTimes'] = this.perTimes;
    return data;
  }
}
