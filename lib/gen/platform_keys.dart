/* This file has been generated from platform_keys.idl - do not edit */

/**
 * Use the `chrome.platformKeys` API to access client certificates managed by
 * the platform. If the user or policy grants the permission, an extension can
 * use such a certficate in its custom authentication protocol. E.g. this allows
 * usage of platform managed certificates in third party VPNs (see
 * $(ref:vpnProvider chrome.vpnProvider)).
 */
library chrome.platformKeys;

import '../src/common.dart';

/**
 * Accessor for the `chrome.platformKeys` namespace.
 */
final ChromePlatformKeys platformKeys = new ChromePlatformKeys._();

class ChromePlatformKeys extends ChromeApi {
  JsObject get _platformKeys => chrome['platformKeys'];

  ChromePlatformKeys._();

  bool get available => _platformKeys != null;

  /**
   * This function filters from a list of client certificates the ones that are
   * known to the platform, match `request` and for which the extension has
   * permission to access the certificate and its private key. If `interactive`
   * is true, the user is presented a dialog where he can select from matching
   * certificates and grant the extension access to the certificate. The
   * selected/filtered client certificates will be passed to `callback`.
   * 
   * Returns:
   * 
   * [matches]: The list of certificates that match the request, that the
   * extension has permission for and, if `interactive` is true, that were
   * selected by the user.
   */
  Future<List<Match>> selectClientCertificates(SelectDetails details) {
    if (_platformKeys == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Match>>.oneArg((e) => listify(e, _createMatch));
    _platformKeys.callMethod('selectClientCertificates', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Passes the key pair of `certificate` for usage with
   * [platformKeys.subtleCrypto] to `callback`.
   * [certificate]: The certificate of a [Match] returned by
   * [selectClientCertificates].
   * [parameters]: Determines signature/hash algorithm parameters additionally
   * to the parameters fixed by the key itself. The same parameters are accepted
   * as by WebCrypto's <a
   * href="http://www.w3.org/TR/WebCryptoAPI/#SubtleCrypto-method-importKey">importKey</a>
   * function, e.g. `RsaHashedImportParams` for a RSASSA-PKCS1-v1_5 key. For
   * RSASSA-PKCS1-v1_5 keys, additionally the parameters `{ "hash": { "name":
   * "none" } }` are supported. The sign function will then apply PKCS#1 v1.5
   * padding and but not hash the given data. <p>Currently, this function only
   * supports the "RSASSA-PKCS1-v1_5" algorithm with one of the hashing
   * algorithms "none", "SHA-1", "SHA-256", "SHA-384", and "SHA-512".</p>
   * 
   * Returns:
   * [publicKey] null
   * [privateKey] null
   */
  Future<GetKeyPairResult> getKeyPair(ArrayBuffer certificate, dynamic parameters) {
    if (_platformKeys == null) _throwNotAvailable();

    var completer = new ChromeCompleter<GetKeyPairResult>.twoArgs(GetKeyPairResult._create);
    _platformKeys.callMethod('getKeyPair', [jsify(certificate), jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * An implementation of WebCrypto's <a
   * href="http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface">
   * SubtleCrypto</a> that allows crypto operations on keys of client
   * certificates that are available to this extension.
   */
  dynamic subtleCrypto() {
    if (_platformKeys == null) _throwNotAvailable();

    return _platformKeys.callMethod('subtleCrypto');
  }

  /**
   * Checks whether `details.serverCertificateChain` can be trusted for
   * `details.hostname` according to the trust settings of the platform. Note:
   * The actual behavior of the trust verification is not fully specified and
   * might change in the future. The API implementation verifies certificate
   * expiration, validates the certification path and checks trust by a known
   * CA. The implementation is supposed to respect the EKU serverAuth and to
   * support subject alternative names.
   */
  Future<VerificationResult> verifyTLSServerCertificate(VerificationDetails details) {
    if (_platformKeys == null) _throwNotAvailable();

    var completer = new ChromeCompleter<VerificationResult>.oneArg(_createVerificationResult);
    _platformKeys.callMethod('verifyTLSServerCertificate', [jsify(details), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.platformKeys' is not available");
  }
}

class ClientCertificateType extends ChromeEnum {
  static const ClientCertificateType RSA_SIGN = const ClientCertificateType._('rsaSign');
  static const ClientCertificateType ECDSA_SIGN = const ClientCertificateType._('ecdsaSign');

  static const List<ClientCertificateType> VALUES = const[RSA_SIGN, ECDSA_SIGN];

  const ClientCertificateType._(String str): super(str);
}

class Match extends ChromeObject {
  Match({ArrayBuffer certificate, var keyAlgorithm}) {
    if (certificate != null) this.certificate = certificate;
    if (keyAlgorithm != null) this.keyAlgorithm = keyAlgorithm;
  }
  Match.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ArrayBuffer get certificate => _createArrayBuffer(jsProxy['certificate']);
  set certificate(ArrayBuffer value) => jsProxy['certificate'] = jsify(value);

  dynamic get keyAlgorithm => jsProxy['keyAlgorithm'];
  set keyAlgorithm(var value) => jsProxy['keyAlgorithm'] = jsify(value);
}

/**
 * Analogous to TLS1.1's CertificateRequest. See
 * http://tools.ietf.org/html/rfc4346#section-7.4.4 .
 */
class ClientCertificateRequest extends ChromeObject {
  ClientCertificateRequest({List<ClientCertificateType> certificateTypes, List<ArrayBuffer> certificateAuthorities}) {
    if (certificateTypes != null) this.certificateTypes = certificateTypes;
    if (certificateAuthorities != null) this.certificateAuthorities = certificateAuthorities;
  }
  ClientCertificateRequest.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<ClientCertificateType> get certificateTypes => listify(jsProxy['certificateTypes'], _createClientCertificateType);
  set certificateTypes(List<ClientCertificateType> value) => jsProxy['certificateTypes'] = jsify(value);

  List<ArrayBuffer> get certificateAuthorities => listify(jsProxy['certificateAuthorities'], _createArrayBuffer);
  set certificateAuthorities(List<ArrayBuffer> value) => jsProxy['certificateAuthorities'] = jsify(value);
}

class SelectDetails extends ChromeObject {
  SelectDetails({ClientCertificateRequest request, List<ArrayBuffer> clientCerts, bool interactive}) {
    if (request != null) this.request = request;
    if (clientCerts != null) this.clientCerts = clientCerts;
    if (interactive != null) this.interactive = interactive;
  }
  SelectDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ClientCertificateRequest get request => _createClientCertificateRequest(jsProxy['request']);
  set request(ClientCertificateRequest value) => jsProxy['request'] = jsify(value);

  List<ArrayBuffer> get clientCerts => listify(jsProxy['clientCerts'], _createArrayBuffer);
  set clientCerts(List<ArrayBuffer> value) => jsProxy['clientCerts'] = jsify(value);

  bool get interactive => jsProxy['interactive'];
  set interactive(bool value) => jsProxy['interactive'] = value;
}

class VerificationDetails extends ChromeObject {
  VerificationDetails({List<ArrayBuffer> serverCertificateChain, String hostname}) {
    if (serverCertificateChain != null) this.serverCertificateChain = serverCertificateChain;
    if (hostname != null) this.hostname = hostname;
  }
  VerificationDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<ArrayBuffer> get serverCertificateChain => listify(jsProxy['serverCertificateChain'], _createArrayBuffer);
  set serverCertificateChain(List<ArrayBuffer> value) => jsProxy['serverCertificateChain'] = jsify(value);

  String get hostname => jsProxy['hostname'];
  set hostname(String value) => jsProxy['hostname'] = value;
}

class VerificationResult extends ChromeObject {
  VerificationResult({bool trusted, List<String> debug_errors}) {
    if (trusted != null) this.trusted = trusted;
    if (debug_errors != null) this.debug_errors = debug_errors;
  }
  VerificationResult.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get trusted => jsProxy['trusted'];
  set trusted(bool value) => jsProxy['trusted'] = value;

  List<String> get debug_errors => listify(jsProxy['debug_errors']);
  set debug_errors(List<String> value) => jsProxy['debug_errors'] = jsify(value);
}

/**
 * The return type for [getKeyPair].
 */
class GetKeyPairResult {
  static GetKeyPairResult _create(publicKey, privateKey) {
    return new GetKeyPairResult._(publicKey, privateKey);
  }

  dynamic publicKey;
  dynamic privateKey;

  GetKeyPairResult._(this.publicKey, this.privateKey);
}

Match _createMatch(JsObject jsProxy) => jsProxy == null ? null : new Match.fromProxy(jsProxy);
VerificationResult _createVerificationResult(JsObject jsProxy) => jsProxy == null ? null : new VerificationResult.fromProxy(jsProxy);
ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) => jsProxy == null ? null : new ArrayBuffer.fromProxy(jsProxy);
ClientCertificateType _createClientCertificateType(String value) => ClientCertificateType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ClientCertificateRequest _createClientCertificateRequest(JsObject jsProxy) => jsProxy == null ? null : new ClientCertificateRequest.fromProxy(jsProxy);
