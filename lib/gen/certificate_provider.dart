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
  SignRequest({ArrayBuffer digest, Hash hash, ArrayBuffer certificate}) {
    if (digest != null) this.digest = digest;
    if (hash != null) this.hash = hash;
    if (certificate != null) this.certificate = certificate;
  }
  SignRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ArrayBuffer get digest => _createArrayBuffer(jsProxy['digest']);
  set digest(ArrayBuffer value) => jsProxy['digest'] = jsify(value);

  Hash get hash => _createHash(jsProxy['hash']);
  set hash(Hash value) => jsProxy['hash'] = jsify(value);

  ArrayBuffer get certificate => _createArrayBuffer(jsProxy['certificate']);
  set certificate(ArrayBuffer value) => jsProxy['certificate'] = jsify(value);
}

CertificatesCallback _createCertificatesCallback(JsObject jsProxy) => jsProxy == null ? null : new CertificatesCallback.fromProxy(jsProxy);
OnSignDigestRequestedEvent _createOnSignDigestRequestedEvent(JsObject request, JsObject reportCallback) =>
    new OnSignDigestRequestedEvent(_createSignRequest(request), _createSignCallback(reportCallback));
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
Hash _createHash(String value) => Hash.VALUES.singleWhere((ChromeEnum e) => e.value == value);
SignRequest _createSignRequest(JsObject jsProxy) => jsProxy == null ? null : new SignRequest.fromProxy(jsProxy);
SignCallback _createSignCallback(JsObject jsProxy) => jsProxy == null ? null : new SignCallback.fromProxy(jsProxy);
