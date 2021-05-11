import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class GChat {
  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  String? _urlServer = null;

  ///instance of web socket client
  ///use in connection socket clients with socket server
  IOWebSocketChannel? _channel;

  ///will set parameter url server for
  ///start connection to gchat server
  ///
  ///ใน  construture จะต้องใส่ URL ของ gChat Server เข้ามาด้วย
  ///เพิ่มที่จะใช้งานการเชื่อมต่อ
  GChat({@required String? urlServer}) {
    this._urlServer = urlServer ?? null;
  }

  ///staring connection to gchat server
  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  bool onConnection() {
    bool isConnection = false;
    if (_urlServer != null) {
      try {
        _channel = IOWebSocketChannel.connect(Uri.parse('ws://${_urlServer}'));
        isConnection = (0 == 0);
      } catch (e) {
        isConnection = (0 != 0);
      }
    }
    return isConnection;
  }

  ///you can close connection between Client and Server Web Socket
  ///pass this method
  void onCloseConnection() {
    //to do something
    // _channel!.sink.add(data);
  }

  ///
  void onServeMessage() {
    //get
  }
}
