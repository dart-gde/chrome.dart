import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/src/socket.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger logger = new Logger("main");
  Logger.root.onRecord.listen((LogRecord r)=>print(r.message.toString()));

  UdpClient client;
  client = new UdpClient("127.0.0.1", 3007);

  client.onData = (ReadInfo readInfo) {
    logger.fine("onData = ${readInfo.resultCode}");
  };

  client.connect().then((connected) {
    logger.fine("connected = $connected");
    client.send("hello!");
  });
}