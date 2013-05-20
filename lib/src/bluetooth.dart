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
  Future<AdapterState> getAdapterState() {}
  Future getDevices(options) {}
  Future<ServiceRecord> getServices(options) {}
  Future connect(options) {}
  Future disconnect(options) {}
  Future read(options) {}
  Future<int> write(options) {}
  Future<OutOfBandPairingData> getLocalOutOfBandPairingData() {}
  Future setOutOfBandPairingData(options) {}
  Future startDiscovery(options) {}
  Future stopDiscovery(options) {}
}