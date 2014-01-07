/* This file has been generated from location.idl - do not edit */

/**
 * todo(vadimt): Consider reusing WebKit/Blink types, if this is possible. Use
 * the `chrome.location` API to retrieve the geographic location of the host
 * machine. This API is a version of the <a
 * href="http://dev.w3.org/geo/api/spec-source.html">HTML Geolocation API</a>
 * that is compatible with event pages.
 */
library chrome.location;

import '../src/common.dart';

/**
 * Accessor for the `chrome.location` namespace.
 */
final ChromeLocation location = new ChromeLocation._();

class ChromeLocation extends ChromeApi {
  static final JsObject _location = chrome['location'];

  ChromeLocation._();

  bool get available => _location != null;

  /**
   * Starts a location watching request. If there is another location watching
   * request with the same name (or no name if none is specified), it will be
   * cancelled and replaced by this request.
   * [name]: Optional name to identify this request. Defaults to the empty
   * string.
   * [requestInfo]: Optional parameters for this request.
   */
  void watchLocation(String name, WatchLocationRequestInfo requestInfo) {
    if (_location == null) _throwNotAvailable();

    _location.callMethod('watchLocation', [name, jsify(requestInfo)]);
  }

  /**
   * Ends a location watching request.
   * [name]: Optional name to identify the request to remove. Defaults to the
   * empty string.
   */
  void clearWatch(String name) {
    if (_location == null) _throwNotAvailable();

    _location.callMethod('clearWatch', [name]);
  }

  Stream<Location> get onLocationUpdate => _onLocationUpdate.stream;

  final ChromeStreamController<Location> _onLocationUpdate =
      new ChromeStreamController<Location>.oneArg(_location, 'onLocationUpdate', _createLocation);

  Stream<String> get onLocationError => _onLocationError.stream;

  final ChromeStreamController<String> _onLocationError =
      new ChromeStreamController<String>.oneArg(_location, 'onLocationError', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.location' is not available");
  }
}

/**
 * Coordinates part of the Location object.
 */
class Coordinates extends ChromeObject {
  Coordinates({num latitude, num longitude, num altitude, num accuracy, num altitudeAccuracy, num heading, num speed}) {
    if (latitude != null) this.latitude = latitude;
    if (longitude != null) this.longitude = longitude;
    if (altitude != null) this.altitude = altitude;
    if (accuracy != null) this.accuracy = accuracy;
    if (altitudeAccuracy != null) this.altitudeAccuracy = altitudeAccuracy;
    if (heading != null) this.heading = heading;
    if (speed != null) this.speed = speed;
  }
  Coordinates.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  num get latitude => jsProxy['latitude'];
  set latitude(num value) => jsProxy['latitude'] = jsify(value);

  num get longitude => jsProxy['longitude'];
  set longitude(num value) => jsProxy['longitude'] = jsify(value);

  num get altitude => jsProxy['altitude'];
  set altitude(num value) => jsProxy['altitude'] = jsify(value);

  num get accuracy => jsProxy['accuracy'];
  set accuracy(num value) => jsProxy['accuracy'] = jsify(value);

  num get altitudeAccuracy => jsProxy['altitudeAccuracy'];
  set altitudeAccuracy(num value) => jsProxy['altitudeAccuracy'] = jsify(value);

  num get heading => jsProxy['heading'];
  set heading(num value) => jsProxy['heading'] = jsify(value);

  num get speed => jsProxy['speed'];
  set speed(num value) => jsProxy['speed'] = jsify(value);
}

/**
 * Parameter of onLocationUpdate event's listener.
 */
class Location extends ChromeObject {
  Location({String name, Coordinates coords, num timestamp}) {
    if (name != null) this.name = name;
    if (coords != null) this.coords = coords;
    if (timestamp != null) this.timestamp = timestamp;
  }
  Location.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get name => jsProxy['name'];
  set name(String value) => jsProxy['name'] = value;

  Coordinates get coords => _createCoordinates(jsProxy['coords']);
  set coords(Coordinates value) => jsProxy['coords'] = jsify(value);

  num get timestamp => jsProxy['timestamp'];
  set timestamp(num value) => jsProxy['timestamp'] = jsify(value);
}

/**
 * Parameter of watchLocation call.
 */
class WatchLocationRequestInfo extends ChromeObject {
  WatchLocationRequestInfo({num minDistanceInMeters, num minTimeInMilliseconds, int maximumAge}) {
    if (minDistanceInMeters != null) this.minDistanceInMeters = minDistanceInMeters;
    if (minTimeInMilliseconds != null) this.minTimeInMilliseconds = minTimeInMilliseconds;
    if (maximumAge != null) this.maximumAge = maximumAge;
  }
  WatchLocationRequestInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  num get minDistanceInMeters => jsProxy['minDistanceInMeters'];
  set minDistanceInMeters(num value) => jsProxy['minDistanceInMeters'] = jsify(value);

  num get minTimeInMilliseconds => jsProxy['minTimeInMilliseconds'];
  set minTimeInMilliseconds(num value) => jsProxy['minTimeInMilliseconds'] = jsify(value);

  int get maximumAge => jsProxy['maximumAge'];
  set maximumAge(int value) => jsProxy['maximumAge'] = value;
}

Location _createLocation(JsObject jsProxy) => jsProxy == null ? null : new Location.fromProxy(jsProxy);
Coordinates _createCoordinates(JsObject jsProxy) => jsProxy == null ? null : new Coordinates.fromProxy(jsProxy);
