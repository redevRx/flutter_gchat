import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_gchat/flutter_gchat.dart';

void main() {
  test("test connection to server ws", () {
    final gchat = new GChat(urlServer: "192.168.1.37:3000/ws");
    expect(gchat.onConnection(), (0 == 0));
  });
}
