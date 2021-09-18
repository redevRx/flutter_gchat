import 'dart:math';
import 'package:flutter_gchat/gchat.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GChat {
  ///const key
  final UID = "userId";

  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  String? _urlServer;

  ///instance of web socket client
  ///use in connection socket clients with socket server
  IOWebSocketChannel? _channel;

  ///instance of web socket client
  ///use in connection socket clients with socket server
  WebSocketChannel? _channelWeb;

  ///will set parameter url server for
  ///start connection to gchat server
  ///
  ///ใน  construture จะต้องใส่ URL ของ gChat Server เข้ามาด้วย
  ///เพิ่มที่จะใช้งานการเชื่อมต่อ
  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  GChat({required String? urlServer}) {
    this._urlServer = urlServer ?? null;
  }

  ///### Connection to Server
  ///staring connection to gchat server
  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  ///
  ///หากต้องการเชื่อมต่อกับ server ให้เรียกใช้งาน method นี้
  ///เพื่อเริ่มการใช้งานระบบ chat
  ///
  ///### Example
  ///```dart
  ///final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");
  ///final isConnect = gchat.onSoundServer();
  ///if(isConnect);
  ///   {
  ///print("connect success");
  ///   }
  ///```
  bool onSoundServer() {
    bool isConnection = false;
    if (_urlServer != null) {
      try {
        switch (kIsWeb) {
          case kIsWeb:
            _channelWeb = WebSocketChannel.connect(Uri.parse('$_urlServer'));
            break;
          default:
            _channel = IOWebSocketChannel.connect(Uri.parse('$_urlServer'));
            break;
        }
        isConnection = (0 == 0);
      } catch (e) {
        isConnection = (0 != 0);
        print("connection to server error :$e");
      }
    }
    return isConnection;
  }

  ///### Close Connection
  ///you can close connection between Client and Server Web Socket
  ///pass this method
  ///
  ///ถ้าไม่ใช้งาน chat แล้วสามารถที่จะปิดการเชื่อมต่อในการทำงานได้
  ///โดยการเรียกใช้งาน method นี้
  ///
  ///### Example
  ///``` dart
  ///final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");
  ///final isClose = gchat.unSoundServer();
  ///if(isClose)
  ///{
  /// do something
  ///}
  ///```
  bool unSoundServer({String? userName, String? userId}) {
    bool isClose = false;
    try {
      //for web
      if (kIsWeb) {
        _channelWeb!.sink.add(new ChatModel(
            roomName: "",
            userName: userName,
            userId: userId,
            messageType: ChatType.TypeCloseConnection.getType));
        _channelWeb!.sink.close();
        isClose = (0 == 0);
      } else {
        //for mobile
        _channel!.sink.add(new ChatModel(
            roomName: "",
            userName: userName,
            userId: userId,
            messageType: ChatType.TypeCloseConnection.getType));
//
        _channel!.sink.close();
        isClose = (0 == 0);
      }
    } catch (e) {
      print("$e");
      isClose = (0 != 0);
    }

    return isClose;
  }

  List<List<ChatModel>> _modelChat = [[]];
  List<ChatModel> _itemsChat = [];

  ///### Get Message that Send Between user
  ///will return all message
  ///
  ///ถ้าเรียก method นี้จะส่งข้อความทั่งหมดมาให้
  ///
  ///``` dart
  ///final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");
  ///StreamBuilder<GChatModel>(
  ///   stream: gchat.onSoundChat,
  ///   builder: (context, snapshot) {
  ///   return Text("${snapshot.data.message}");
  /// },)
  ///```
  Stream<List<ChatModel>> onSoundChat() {
    final controllerChat = BehaviorSubject<List<ChatModel>>();
    if (kIsWeb) {
      _channelWeb!.stream.listen((it) {
        // loop get data
        it.values.foreach((va) {
          _itemsChat.add(ChatModel.fromJson(it));
        });

        ///
        controllerChat
          ..sink
          ..add(_itemsChat);
      });
    }
    else {
      _channel!.stream.listen((it) {
        // loop get data
        it.values.foreach((va) {
          _itemsChat.add(ChatModel.fromJson(it));
        });

        ///
        controllerChat
          ..sink
          ..add(_itemsChat);
      });
    }

    return controllerChat.stream;
  }

  ///### Request Get All Message
  ///while app loading ui screen if you get all chat by use this method
  ///for get all message before start chat for load history chat
  ///
  ///ถ้าเรียก method นี้จะส่งข้อความทั่งหมดมาให้ ประวัติการแชท
  ///
  ///### Example
  ///``` dart
  ///final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");
  ///gchat.onSoundAllMessage();
  ///StreamBuilder<GChatModel>(
  ///   stream: gchat.onSoundChat,
  ///   builder: (context, snapshot) {
  ///   return Text("${snapshot.data.message}");
  /// },)
  ///```
  void onSoundAllMessage({String? room, String? name}) {
    if (kIsWeb) {
      _channelWeb!.sink.add(new ChatModel(
              roomName: room,
              userName: name,
              messageType: ChatType.TypeGetMessage.getType)
          .toMap());
    } else {
      //for mobile
      _channel!.sink.add(new ChatModel(
              roomName: room,
              userName: name,
              messageType: ChatType.TypeGetMessage.getType)
          .toMap());
    }
  }

  ///### Send Item Type Text
  ///if want send message to friend if call this method
  ///
  ///ถ้าต้องการส่งข้อความให้เรียกใช้งาน method นี้ เพื่อเริ่มต้นการส่งข้อความ
  ///
  ///### Example
  ///``` dart
  ///final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");
  ///await gchat.onCraeteUID() => this mabye return "you already uid" if solve by use
  ///final uid = await gchat.onSoundUID();
  ///gchat.onSendText(message:"HI",room:"rmu",userName:"naked snake",userId: uid);
  ///```
  bool onSendText(
      {String? message, String? room, String? userName, String? userId}) {
    try {
      if (kIsWeb) {
        _channelWeb!.sink.add(new ChatModel(
                roomName: room,
                message: message,
                itemType: ChatType.ItemTypeMessage.getType,
                userName: userName,
                messageType: ChatType.TypeMessage.getType,
                userId: userId,
                messageId: "${onSoundUID()}-message-id")
            .toMap());

        return (0 == 0);
      } else {
        _channel!.sink.add(new ChatModel(
                roomName: room,
                message: message,
                itemType: ChatType.ItemTypeMessage.getType,
                userName: userName,
                messageType: ChatType.TypeMessage.getType,
                userId: userId,
                messageId: "${onSoundUID()}-message-id")
            .toMap());
        return (0 == 0);
      }
    } catch (e) {
      print(e);
      return (0 != 0);
    }
  }

  ///
  ///### create new user Id
  ///when create success this method will return string uid
  ///when want use this uid again if call method getUID
  ///if uid already will return already uid
  ///
  ///การสร้างรหัสผู้ใช้งาน จะสามารถสร้างได้ 1 ครั่งเท่านี้น
  ///ถ้าสร้างซำ้คุณจะได้รับ  alread uid
  ///
  ///### Example
  /// ```dart
  ///final gchat = new GChat();
  ///final uuid = await gchat.onCraeteUID();
  ///print(uuid);
  /// ```
  Future<String> onCreateUID() async {
    final Random _random = Random();
    final shared = await SharedPreferences.getInstance();

    /// Generate a version 4 (random) uuid. This is a uuid scheme that only uses
    /// random numbers as the source of the generated uuid.

    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);
    String _printDigits(int value, int count) =>
        value.toRadixString(16).padLeft(count, '0');
    String _bitsDigits(int bitCount, int digitCount) =>
        _printDigits(_generateBits(bitCount), digitCount);
    String? uid;

    if (shared.getString(UID)!.isEmpty) {
      uid = '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
          '${_bitsDigits(16, 4)}-'
          '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
          '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
      await shared.setString(UID, uid);
    }
    return uid ?? shared.getString(UID)!;
  }

  ///### get user id
  ///will return uid that generation from method onCraeteUID
  ///
  ///รับ uid ที่สร้างใว้แล้ว
  ///
  ///### Example
  /// ```dart
  /// final gchat = new GChat();
  /// final uuid = await gchat.onSoundUID();
  /// print("${uuid}");
  /// ```
  Future<String?> onSoundUID() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(UID) ?? await this.onCreateUID();
  }

  ///### Create new Room
  ///when want satrt chat with friend
  ///you will create chat room by use parameter
  ///[roomname , userName , userId , type]
  ///
  ///สร้างห้องสนทนา
  ///
  ///### Example
  ///``` dart
  ///final gchat = new GChat();
  ///await gchat.onCraeteUID();
  ///final uid = await gchat.getUID();
  ///gchat.onSoundRoom(room:"rmu",userName:"naked snake",userId:uid,)
  ///```
  void onSoundRoom({String? room, String? userName, String? userId}) {
    if (kIsWeb) {
      _channelWeb!.sink.add(new ChatModel(
              roomName: room,
              userName: userName,
              userId: userId,
              messageType: ChatType.TypeRoom.getType)
          .toMap());
    } else {
      _channel!.sink.add(new ChatModel(
              roomName: room,
              userName: userName,
              userId: userId,
              messageType: ChatType.TypeRoom.getType)
          .toMap());
    }
  }

  ///### Leave Room
  ///if you close screen if leave room
  ///for use memory low
  ///
  ///ออกจากห้องสนทนา
  ///
  ///### Example
  ///``` dart
  ///final gChat = new GChat();
  ///gChat.unSoundRoom();
  ///```
  void unSoundRoom({String? userName, String? room}) {
    if (kIsWeb) {
      _channelWeb!.sink.add(new ChatModel(
              messageType: ChatType.TypeLeaveRoom.getType,
              roomName: room,
              userName: userName)
          .toMap());
    }
    else {
      _channel!.sink.add(new ChatModel(
              messageType: ChatType.TypeLeaveRoom.getType,
              roomName: room,
              userName: userName)
          .toMap());
    }
  }
}
