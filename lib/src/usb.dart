library chrome.usb;

import 'dart:async';
import 'dart:html' as html;
import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

import 'runtime.dart';

class Direction {
  /**
   * ( enumerated string ["in", "out"] )
   *
   * Direction, Recipient and RequestType all map to their namesakes
   * within the USB specification.
   */
  String direction;
  Direction(this.direction);
}

class Recipient {
  /**
   * ( enumerated string ["device", "interface", "endpoint", "other"] )
   */
  String recipient;
  Recipient(this.recipient);
}

class RequestType {
  /**
   * ( enumerated string ["standard", "class", "vendor", "reserved"] )
   */
  String requestType;
  RequestType(this.requestType);
}

class Device {
  int vendorId;
  int handle;
  int productId;

  Device(this.vendorId, this.handle, this.productId);

  Map toMap() => { 'vendorId': this.vendorId, 'productId': this.productId, 'handle': this.handle };
}

class ControlTransferInfo {
  int index;

  /**
   * The direction of this transfer.
   *
   */
  Direction direction;

  /**
   * The type of this request.
   */
  RequestType requestType;

  /**
   * The intended recipient for this transfer.
   */
  Recipient recipient;


  int request;

  int value;

  /**
   * ( optional )
   * If this transfer is an input transfer, then this field must be set to
   * indicate the expected data length. If this is an output transfer,
   * then this field is ignored.
   */
  int length;

  /**
   * ( optional ) The data payload carried by this transfer. If this is an
   * output tranfer then this field must be set.
   */
  html.ArrayBuffer data;

  ControlTransferInfo(this.index, this.direction, this.requestType, this.recipient, this.request, this.value, {this.length, this.data});


  Map toMap() {
    Map ret = {
      "direction": this.direction.direction,
      "requestType": this.requestType.requestType,
      "recipient": this.recipient.recipient,

      "request": this.request,
      "value": this.value
    };

    if(this.length != null) {
      ret["length"] = this.length;
    }

    if(this.data != null) {
      ret["data"] = this.data;
    }

    return ret;
  }
}

class GenericTransferInfo {
  /**
   * The direction of this transfer.
   */
  Direction direction;

  int endpoint;

  /**
   * ( optional )
   * If this is an output transfer then this field must be populated.
   * Otherwise, it will be ignored.
   */
  html.ArrayBuffer data;

  /**
   * ( optional )
   * If this is an input transfer then this field indicates the size of the
   * input buffer. If this is an output transfer then this field is ignored.
   */
  int length;

  GenericTransferInfo(this.direction, this.endpoint, {this.data, this.length});


  Map toMap() {
    Map ret = {
     "direction": this.direction,
     "endpoint": this.endpoint
    };

    if(this.data != null) {
      ret["data"] = this.data;
    }

    if(this.length != null) {
      ret["length"] = this.length;
    }

    return ret;
  }
}

class IsochronousTransferInfo {
  /**
   * The length of each of the packets in this transfer.
   */
  int packetLength;

  /**
   * All of the normal transfer parameters are encapsulated in the transferInfo
   * parameters. Note that the data specified in this parameter block is split
   * along packetLength boundaries to form the individual packets of the transfer.
   */
  GenericTransferInfo transferInfo;

  /**
   * The total number of packets in this transfer.
   */
  int packets;

  IsochronousTransferInfo(this.packetLength, this.transferInfo, this.packets);

  Map toMap() => {
    "packetLength": this.packetLength,
    "transferInfo": this.transferInfo.toMap(),
    "packets": this.packets
  };
}

class TransferResultInfo {
  /**
   *  ( optional )
   *  A value of 0 indicates that the transfer was a success.
   *  Other values indicate failure.
   */
  int resultCode;

  /**
   * ( optional )
   * If the transfer was an input transfer then this field will contain all of
   * the input data requested.
   */
  html.ArrayBuffer data;

  TransferResultInfo({this.resultCode, this.data});
}

class FindDevicesOptions {
  int vendorId;
  int productId;
  FindDevicesOptions(this.vendorId, this.productId);

  Map toMap() => { 'vendorId': this.vendorId, 'productId': this.productId };
}

class Usb {
  static Logger logger = new Logger("chrome.usb");

  /// callbacks need to check lastError
  static _safeExecute(completer, f) {
    var lastError = runtime.lastError;
    if (!lastError.message.isEmpty) {
      completer.completeError(lastError);
      return;
    } else {
      f();
    }
  }

  static Future<List<Device>> findDevices(FindDevicesOptions options) {
    var completer = new Completer();

    _jsFindDevices() {
      void findDevicesCallback([var result]) {
        if(result == null) {
          // In theory, this should always be set in the case of
          // result == null -- in theory.

          completer.completeError(runtime.lastError);
          return;
        }

        List devices = new List<Device>();

        for(var i = 0; i < result.length; i++) {
          devices.add(new Device(
            result[i].vendorId,
            result[i].handle,
            result[i].productId ));
        }

        completer.complete(devices);
      }

      var chrome = js.context.chrome;
      chrome.usb.findDevices(js.map(options.toMap()),
        new js.Callback.once(findDevicesCallback));
    }

    js.scoped(_jsFindDevices);

    return completer.future;
  }

  static Future closeDevice(Device device) {

    var completer = new Completer();

    _jsCloseDevice() {
      void closeDeviceCallback() {
        _safeExecute(completer, () => completer.complete());
      }

      var chrome = js.context.chrome;
      chrome.usb.closeDevice(js.map(device.toMap()),
        new js.Callback.once(closeDeviceCallback));
    }

    js.scoped(_jsCloseDevice);

    return completer.future;
  }

  static Future claimInterface(Device device, int interfaceNumber) {
    var completer = new Completer();

    _jsClaimInterface() {
      void claimInterfaceCallback() {
        _safeExecute(completer, () => completer.complete());
      }

      var chrome = js.context.chrome;
      chrome.usb.claimInterface(
        js.map(device.toMap()),
        interfaceNumber,
        new js.Callback.once(claimInterfaceCallback));
    }

    js.scoped(_jsClaimInterface);

    return completer.future;
  }

  static Future releaseInterface(Device device, int interfaceNumber) {
    var completer = new Completer();

    _jsReleaseInterface() {
      void releaseInterfaceCallback() {
        _safeExecute(completer, () => completer.complete());
      }

      var chrome = js.context.chrome;
      chrome.usb.releaseInterface(
        js.map(device.toMap()),
        interfaceNumber,
        new js.Callback.once(releaseInterfaceCallback));
    }

    js.scoped(_jsReleaseInterface);

    return completer.future;
  }

  static Future setInterfaceAlternateSetting(Device device, int interfaceNumber, int alternateSetting) {
    var completer = new Completer();


    _jsSetInterfaceAlternateSetting() {
      void claimInterfaceCallback() {
        _safeExecute(completer, () => completer.complete());
      }

      var chrome = js.context.chrome;
      chrome.usb.setInterfaceAlternateSetting(
        js.map(device.toMap()),
        interfaceNumber,
        alternateSetting,
        new js.Callback.once(claimInterfaceCallback));
    }

    js.scoped(_jsSetInterfaceAlternateSetting);

    return completer.future;
  }

  static Future controlTransfer(Device device, ControlTransferInfo transferInfo) {
    var completer = new Completer<TransferResultInfo>();

    _jsControlTransfer() {
      void controlTransferCallback(var result) {
        _safeExecute(completer, () {
          TransferResultInfo info = new TransferResultInfo();

          if(result.resultCode != null) {
            info.resultCode = result.resultCode;
          }

          if(result.data != null) {
            info.data = result.data;
          }

          completer.complete(info);
        });
      }

      var chrome = js.context.chrome;
      chrome.usb.controlTransfer(
        js.map(device.toMap()),
        js.map(transferInfo.toMap()),
        new js.Callback.once(controlTransferCallback));
    }

    js.scoped(_jsControlTransfer);

    return completer.future;
  }

  static Future bulkTransfer(Device device, GenericTransferInfo transferInfo) {
    var completer = new Completer();

    _jsBulkTransfer() {

      void bulkTransferCallback(var result) {
        _safeExecute(completer, () {
          TransferResultInfo info = new TransferResultInfo();

          if(result.resultCode != null) {
            info.resultCode = result.resultCode;
          }

          if(result.data != null) {
            info.data = result.data;
          }

          completer.complete(info);
        });
      }

      var chrome = js.context.chrome;
      chrome.usb.bulkTransfer(
        js.map(device.toMap()),
        js.map(transferInfo.toMap()),
        new js.Callback.once(bulkTransferCallback));
    }

    js.scoped(_jsBulkTransfer);

    return completer.future;
  }

  static Future interruptTransfer(Device device, GenericTransferInfo transferInfo) {
    var completer = new Completer();

    _jsInteruptTransfer() {
      void interuptTransferCallback(var result) {
        _safeExecute(completer, () {
          TransferResultInfo info = new TransferResultInfo();

          if(result.resultCode != null) {
            info.resultCode = result.resultCode;
          }

          if(result.data != null) {
            info.data = result.data;
          }

          completer.complete(info);
        });
      }

      var chrome = js.context.chrome;
      chrome.usb.interuptTransfer(
        js.map(device.toMap()),
        js.map(transferInfo.toMap()),
        new js.Callback.once(interuptTransferCallback));
    }


    js.scoped(_jsInteruptTransfer);

    return completer.future;
  }

  static Future isochronousTransfer(Device device, IsochronousTransferInfo transferInfo) {
    var completer = new Completer();

    _jsIsochronousTransfer() {
      void isochronousTransferCallback(var result) {
        _safeExecute(completer, () {
          TransferResultInfo info = new TransferResultInfo();

          if(result.resultCode != null) {
            info.resultCode = result.resultCode;
          }

          if(result.data != null) {
            info.data = result.data;
          }

          completer.complete(info);
        });
      }

      var chrome = js.context.chrome;
      chrome.usb.isochronousTransfer(
        js.map(device.toMap()),
        js.map(transferInfo.toMap()),
        new js.Callback.once(isochronousTransferCallback));
    }

    js.scoped(_jsIsochronousTransfer);

    return completer.future;
  }
}
