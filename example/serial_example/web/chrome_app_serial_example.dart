import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
// JS: for (var i =0; i < 100; i++) chrome.serial.close(i, function (f) { console.log(f); });
void main() {
  Logger.root.level = Level.ALL;
  Logger logger = new Logger("main");
  Logger.root.onRecord.listen((LogRecord r)=>print(r.message.toString()));

  SelectElement selectElement = query("#serialPorts");

  Serial.ports.then((result) {
    logger.fine("getPorts = ${result}");
    logger.fine("getPorts = ${result.runtimeType}");
    result.forEach((port) {
      logger.fine("port = ${port} , ${port.runtimeType}");

      OptionElement optionElement = new OptionElement();
      optionElement.value = port;
      optionElement.text = port;
      selectElement.append(optionElement);
    });
  });

  Serial serial;

  query("#openSerial")
  ..onClick.listen((Event event) {
    // TODO(adam) fix speed here to input element or drop down.
    serial = new Serial(selectElement.value, 9600);
    serial.open().then((result) {
      serial.onRead = (String str) {
        ParagraphElement p = new ParagraphElement();
        p.text = str;
        DivElement container = query("#container");
        container.children.add(p);
        container.scrollTop = container.scrollHeight;
      };

      serial.startListening();
    });
  });

  query("#ping")
  ..onClick.listen((Event event) {
    String data = (query("#pingData") as InputElement).value;
    logger.fine("data ${data}");
    serial.write("${data}\n").then((result) {
      logger.fine("serial.write ${result.bytesWritten}");
    });
  });
}



