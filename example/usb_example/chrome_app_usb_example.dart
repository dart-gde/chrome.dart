import 'dart:html';
import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
import 'package:chrome/src/usb.dart';

class Soldier {
  FindDevicesOptions props;
  String name;

  Soldier(this.props, this.name);
}

void main() {
  Logger logger = new Logger("main");

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) => window.console.log(r.message.toString()));


  Element adbDevices = query('#adb-devices');


  // They come marching one-by-one hurrah....
  var army = [
    new Soldier(new FindDevicesOptions(0x04e8, 0x6860), "Galaxy Nexus")
  ];

  adbDevices.children.clear();

  int done = -1;

  void tenHut(int i) {
    if(i > army.length) {
      return;
    }

    if(i <= done) { 
      return;
    }

    var soldier = army[i];

    window.console.log("Looking for ${soldier.name}");

    Usb.findDevices(soldier.props).then(
    (result) {
      window.console.log(result);

      if(result.length > 0) {
        LIElement devElem = new LIElement();

        if(result.length > 1) {
          devElem.text = "${soldier.name} (x${result.length})";
        } else {
          devElem.text = soldier.name;
        }

        adbDevices.append(devElem);

        done = i;

        result.forEach((dev) => Usb.closeDevice(dev).then(() => tenHut(i + 1)));
      }
    }, onError: (err) {
      window.console.error(err);

      LIElement errElem = new LIElement();
      errElem.text = "Error scanning for ${soldier.name}: ${err.toString()}";
      // errElem.classes.add('error');

      adbDevices.append(errElem);
    });
  }

  tenHut(0);
}



