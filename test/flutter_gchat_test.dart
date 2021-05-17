import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gchat/gchat.dart';

void main() async {
  final gchat = new GChat(urlServer: "ws://192.168.1.37:3000/ws");

//test connection
  test("test connection to server ws", () async {
    expect(gchat.onSoundServer(), (0 == 0));
    expect(gchat.unSoundServer(), (0 != 0));
  });

  //uid test
  test("get uid text", () async {
    expect(await gchat.onSoundUID(), await gchat.onSoundUID());
  });

  //test send message
  test("send message and get message", () async {
    expect(
        gchat.onSendText(
            room: "mk", userId: await gchat.onSoundUID(), userName: "nk"),
        (0 != 0));
    //
  });
}
