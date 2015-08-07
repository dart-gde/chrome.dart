/* This file has been generated from document_scan.idl - do not edit */

/**
 * Use the `chrome.documentScan` API to discover and retrieve images from
 * attached paper document scanners.
 */
library chrome.documentScan;

import '../src/common.dart';

/**
 * Accessor for the `chrome.documentScan` namespace.
 */
final ChromeDocumentScan documentScan = new ChromeDocumentScan._();

class ChromeDocumentScan extends ChromeApi {
  JsObject get _documentScan => chrome['documentScan'];

  ChromeDocumentScan._();

  bool get available => _documentScan != null;

  /**
   * Performs a document scan. On success, the PNG data will be sent to the
   * callback.
   * [options]: Object containing scan parameters.
   * [callback]: Called with the result and data from the scan.
   * 
   * Returns:
   * Callback from the `scan` method. [result] The results from the scan, if
   * successful. Otherwise will return null and set runtime.lastError.
   */
  Future<ScanResults> scan(ScanOptions options) {
    if (_documentScan == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ScanResults>.oneArg(_createScanResults);
    _documentScan.callMethod('scan', [jsify(options), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.documentScan' is not available");
  }
}

class ScanOptions extends ChromeObject {
  ScanOptions({List<String> mimeTypes, int maxImages}) {
    if (mimeTypes != null) this.mimeTypes = mimeTypes;
    if (maxImages != null) this.maxImages = maxImages;
  }
  ScanOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<String> get mimeTypes => listify(jsProxy['mimeTypes']);
  set mimeTypes(List<String> value) => jsProxy['mimeTypes'] = jsify(value);

  int get maxImages => jsProxy['maxImages'];
  set maxImages(int value) => jsProxy['maxImages'] = value;
}

class ScanResults extends ChromeObject {
  ScanResults({List<String> dataUrls, String mimeType}) {
    if (dataUrls != null) this.dataUrls = dataUrls;
    if (mimeType != null) this.mimeType = mimeType;
  }
  ScanResults.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<String> get dataUrls => listify(jsProxy['dataUrls']);
  set dataUrls(List<String> value) => jsProxy['dataUrls'] = jsify(value);

  String get mimeType => jsProxy['mimeType'];
  set mimeType(String value) => jsProxy['mimeType'] = value;
}

ScanResults _createScanResults(JsObject jsProxy) => jsProxy == null ? null : new ScanResults.fromProxy(jsProxy);
