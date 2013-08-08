import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/src/bluetooth.dart';

void main() {
  final ChromeBluetooth chromeBluetooth = new ChromeBluetooth();

  Logger.root.level = Level.ALL;
  Logger logger = new Logger("main");
  Logger.root.onRecord.listen((LogRecord r)=>print(r.message.toString()));
  DivElement d = query("#d");
  UListElement ul = new UListElement();
  d.children.add(ul);

  chromeBluetooth.getDevices((Device device) =>
      ul.children.add(new LIElement()..text = device.toString()))
      .then((_)=>ul.children.add(new LIElement()..text = "getDevices Done"));
}