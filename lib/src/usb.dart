library chrome_usb;

import 'dart:async';
import 'dart:html' as html;
import 'dart:json';
import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

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
}

class Usb {
  static Future findDevices(FindDevicesOptions options) {
    var completer = new Completer();

    return completer.future;
  }

  static Future closeDevice(Device device) {
    var completer = new Completer();

    return completer.future;
  }

  static Future claimInterface(Device device, int interfaceNumber) {
    var completer = new Completer();

    return completer.future;
  }

  static Future releaseInterface(Device device, int interfaceNumber) {
    var completer = new Completer();

    return completer.future;
  }

  static Future setInterfaceAlternateSetting(Device device, int interfaceNumber, int alternateSetting) {
    var completer = new Completer();

    return completer.future;
  }

  static Future controlTransfer(Device device, ControlTransferInfo transferInfo) {
    var completer = new Completer();

    return completer.future;
  }

  static Future bulkTransfer(Device device, GenericTransferInfo transferInfo) {
    var completer = new Completer();

    return completer.future;
  }

  static Future interruptTransfer(Device device, GenericTransferInfo transferInfo) {
    var completer = new Completer();

    return completer.future;
  }

  static Future isochronousTransfer(Device device, IsochronousTransferInfo transferInfo) {
    var completer = new Completer();

    return completer.future;
  }
}