library chrome_usb;

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
  String requestType;

}

class Device {

}

class ControlTransferInfo {

}

class GenericTransferInfo {

}

class IsochronousTransferInfo {

}

class TransferResultInfo {

}

class FindDevicesOptions {

}

class Usb {
  findDevices() {}
  closeDevice() {}
  claimInterface() {}
  releaseInterface() {}
  setInterfaceAlternateSetting() {}
  controlTransfer() {}
  bulkTransfer() {}
  interruptTransfer() {}
  isochronousTransfer() {}
}