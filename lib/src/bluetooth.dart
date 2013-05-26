library chrome_bluetooth;

import 'dart:async';
import 'dart:typed_data';

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'common.dart';

// https://developer.chrome.com/dev/apps/bluetooth.html

// chrome.bluetooth

class AdapterState {
  String address;

  String name;

  bool powered;

  bool available;

  bool discovering;

  AdapterState(this.address, this.name, this.powered, this.available,
      this.discovering);

  Map toMap() => { 'address': address, 'name': name, 'powered': powered,
    'available': available, 'discovering': discovering };

  String toString() => "[$address, $name, $powered, $available, $discovering]";
}

class Device {
  String address;

  String name;

  bool paired;

  bool connected;

  Device(this.address, {this.name, this.paired, this.connected});

  Map toMap() => { 'address': address, 'name': name,
    'paired': paired, 'connected': connected };

  String toString() => "[$address, $name, $paired, $connected]";
}

class Profile {
  String uuid;
  String name;
  int channel;
  int psm;
  bool requireAuthentication;
  bool requireAuthorization;
  bool autoConnect;
  int version;
  int features;

  Profile(this.uuid, {this.name, this.channel, this.psm,
    this.requireAuthentication, this.requireAuthorization, this.autoConnect,
    this.version, this.features});

  Map toMap() => {
    'uuid': this.uuid,
    'name': this.name,
    'channel': this.channel,
    'psm': this.psm,
    'requireAuthentication': this.requireAuthentication,
    'requireAuthorization': this.requireAuthorization,
    'autoConnect': this.autoConnect,
    'version': this.version,
    'features': this.features,
  };

  String toString() {
    return "[$uuid, $name, $channel, $psm, $requireAuthentication, "
           "$requireAuthorization, $autoConnect, $version, $features]";
  }
}

class ServiceRecord {
  String name;

  String uuid;

  ServiceRecord(this.name, {this.uuid});

  Map toMap() => { 'name': name, 'uuid': uuid };

  String toString() => "[$name, $uuid]";
}

class Socket {
  Device device;
  Profile profile;
  int id;
  Socket(this.device, this.profile, this.id);

  Map toMap() => { 'device': this.device.toMap(),
                   'profile': this.profile.toMap(), 'id': id};

  String toString() => "[${this.device}, ${this.profile}, $id]";
}

class OutOfBandPairingData {
  // hash ( arraybuffer )
  // Simple Pairing Hash C. Always 16 octets long.
  // Uint16List
  ByteBuffer hash;

  // randomizer ( arraybuffer )
  // Simple Pairing Randomizer R. Always 16 octets long.
  // Uint16List
  ByteBuffer randomizer;

  OutOfBandPairingData(this.hash, this.randomizer);

  Map toMap() => { 'hash': hash, 'randomizer': randomizer };

  Map toJsDataMap() {
    var hashData = new Int32List.view(hash);
    var hashBuf = new js.Proxy(js.context.ArrayBuffer, hash.lengthInBytes);
    var hashBufView = new js.Proxy(js.context.Int32Array, hashBuf)
    ..set(js.array(hashData));

    var randomizerData = new Int32List.view(randomizer);
    var randomizerBuf = new js.Proxy(js.context.ArrayBuffer, randomizer.lengthInBytes);
    var randomizerBufView = new js.Proxy(js.context.Int32Array, randomizerBuf)
    ..set(js.array(randomizerData));

    return { 'hash': hashBuf, 'randomizer': randomizerBuf };
  }

  String toString() => "[$hash, $randomizer]";
}

typedef void onAdapterStateChanged(AdapterState state);
typedef void onDeviceFound(Device device);

class ConnectResult {
  Device device;
  String serviceUuid;
  int id;
  ConnectResult(this.device, this.serviceUuid, this.id);
}

class ChromeBluetooth {
  static final Logger _logger = new Logger("chrome.bluetooth");

  Future addProfile(Profile profile) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      chromeProxy.bluetooth.addProfile(js.map(profile.toMap()), callback);
    });
    return completer.future;
  }

  Future removeProfile(Profile profile) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      chromeProxy.bluetooth.removeProfile(js.map(profile.toMap()), callback);
    });
    return completer.future;
  }

  Future<AdapterState> getAdapterState() {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        if (result != null) {
          var adapterState = new AdapterState(result.address, result.name,
              result.powered, result.available, result.discovering);
          completer.complete(adapterState);
        } else {
          // TODO(adam): complete with exception
          completer.complete(null);
        }
      });

      chromeProxy.bluetooth.getAdapterState(callback);
    });
    return completer.future;
  }


  Future getDevices(onDeviceFound deviceCallback, {Profile profile}) {
    Completer completer = new Completer();
    js.scoped(() {
      var _deviceCallback = new js.Callback.many((var device) {
        try {
          deviceCallback(new Device(device.address, name: device.name,
              paired: device.paired, connected: device.connected));
        } catch (ex) {
          _logger.fine("_deviceCallback has thrown exception = $ex");
        }
      });

      js.Callback callback = new js.Callback.once(() {
        _deviceCallback.dispose();
        completer.complete(null);
      });

      var _options = {'deviceCallback': _deviceCallback};
      if (profile != null) {
        _options['profile'] = profile.toMap();
      }

      chromeProxy.bluetooth.getDevices(js.map(_options), callback);
    });

    return completer.future;
  }

  _safeNewDeviceFromJs(var d) {
    Device device;
    try {
      device = new Device(d.address);
    } catch (ex) {
      return null;
    }

    try {
      device.name = d.name;
    } catch (ex) {
      device.name = null;
    }

    try {
      device.paired = d.paired;
    } catch (ex) {
      device.paired = null;
    }

    try {
      device.connected = d.connected;
    } catch (ex) {
      device.connected = null;
    }

    return device;
  }

  Future getProfiles(Device device) {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        List<Profile> profiles = new List<Profile>();
        for (int i = 0; i < result.length; i++) {
          profiles.add(_safeNewDeviceFromJs(result));
        }
        completer.complete(profiles);
      });

      chromeProxy.bluetooth.getProfiles(js.map(device.toMap()));
    });

    return completer.future;
  }

  Future<List<ServiceRecord>> getServices(String deviceAddress) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        List<ServiceRecord> serviceRecords = new List<ServiceRecord>();
        for (int i = 0; i < result.length; i++) {
          var serviceRecord = new ServiceRecord(result[i].name, uuid: result[i].uuid);
          serviceRecords.add(serviceRecord);
        }
        completer.complete(serviceRecords);
      });

      chromeProxy.bluetooth.getServices(js.map({'deviceAddress': deviceAddress}), callback);
    });

    return completer.future;
  }

  Future<ConnectResult> connect(Device device, Profile profile) {
    Completer completer = new Completer();
    js.scoped(() {

//      js.Callback callback = new js.Callback.once((var result) {
//        var connectResult =
//            new ConnectResult(new Device(result.device.address,
//                result.device.name, result.device.paired,
//                result.device.connected), result.serviceUuid, result.id);
//        completer.complete(connectResult);
//      });

      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      var _options = {'device': device.toMap(),
                      'profile': profile.toMap()};
      chromeProxy.bluetooth.connect(js.map(_options), callback);
    });
    return completer.future;
  }

  Future disconnect(Socket socket) {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      chromeProxy.bluetooth.disconnect(js.map({'socket': socket.toMap()}), callback);
    });
    return completer.future;
  }

  Future read(Socket socket) {
    Completer completer = new Completer();

    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        var bufView = new js.Proxy(js.context.Int32Array, result);
        Int32List data = new Int32List(bufView.length);
        for (var i = 0; i < bufView.length; i++) {
          data[i] = bufView[i];
        }
        completer.complete(data);
      });

      chromeProxy.bluetooth.read(js.map({'socket': socket}), callback);
    });

    return completer.future;
  }

  Future<int> write(Socket socket, ByteBuffer buffer) {
    Completer completer = new Completer();

    js.scoped(() {

      js.Callback callback = new js.Callback.once((var result) {
        completer.complete(result);
      });

      var data = new Int8List.view(buffer);
      var buf = new js.Proxy(js.context.ArrayBuffer, buffer.lengthInBytes);
      var bufView = new js.Proxy(js.context.Int8Array, buf)
      ..set(js.array(data));

      chromeProxy.bluetooth.write(js.map({'socket': socket.toMap(),
        'data': buf}), callback);
    });

    return completer.future;
  }

  _safeNewOutOfBandPairingData(oobpd) {
    var hashJsBufView = new js.Proxy(js.context.Int32Array, oobpd.hash);
    var randomizerJsBufView = new js.Proxy(js.context.Int32Array, oobpd.randomizer);

    Int32List hashData = new Int32List(hashJsBufView.length);
    for (var i = 0; i < hashJsBufView.length; i++) {
      hashData[i] = hashJsBufView[i];
    }

    Int32List randomizerData = new Int32List(randomizerJsBufView.length);
    for (var i = 0; i < randomizerJsBufView.length; i++) {
      randomizerData[i] = randomizerJsBufView[i];
    }

    return new OutOfBandPairingData(hashData, randomizerData);
  }

  Future<OutOfBandPairingData> getLocalOutOfBandPairingData() {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once((var result) {
        completer.complete(_safeNewOutOfBandPairingData(result));
      });

      chromeProxy.bluetooth.getLocalOutOfBandPairingData(callback);
    });
    return completer.future;
  }

  Future setOutOfBandPairingData(String address, OutOfBandPairingData data) {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      chromeProxy.bluetooth.setOutOfBandPairingData(
          js.map({'address': address, 'data': data.toJsDataMap()}), callback);
    });
    return completer.future;
  }

  Future startDiscovery(onDeviceFound deviceCallback) {
    Completer completer = new Completer();
    js.scoped(() {
      var _deviceCallback = new js.Callback.many((var device) {
        try {
          deviceCallback(new Device(device.address, device.name, device.paired,
              device.connected));
        } catch (ex) {
          _logger.fine("startDiscovery: _deviceCallback has thrown exception = $ex");
        }
      });

      js.Callback callback = new js.Callback.once(() {
        _deviceCallback.dispose();
        completer.complete();
      });

      var _options = {'deviceCallback': _deviceCallback};

      chromeProxy.bluetooth.startDiscovery(js.map(_options), callback);
    });

    return completer.future;
  }

  Future stopDiscovery() {
    Completer completer = new Completer();
    js.scoped(() {
      js.Callback callback = new js.Callback.once(() {
        completer.complete();
      });

      chromeProxy.bluetooth.stopDiscovery(callback);
    });
    return completer.future;
  }
}