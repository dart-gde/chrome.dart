/* This file has been generated from certificate_provider.idl - do not edit */

/**
 * Use this API to expose certificates to the platform which can use these
 * certificates for TLS authentications.
 */
library chrome.certificateProvider;

import '../src/common.dart';

/**
 * Accessor for the `chrome.certificateProvider` namespace.
 */
final ChromeCertificateProvider certificateProvider = new ChromeCertificateProvider._();

class ChromeCertificateProvider extends ChromeApi {
  JsObject get _certificateProvider => chrome['certificateProvider'];

  Stream<CertificatesCallback> get onCertificatesRequested => _onCertificatesRequested.stream;
  ChromeStreamController<CertificatesCallback> _onCertificatesRequested;

  Stream<OnSignDigestRequestedEvent> get onSignDigestRequested => _onSignDigestRequested.stream;
  ChromeStreamController<OnSignDigestRequestedEvent> _onSignDigestRequested;

  ChromeCertificateProvider._() {
    var getApi = () => _certificateProvider;
    _onCertificatesRequested = new ChromeStreamController<CertificatesCallback>.oneArg(getApi, 'onCertificatesRequested', _createCertificatesCallback);
    _onSignDigestRequested = new ChromeStreamController<OnSignDigestRequestedEvent>.twoArgs(getApi, 'onSignDigestRequested', _createOnSignDigestRequestedEvent);
  }

  bool get available => _certificateProvider != null;

  /**
   * Requests the PIN from the user. Only one ongoing request at a time is
   * allowed. The requests issued while another flow is ongoing are rejected.
   * It's the extension's responsibility to try again later if another flow is
   * in progress.
   * [details]: Contains the details about the requested dialog.
   * [callback]: Is called when the dialog is resolved with the user input, or
   * when the dialog request finishes unsuccessfully (e.g. the dialog was
   * canceled by the user or was not allowed to be shown).
   */
  void requestPin(RequestPinDetails details, RequestPinCallback requestCallback) {
    if (_certificateProvider == null) _throwNotAvailable();

    _certificateProvider.callMethod('requestPin', [jsify(details), jsify(requestCallback)]);
  }

  /**
   * Stops the pin request started by the [requestPin] function.
   * [details]: Contains the details about the reason for stopping the request
   * flow.
   * [callback]: To be used by Chrome to send to the extension the status from
   * their request to close PIN dialog for user.
   */
  void stopPinRequest(StopPinRequestDetails details, StopPinRequestCallback requestCallback) {
    if (_certificateProvider == null) _throwNotAvailable();

    _certificateProvider.callMethod('stopPinRequest', [jsify(details), jsify(requestCallback)]);
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.certificateProvider' is not available");
  }
}

class OnSignDigestRequestedEvent {
  final SignRequest request;

  final SignCallback reportCallback;

  OnSignDigestRequestedEvent(this.request, this.reportCallback);
}

class Hash extends ChromeEnum {
  static const Hash MD5_SHA1 = const Hash._('MD5_SHA1');
  static const Hash SHA1 = const Hash._('SHA1');
  static const Hash SHA256 = const Hash._('SHA256');
  static const Hash SHA384 = const Hash._('SHA384');
  static const Hash SHA512 = const Hash._('SHA512');

  static const List<Hash> VALUES = const[MD5_SHA1, SHA1, SHA256, SHA384, SHA512];

  const Hash._(String str): super(str);
}

/**
 * The type of code being requested by the extension with requestPin function.
 */
class PinRequestType extends ChromeEnum {
  static const PinRequestType PIN = const PinRequestType._('PIN');
  static const PinRequestType PUK = const PinRequestType._('PUK');

  static const List<PinRequestType> VALUES = const[PIN, PUK];

  const PinRequestType._(String str): super(str);
}

/**
 * The types of errors that can be presented to the user through the requestPin
 * function.
 */
class PinRequestErrorType extends ChromeEnum {
  static const PinRequestErrorType INVALID_PIN = const PinRequestErrorType._('INVALID_PIN');
  static const PinRequestErrorType INVALID_PUK = const PinRequestErrorType._('INVALID_PUK');
  static const PinRequestErrorType MAX_ATTEMPTS_EXCEEDED = const PinRequestErrorType._('MAX_ATTEMPTS_EXCEEDED');
  static const PinRequestErrorType UNKNOWN_ERROR = const PinRequestErrorType._('UNKNOWN_ERROR');

  static const List<PinRequestErrorType> VALUES = const[INVALID_PIN, INVALID_PUK, MAX_ATTEMPTS_EXCEEDED, UNKNOWN_ERROR];

  const PinRequestErrorType._(String str): super(str);
}

class CertificateInfo extends ChromeObject {
  CertificateInfo({ArrayBuffer certificate, List<Hash> supportedHashes}) {
    if (certificate != null) this.certificate = certificate;
    if (supportedHashes != null) this.supportedHashes = supportedHashes;
  }
  CertificateInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ArrayBuffer get certificate => _createArrayBuffer(jsProxy['certificate']);
  set certificate(ArrayBuffer value) => jsProxy['certificate'] = jsify(value);

  List<Hash> get supportedHashes => listify(jsProxy['supportedHashes'], _createHash);
  set supportedHashes(List<Hash> value) => jsProxy['supportedHashes'] = jsify(value);
}

class SignRequest extends ChromeObject {
  SignRequest({int signRequestId, ArrayBuffer digest, Hash hash, ArrayBuffer certificate}) {
    if (signRequestId != null) this.signRequestId = signRequestId;
    if (digest != null) this.digest = digest;
    if (hash != null) this.hash = hash;
    if (certificate != null) this.certificate = certificate;
  }
  SignRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get signRequestId => jsProxy['signRequestId'];
  set signRequestId(int value) => jsProxy['signRequestId'] = value;

  ArrayBuffer get digest => _createArrayBuffer(jsProxy['digest']);
  set digest(ArrayBuffer value) => jsProxy['digest'] = jsify(value);

  Hash get hash => _createHash(jsProxy['hash']);
  set hash(Hash value) => jsProxy['hash'] = jsify(value);

  ArrayBuffer get certificate => _createArrayBuffer(jsProxy['certificate']);
  set certificate(ArrayBuffer value) => jsProxy['certificate'] = jsify(value);
}

class RequestPinDetails extends ChromeObject {
  RequestPinDetails({int signRequestId, PinRequestType requestType, PinRequestErrorType errorType, int attemptsLeft}) {
    if (signRequestId != null) this.signRequestId = signRequestId;
    if (requestType != null) this.requestType = requestType;
    if (errorType != null) this.errorType = errorType;
    if (attemptsLeft != null) this.attemptsLeft = attemptsLeft;
  }
  RequestPinDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get signRequestId => jsProxy['signRequestId'];
  set signRequestId(int value) => jsProxy['signRequestId'] = value;

  PinRequestType get requestType => _createPinRequestType(jsProxy['requestType']);
  set requestType(PinRequestType value) => jsProxy['requestType'] = jsify(value);

  PinRequestErrorType get errorType => _createPinRequestErrorType(jsProxy['errorType']);
  set errorType(PinRequestErrorType value) => jsProxy['errorType'] = jsify(value);

  int get attemptsLeft => jsProxy['attemptsLeft'];
  set attemptsLeft(int value) => jsProxy['attemptsLeft'] = value;
}

class StopPinRequestDetails extends ChromeObject {
  StopPinRequestDetails({int signRequestId, PinRequestErrorType errorType}) {
    if (signRequestId != null) this.signRequestId = signRequestId;
    if (errorType != null) this.errorType = errorType;
  }
  StopPinRequestDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  int get signRequestId => jsProxy['signRequestId'];
  set signRequestId(int value) => jsProxy['signRequestId'] = value;

  PinRequestErrorType get errorType => _createPinRequestErrorType(jsProxy['errorType']);
  set errorType(PinRequestErrorType value) => jsProxy['errorType'] = jsify(value);
}

class PinResponseDetails extends ChromeObject {
  PinResponseDetails({String userInput}) {
    if (userInput != null) this.userInput = userInput;
  }
  PinResponseDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get userInput => jsProxy['userInput'];
  set userInput(String value) => jsProxy['userInput'] = value;
}

CertificatesCallback _createCertificatesCallback(JsObject jsProxy) => jsProxy == null ? null : new CertificatesCallback.fromProxy(jsProxy);
OnSignDigestRequestedEvent _createOnSignDigestRequestedEvent(JsObject request, JsObject reportCallback) =>
    new OnSignDigestRequestedEvent(_createSignRequest(request), _createSignCallback(reportCallback));
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
Hash _createHash(String value) => Hash.VALUES.singleWhere((ChromeEnum e) => e.value == value);
PinRequestType _createPinRequestType(String value) => PinRequestType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
PinRequestErrorType _createPinRequestErrorType(String value) => PinRequestErrorType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SignRequest _createSignRequest(JsObject jsProxy) => jsProxy == null ? null : new SignRequest.fromProxy(jsProxy);
SignCallback _createSignCallback(JsObject jsProxy) => jsProxy == null ? null : new SignCallback.fromProxy(jsProxy);
