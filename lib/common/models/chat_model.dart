class ChatModel {
  late String? sendMsg;
  late String? timStr;
  late bool isSending;
  late String? receiveMsg;
  late bool isHiMsg;
  ChatModel({
    required this.sendMsg,
    required this.timStr,
    required this.isSending,
    required this.receiveMsg,
    required this.isHiMsg,
  });
}
