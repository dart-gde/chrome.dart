import 'dart:html';
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:chrome/chrome.dart';
import 'package:chrome/src/usb.dart';
import 'package:js/js.dart' as js;

import 'android-accessory.dart';

class Soldier {
  int vendorId;
  int productId;
  String name;

  Soldier(this.vendorId, this.productId, this.name);

  get props => new FindDevicesOptions(this.vendorId, this.productId)
}

void main() {
  Logger logger = new Logger("main");

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord r) => window.console.log(r.message.toString()));


  Element adbDevices = query('#adb-devices');


  // They come marching one-by-one hurrah....
  var army = [
    // Phones.
    new Soldier(0x04e8, 0x6860, "Galaxy Nexus"),
    new Soldier(0x18d1, 0x4ee1, "Nexus 4"),
    // Tablets.
    new Soldier(0x18d1, 0x4e42, "Nexus 7"),
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

      var jsPerms = [];
    
      army.forEach((soldier) {
        jsPerms.add({
          "vendorId": soldier.vendorId,
          "productId": soldier.productId
        });
      });

      jsPerms = [
        {
          "usbDevices": jsPerms,
        }
      ];

      chrome.permissions.request(js.map({
        "permissions": jsPerms
      }),
        new js.Callback.once((granted) {
          if(granted) {
            tenHut(0);
          } else {
            adbDevices.append(new LIElement()
              ..text = "You need to give us permission!");
          }
        })
      );
    });
  });

}
