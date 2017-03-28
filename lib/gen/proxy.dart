/* This file has been generated from proxy.json - do not edit */

/**
 * Use the `chrome.proxy` API to manage Chrome's proxy settings. This API relies
 * on the [ChromeSetting prototype of the type API](types#ChromeSetting) for
 * getting and setting the proxy configuration.
 */
library chrome.proxy;

import 'types.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.proxy` namespace.
 */
final ChromeProxy proxy = new ChromeProxy._();

class ChromeProxy extends ChromeApi {
  JsObject get _proxy => chrome['proxy'];

  /**
   * Notifies about proxy errors.
   */
  Stream<Map> get onProxyError => _onProxyError.stream;
  ChromeStreamController<Map> _onProxyError;

  ChromeProxy._() {
    var getApi = () => _proxy;
    _onProxyError = new ChromeStreamController<Map>.oneArg(getApi, 'onProxyError', mapify);
  }

  bool get available => _proxy != null;

  /**
   * Proxy settings to be used. The value of this setting is a ProxyConfig
   * object.
   */
  ChromeSetting get settings => _createChromeSetting(_proxy['settings']);
}

class Scheme extends ChromeEnum {
  static const Scheme HTTP = const Scheme._('http');
  static const Scheme HTTPS = const Scheme._('https');
  static const Scheme QUIC = const Scheme._('quic');
  static const Scheme SOCKS4 = const Scheme._('socks4');
  static const Scheme SOCKS5 = const Scheme._('socks5');

  static const List<Scheme> VALUES = const[HTTP, HTTPS, QUIC, SOCKS4, SOCKS5];

  const Scheme._(String str): super(str);
}

class Mode extends ChromeEnum {
  static const Mode DIRECT = const Mode._('direct');
  static const Mode AUTO_DETECT = const Mode._('auto_detect');
  static const Mode PAC_SCRIPT = const Mode._('pac_script');
  static const Mode FIXED_SERVERS = const Mode._('fixed_servers');
  static const Mode SYSTEM = const Mode._('system');

  static const List<Mode> VALUES = const[DIRECT, AUTO_DETECT, PAC_SCRIPT, FIXED_SERVERS, SYSTEM];

  const Mode._(String str): super(str);
}

/**
 * An object encapsulating a single proxy server's specification.
 */
class ProxyServer extends ChromeObject {
  ProxyServer({Scheme scheme, String host, int port}) {
    if (scheme != null) this.scheme = scheme;
    if (host != null) this.host = host;
    if (port != null) this.port = port;
  }
  ProxyServer.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The scheme (protocol) of the proxy server itself. Defaults to 'http'.
   */
  Scheme get scheme => _createScheme(this.jsProxy['scheme']);
  set scheme(Scheme value) => this.jsProxy['scheme'] = jsify(value);

  /**
   * The URI of the proxy server. This must be an ASCII hostname (in Punycode
   * format). IDNA is not supported, yet.
   */
  String get host => this.jsProxy['host'];
  set host(String value) => this.jsProxy['host'] = value;

  /**
   * The port of the proxy server. Defaults to a port that depends on the
   * scheme.
   */
  int get port => this.jsProxy['port'];
  set port(int value) => this.jsProxy['port'] = value;
}

/**
 * An object encapsulating the set of proxy rules for all protocols. Use either
 * 'singleProxy' or (a subset of) 'proxyForHttp', 'proxyForHttps', 'proxyForFtp'
 * and 'fallbackProxy'.
 */
class ProxyRules extends ChromeObject {
  ProxyRules({ProxyServer singleProxy, ProxyServer proxyForHttp, ProxyServer proxyForHttps, ProxyServer proxyForFtp, ProxyServer fallbackProxy, List<String> bypassList}) {
    if (singleProxy != null) this.singleProxy = singleProxy;
    if (proxyForHttp != null) this.proxyForHttp = proxyForHttp;
    if (proxyForHttps != null) this.proxyForHttps = proxyForHttps;
    if (proxyForFtp != null) this.proxyForFtp = proxyForFtp;
    if (fallbackProxy != null) this.fallbackProxy = fallbackProxy;
    if (bypassList != null) this.bypassList = bypassList;
  }
  ProxyRules.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The proxy server to be used for all per-URL requests (that is http, https,
   * and ftp).
   */
  ProxyServer get singleProxy => _createProxyServer(this.jsProxy['singleProxy']);
  set singleProxy(ProxyServer value) => this.jsProxy['singleProxy'] = jsify(value);

  /**
   * The proxy server to be used for HTTP requests.
   */
  ProxyServer get proxyForHttp => _createProxyServer(this.jsProxy['proxyForHttp']);
  set proxyForHttp(ProxyServer value) => this.jsProxy['proxyForHttp'] = jsify(value);

  /**
   * The proxy server to be used for HTTPS requests.
   */
  ProxyServer get proxyForHttps => _createProxyServer(this.jsProxy['proxyForHttps']);
  set proxyForHttps(ProxyServer value) => this.jsProxy['proxyForHttps'] = jsify(value);

  /**
   * The proxy server to be used for FTP requests.
   */
  ProxyServer get proxyForFtp => _createProxyServer(this.jsProxy['proxyForFtp']);
  set proxyForFtp(ProxyServer value) => this.jsProxy['proxyForFtp'] = jsify(value);

  /**
   * The proxy server to be used for everthing else or if any of the specific
   * proxyFor... is not specified.
   */
  ProxyServer get fallbackProxy => _createProxyServer(this.jsProxy['fallbackProxy']);
  set fallbackProxy(ProxyServer value) => this.jsProxy['fallbackProxy'] = jsify(value);

  /**
   * List of servers to connect to without a proxy server.
   */
  List<String> get bypassList => listify(this.jsProxy['bypassList']);
  set bypassList(List<String> value) => this.jsProxy['bypassList'] = jsify(value);
}

/**
 * An object holding proxy auto-config information. Exactly one of the fields
 * should be non-empty.
 */
class PacScript extends ChromeObject {
  PacScript({String url, String data, bool mandatory}) {
    if (url != null) this.url = url;
    if (data != null) this.data = data;
    if (mandatory != null) this.mandatory = mandatory;
  }
  PacScript.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * URL of the PAC file to be used.
   */
  String get url => this.jsProxy['url'];
  set url(String value) => this.jsProxy['url'] = value;

  /**
   * A PAC script.
   */
  String get data => this.jsProxy['data'];
  set data(String value) => this.jsProxy['data'] = value;

  /**
   * If true, an invalid PAC script will prevent the network stack from falling
   * back to direct connections. Defaults to false.
   */
  bool get mandatory => this.jsProxy['mandatory'];
  set mandatory(bool value) => this.jsProxy['mandatory'] = value;
}

/**
 * An object encapsulating a complete proxy configuration.
 */
class ProxyConfig extends ChromeObject {
  ProxyConfig({ProxyRules rules, PacScript pacScript, Mode mode}) {
    if (rules != null) this.rules = rules;
    if (pacScript != null) this.pacScript = pacScript;
    if (mode != null) this.mode = mode;
  }
  ProxyConfig.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The proxy rules describing this configuration. Use this for 'fixed_servers'
   * mode.
   */
  ProxyRules get rules => _createProxyRules(this.jsProxy['rules']);
  set rules(ProxyRules value) => this.jsProxy['rules'] = jsify(value);

  /**
   * The proxy auto-config (PAC) script for this configuration. Use this for
   * 'pac_script' mode.
   */
  PacScript get pacScript => _createPacScript(this.jsProxy['pacScript']);
  set pacScript(PacScript value) => this.jsProxy['pacScript'] = jsify(value);

  /**
   * 'direct' = Never use a proxy<br>'auto_detect' = Auto detect proxy
   * settings<br>'pac_script' = Use specified PAC script<br>'fixed_servers' =
   * Manually specify proxy servers<br>'system' = Use system proxy settings
   */
  Mode get mode => _createMode(this.jsProxy['mode']);
  set mode(Mode value) => this.jsProxy['mode'] = jsify(value);
}

ChromeSetting _createChromeSetting(JsObject jsProxy) => jsProxy == null ? null : new ChromeSetting.fromProxy(jsProxy);
Scheme _createScheme(String value) => Scheme.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ProxyServer _createProxyServer(JsObject jsProxy) => jsProxy == null ? null : new ProxyServer.fromProxy(jsProxy);
ProxyRules _createProxyRules(JsObject jsProxy) => jsProxy == null ? null : new ProxyRules.fromProxy(jsProxy);
PacScript _createPacScript(JsObject jsProxy) => jsProxy == null ? null : new PacScript.fromProxy(jsProxy);
Mode _createMode(String value) => Mode.VALUES.singleWhere((ChromeEnum e) => e.value == value);
