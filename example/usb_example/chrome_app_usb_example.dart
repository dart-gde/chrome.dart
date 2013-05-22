import 'dart:html';
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
import 'package:chrome/src/usb.dart';
import 'package:js/js.dart' as js;

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
    // Phones.
    new Soldier(new FindDevicesOptions(0x04e8, 0x6860), "Galaxy Nexus"),
    new Soldier(new FindDevicesOptions(0x18d1, 0x4ee1), "Nexus 4"),
    // Tablets.
    new Soldier(new FindDevicesOptions(0x18d1, 0x4e42), "Nexus 7")
  ];

  int done = -1;

  void tenHut(int i) {

    if(i == 0) {
      adbDevices.children.clear();
    }

    if(i > army.length) {
      adbDevices.append(new LIElement()
        ..text = "Press the button again to refresh!");

      return;
    }

    var soldier = army[i];

    window.console.log("Looking for ${soldier.name}");

    Usb.findDevices(soldier.props).then(
    (result) {
      if(result.length > 0) {
        LIElement devElem = new LIElement();

        if(result.length > 1) {
          devElem.text = "${soldier.name} (x${result.length})";
        } else {
          devElem.text = soldier.name;
        }

        adbDevices.append(devElem);

        result.forEach((dev) => Usb.closeDevice(dev));

        tenHut(i + 1);
      }
    }, onError: (err) {
      window.console.error(err);

      LIElement errElem = new LIElement();
      errElem.text = "Error scanning for ${soldier.name}: ${err.message}";

      adbDevices.append(errElem);
    });
  }

  query("#load").onClick.listen((_) {
    js.scoped(() {
      var chrome = js.context.chrome;

      window.console.log("Converting...");
      var jsPerms = [];
    
      army.forEach((soldier) {
        jsPerms.add({
          "vendorId": soldier.props.vendorId,
          "productId": soldier.props.productId
        });
      });

      jsPerms = [
        {
          "usbDevices": jsPerms,
        }
      ];

      window.console.log(jsPerms);

      chrome.permissions.request(js.map({
        "permissions": jsPerms
      }),
        new js.Callback.once((granted) {
          if(granted) {
            tenHut(0);
          } else {
            window.console.log("Permissions Denied.");

            // TODO: Something helpful.
          }
        })
      );
    });
  });

}
