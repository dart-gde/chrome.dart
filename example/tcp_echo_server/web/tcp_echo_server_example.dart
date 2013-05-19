import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/src/socket.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger logger = new Logger("main");
  Logger.root.onRecord.listen((LogRecord r)=>print(r.message.toString()));

  TcpServer server;
  server = new TcpServer("127.0.0.1", 7765);

  server.onAccept = (TcpClient c, SocketInfo socketInfo) {
    logger.fine("server onAccept of client");
    var paragraphElement = new ParagraphElement();
    paragraphElement.text = "client[${c.socketId}]: server onAccept of client";
    query("#container").children.add(paragraphElement);
  };

  server.receive = (String message, TcpClient client) {
    logger.fine("client[${client.socketId}]: $message");
    var paragraphElement = new ParagraphElement();
    paragraphElement.text = "client[${client.socketId}]: $message";
    query("#container").children.add(paragraphElement);
  };

  server.listen().then((bool isListening) {
    logger.fine("server isListening = ${isListening}");
    var paragraphElement = new ParagraphElement();
    paragraphElement.text = "server isListening = ${isListening}";
    query("#container").children.add(paragraphElement);
  });
}