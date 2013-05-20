library chrome_bluetooth;

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'common.dart';

// chrome.bluetooth

class AdapterState {
  String address;

  String name;

  bool powered;

  bool available;

  bool discovering;

  AdapterState(this.address, this.name, this.powered, this.available,
      this.discovering);

  toString() => "[$address, $name, $powered, $available, $discovering]";
}

class Device {
  String address;

  String name;

  bool paired;

  bool bonded;

  bool connected;
}

class ServiceRecord {
  String name;

  String uuid;
}

class OutOfBandPairingData {
  // hash ( arraybuffer )
  // Simple Pairing Hash C. Always 16 octets long.
  var hash;

  // randomizer ( arraybuffer )
  // Simple Pairing Randomizer R. Always 16 octets long.
  var randomizer;
}

typedef void onAdapterStateChanged(AdapterState state);

class ChromeBluetooth {
  Future<AdapterState> getAdapterState() {
    Completer completer = new Completer();

    //js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        if (result != null) {
          var adapterState = new AdapterState(result.address, result.name,
              result.powered, result.available, result.discovering);
          completer.complete(adapterState);
        } else {
          completer.complete(null);
        }
      });

      chromeProxy.bluetooth.getAdapterState(callback);
    //});

    return completer.future;
  }

  Future getDevices({String uuid: null, String name: null, deviceCallback: null /* todo typedef */}) {
    Completer completer = new Completer();

    return completer.future;
  }

  Future<ServiceRecord> getServices(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future connect(options) {
    Completer completer = new Completer();
    return completer.future;
  }
  Future disconnect(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future read(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future<int> write(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future<OutOfBandPairingData> getLocalOutOfBandPairingData() {
    Completer completer = new Completer();
    return completer.future;
  }

  Future setOutOfBandPairingData(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future startDiscovery(options) {
    Completer completer = new Completer();
    return completer.future;
  }

  Future stopDiscovery(options) {
    Completer completer = new Completer();
    return completer.future;
  }
}