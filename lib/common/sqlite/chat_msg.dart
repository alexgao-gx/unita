const String tableNotes = 'chatmsg';

class ChatMsgFields {
  static final List<String> values = [
    /// Add all fields
    id, sendMsg, createdTime, isSending, receiveMsg, isHiMsg
  ];

  static const String id = '_id';
  static const String sendMsg = 'sendMsg';
  static const String createdTime = 'createdTime';
  static const String isSending = 'isSending';
  static const String receiveMsg = 'receiveMsg';
  static const String isHiMsg = 'isHiMsg';
}

class ChatMsg {
  final int? id;
  final String sendMsg;
  final int createdTime;
  final int isSending;
  final String receiveMsg;
  final int isHiMsg;

  const ChatMsg({
    this.id,
    required this.isSending,
    required this.isHiMsg,
    required this.sendMsg,
    required this.receiveMsg,
    required this.createdTime,
  });

  ChatMsg copy({
    int? id,
    int? isSending,
    int? isHiMsg,
    String? sendMsg,
    String? receiveMsg,
    int? createdTime,
  }) =>
      ChatMsg(
        id: id ?? this.id,
        isSending: isSending ?? this.isSending,
        isHiMsg: isHiMsg ?? this.isHiMsg,
        sendMsg: sendMsg ?? this.sendMsg,
        receiveMsg: receiveMsg ?? this.receiveMsg,
        createdTime: createdTime ?? this.createdTime,
      );

  static ChatMsg fromJson(Map<String, Object?> json) => ChatMsg(
        id: json[ChatMsgFields.id] as int?,
        isSending: json[ChatMsgFields.isSending] as int,
        isHiMsg: json[ChatMsgFields.isHiMsg] as int,
        sendMsg: json[ChatMsgFields.sendMsg] as String,
        receiveMsg: json[ChatMsgFields.receiveMsg] as String,
        createdTime: json[ChatMsgFields.createdTime] as int,
      );

  Map<String, Object?> toJson() => {
        ChatMsgFields.id: id,
        ChatMsgFields.isSending: isSending,
        ChatMsgFields.sendMsg: sendMsg,
        ChatMsgFields.createdTime: createdTime,
        ChatMsgFields.receiveMsg: receiveMsg,
        ChatMsgFields.isHiMsg: isHiMsg,
      };
}
