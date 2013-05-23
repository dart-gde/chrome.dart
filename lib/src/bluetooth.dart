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

  Device(this.address, this.name, this.paired, this.bonded, this.connected);

  Map toMap() => { 'address': this.address, 'name': this.name,
    'paired': this.paired, 'bonded': this.bonded, 'connected': this.connected };
}

class ServiceRecord {
  String name;
  String uuid;
  ServiceRecord(this.name, this.uuid);
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
typedef void onDeviceFound(Device device);

class ConnectResult {
  Device device;
  String serviceUuid;
  int id;
  ConnectResult(this.device, this.serviceUuid, this.id);
}

Device _safeBuildDeviceClass(device, logger) {
  // XXX(adam): spec says bonded is either true or false.
  // Trying to access bonded always throws an exception.
  var _bondedHack;
  try {
    _bondedHack = device.bonded;
  } catch (ex) {
    _bondedHack = false;
    logger.fine("access to device.bonded has thrown exception, "
        "_bondedHack = $_bondedHack");
  }

  return new Device(device.address, device.name, device.paired,
      _bondedHack, device.connected);
}

class ChromeBluetooth {
  static final Logger _logger = new Logger("chrome.bluetooth");

  Future<AdapterState> getAdapterState() {
    Completer completer = new Completer();

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

    return completer.future;
  }


  Future getDevices(onDeviceFound deviceCallback,
                    {String uuid: null, String name: null}) {
    Completer completer = new Completer();
    js.scoped(() {
      var _deviceCallback = new js.Callback.many((var device) {
        try {
          deviceCallback(_safeBuildDeviceClass(device, _logger));
        } catch (ex) {
          _logger.fine("_deviceCallback has thrown exception = $ex");
        }
      });

      js.Callback callback = new js.Callback.once(() {
        _deviceCallback.dispose();
        completer.complete(null);
      });

      var _options = {'deviceCallback': _deviceCallback};
      if (uuid != null) {
        _options['uuid'] = uuid;
      }

      if (name != null) {
        _options['name'] = name;
      }

      chromeProxy.bluetooth.getDevices(js.map(_options), callback);
    });

    return completer.future;
  }

  Future<List<ServiceRecord>> getServices(String deviceAddress) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        List<ServiceRecord> serviceRecords = new List<ServiceRecord>();
        for (int i = 0; i < result.length; i++) {
          serviceRecords.add(result[i].name, result[i].uuid);
        }
        completer.complete(serviceRecords);
      });

      chromeProxy.bluetooth.getServices(js.map({'deviceAddress': deviceAddress}), callback);
    });

    return completer.future;
  }

  Future<ConnectResult> connect(String deviceAddress, String serviceUuid) {
    Completer completer = new Completer();
    js.scoped(() {

      js.Callback callback = new js.Callback.once((var result) {
        var connectResult =
            new ConnectResult(_safeBuildDeviceClass(result.device, _logger),
                result.serviceUuid, result.id);
        completer.complete(connectResult);
      });

      var _options = {'deviceAddress': deviceAddress,
                      'serviceUuid': serviceUuid};
      chromeProxy.bluetooth.connect(js.map(_options), callback);
    });
    return completer.future;
  }

  Future disconnect(int socketId) {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        completer.complete(null);
      });

      chromeProxy.bluetooth.disconnect(js.map({'socketId': socketId}), callback);
    });
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