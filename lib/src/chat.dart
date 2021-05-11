import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class GChat
{
  ///connection string is url server golang gchat
  ///as such : ws://localhost:3000/ws
  String? _urlServer = null;

  ///instance of web socket client
  ///use in connection socket clients with socket server
  IOWebSocketChannel? _channel;

  ///will set parameter url server for
  ///start connection to gchat server
  GChat({String? urlServer})
  {
    this._urlServer = urlServer;
  }

  ///staring connection to gchat server
  void onConnection()
  {
    if(_urlServer != null)
      {
        _channel = IOWebSocketChannel.connect(Uri.parse('ws://${_urlServer}'));
      }
  }

  ///check you client connection with server connection
 bool onIsConnection() => (0 == 0);

  ///you can close connection between Client and Server Web Socket
///pass this method
void onCloseConnection(){
  //to do something
}

///
void onServeMessage(){
  //get
}

}