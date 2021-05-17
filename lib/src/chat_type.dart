enum ChatType {
  ///### TypeMessage
  ///use for check user send data as what type
  ///as such : message video sticker other that supports
  ///
  /// ใช้สำหรับตรวจสอบชนิดข้อมูลของ chat ที่ถูกส่งระหว่าง Client กับ Server
  /// ว่าเป็นชนิดอะไร เช่น ข้อความ เสียง วีดีโอะ ประมาณนี้
  ///
  TypeMessage,

  ///### TypeRoom
  /// if will starting chat will want create room
  /// by set messageType as [*typeRoom] and it will create room for you
  ///
  /// ถ้าต้องการ chat จะต้องสร้างห้อง chat ก่อนโดย typeRoom จะเป็นตัวบอกให้ Server รู้ว่าต้องเริ่มสร้างห้อง
  /// แล้วกำหนด messageType เป็น typeRoom
  ///
  TypeRoom,

  ///### TypeCloseConnection
  /// if call type is will request to server for close connection with server
  /// you will want set messageType as [*TypeCloseConnection]
  ///
  /// ถ้าส่งข้อมูลชนิดนี้ไปถ้า server จะปิดการปิดการเชื่อมต่อกับ server
  ///  กำหนด messageType เป็น TypeCloseConnection
  ///
  TypeCloseConnection,

  ///### TypeLeaveRoom
  /// if leave room you will want call this type and send to server
  /// server will close you from room by set messageType as [*TypeLeaveRoom]
  ///
  /// ถ้าต้องการออกจากห้อง chat ให้ส่งชนิดข้อมูล chat เป็นตัวนี้แล้ว server จะตัดการเชื่อมต่อกับห้อง chat
  /// กำหนด messageType เป็น TypeLeaveRoom
  ///
  TypeLeaveRoom,

  ///### TypeJoinChannel
  /// JoinChannel is when you want that will call video call with friends
  /// you will want create channel call by set messageType as [*TypeJoinChannel]
  ///
  /// ถ้าต้องการเริ่มการโทรสนทนาจะต้องสร้าง channel ก่อน โดยกำหนด messageType เป็น TypeJoinChannel
  ///
  TypeJoinChannel,

  ///### TypeLeaveChannel
  /// while that you calling with friend and you want end call
  /// you can set messageType as TypeLeaveChannel
  ///
  /// ในขณะที่คุยเราสามารถกดวางสายได้โดยการ กำหนด messageType เป็น [*TypeLeaveChannel]
  ///
  TypeLeaveChannel,

  ///### TypeCallOffer
  /// side call gChat server will use WenRTC in call between client and client
  /// by that client will create offer and send it to friend that will call
  /// and you will wait offer of friend by set messageType as [*TypeCallOffer]
  ///
  /// ในการโทรสนทนา gChat Server จะใช้งาน WebRTC เป็นตัวช่วยในการติดต่อสื่อสารระหว่าง
  /// ผู้ใช้งาน ทั่งผู้โทรออกและผู้รับสาย โดยทั่งสองฝั่งจะต้องทำการสร้าง offer แล้วส่งให้อีกสาย
  /// โดยการ กำหนด messageType เป็น TypeCallOffer
  ///
  TypeCallOffer,

  ///### TypeCallAnswer
  /// side call sender client and receive client will want create answer and send to both
  /// by set messageType as [*TypeCallAnswer]
  ///
  /// ในการโทรทั่งผู้โทรออกและผู้รับสายจะต้องสร้าง answer เพื่มบอกให้อีกฝ่ายรับการเชื่อมต่อการโทร
  /// โดยการ กำหนด messageType เป็น TypeCallAnswer
  ///
  TypeCallAnswer,

  ///### TypeGetMessage
  /// this type : if call it server will send all chat message between you with friend in room
  /// by set messageType as [*TypeGetMessage]
  ///
  /// ถ้าต้องการรับประวัติการสนทนาให้เรียกใช้ ข้อมูลชนิดนี้
  /// โดยการ กำหนด messageType เป็น TypeGetMessage
  ///
  TypeGetMessage,

  ///### ItemTypeMessage
  ///defind item type
  ///item type is when client send message to server and server
  ///will check message it is ? such as: text image sticker or video
  ///
  /// ในการส่งข้อมูล chat นอกจาก  messageType แล้วยังต้องกำหนด type ของข้อมูล
  /// ที่เราต้องการจะส่งด้วย เช่น รูป วีดีโอะ
  ///
  ItemTypeMessage,

  ///### ItemTypeImage
  ///defind item type
  ///item type is when client send message to server and server
  ///will check message it is ? such as: text image sticker or video
  ///
  /// ในการส่งข้อมูล chat นอกจาก  messageType แล้วยังต้องกำหนด type ของข้อมูล
  /// ที่เราต้องการจะส่งด้วย เช่น รูป วีดีโอะ
  ///
  ItemTypeImage,

  ///### ItemTypeSticker
  ///defind item type
  ///item type is when client send message to server and server
  ///will check message it is ? such as: text image sticker or video
  ///
  /// ในการส่งข้อมูล chat นอกจาก  messageType แล้วยังต้องกำหนด type ของข้อมูล
  /// ที่เราต้องการจะส่งด้วย เช่น รูป วีดีโอะ
  ///
  ItemTypeSticker,

  ///### ItemTypeVideo
  ///defind item type
  ///item type is when client send message to server and server
  ///will check message it is ? such as: text image sticker or video
  ///
  /// ในการส่งข้อมูล chat นอกจาก  messageType แล้วยังต้องกำหนด type ของข้อมูล
  /// ที่เราต้องการจะส่งด้วย เช่น รูป วีดีโอะ
  ///
  ItemTypeVideo,
}

extension ChatTypeExtension on ChatType {
  String? get getType {
    switch (this) {
      case ChatType.TypeRoom:
        //
        return "";
      default:
        return null;
    }
  }
}
