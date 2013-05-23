import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/src/bluetooth.dart';

void main() {
  final ChromeBluetooth chromeBluetooth = new ChromeBluetooth();

  Logger.root.level = Level.ALL;
  Logger logger = new Logger("main");
  Logger.root.onRecord.listen((LogRecord r)=>print(r.message.toString()));

  //chromeBluetooth.getAdapterState().then((r) {
    ///logger.fine(r);
    chromeBluetooth.getDevices((device) => print("main(): device = $device")
    ).then((_)=>print("getDevices completed"));
  //});

  logger.fine("Hello world");
}