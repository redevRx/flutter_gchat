import 'dart:typed_data';

class GChatModel {
  //defind model
  final String? roomName;
  final String? userId;
  final String? userName;
  final String? messageType;
  final String? messageId;
  final String? itemType;
  final String? message; // or body
  final Uint8List? image;
  final String? sticker;
  final Uint8List? video;
  final String? timestamp;

  GChatModel(
      {this.roomName,
      this.userId,
      this.userName,
      this.messageType,
      this.messageId,
      this.itemType,
      this.message,
      this.image,
      this.sticker,
      this.video,
      this.timestamp});

  ///### MAP JSON
  ///convert this class to map
  ///
  Map toMap() {
    return {
      "room": this.roomName,
      "userId": this.userId,
      "userName": this.userName,
      "messageType": this.messageType,
      "messageId": this.messageId,
      "itemType": this.itemType,
      "message": this.message,
      "image": this.image,
      "sticker": this.sticker,
      "video": this.video,
      "timestamp": this.timestamp
    };
  }

  ///### Comvert Map to this Class
  ///get Data from Map
  factory GChatModel.fromJson(Map json) {
    return GChatModel(
        roomName: json["room"] ?? "",
        userId: json["userId"] ?? "",
        userName: json["userName"] ?? "",
        messageType: json["messageType"] ?? "",
        messageId: json["messageId"] ?? "",
        itemType: json["itemType"] ?? "",
        message: json["message"] ?? "",
        image: json["image"] ?? "",
        sticker: json["sticker"] ?? "",
        video: json["video"] ?? "",
        timestamp: json["timestamp"]);
  }
}
