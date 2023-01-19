class MsgModel {
  bool? incoming;
  String? dateTime;
  String? msgText;
  String? senderId;
  String? receiverId;
  String? msgId;

  MsgModel({
    this.incoming = true,
    this.senderId,
    this.receiverId,
    this.msgId,
    this.msgText,
    this.dateTime,
  });

  factory MsgModel.fromJson(json) {
    MsgModel msg = MsgModel(
      incoming: json['incoming'],
      dateTime: json['dateTime'],
      msgText: json['msgText'],
      senderId: json['senderId'],
      msgId: json['msgId'],
      receiverId: json['receiverId'],
    );

    return msg;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['incoming'] = incoming;
    data['dateTime'] = dateTime;
    data['msgText'] = msgText;
    data['senderId'] = senderId;
    data['msgId'] = msgId;
    data['receiverId'] = receiverId;

    return data;
  }
}
