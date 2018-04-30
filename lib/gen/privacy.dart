/* This file has been generated from privacy.json - do not edit */

/**
 * Use the `chrome.privacy` API to control usage of the features in Chrome that
 * can affect a user's privacy. This API relies on the [ChromeSetting prototype
 * of the type API](types#ChromeSetting) for getting and setting Chrome's
 * configuration.
 */
library chrome.privacy;

import 'types.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.privacy` namespace.
 */
final ChromePrivacy privacy = new ChromePrivacy._();

class ChromePrivacy extends ChromeApi {
  JsObject get _privacy => chrome['privacy'];

  ChromePrivacy._();

  bool get available => _privacy != null;

  /**
   * Settings that influence Chrome's handling of network connections in
   * general.
   */
  NetworkPrivacy get network => _createNetworkPrivacy(_privacy['network']);

  /**
   * Settings that enable or disable features that require third-party network
   * services provided by Google and your default search provider.
   */
  ServicesPrivacy get services => _createServicesPrivacy(_privacy['services']);

  /**
   * Settings that determine what information Chrome makes available to
   * websites.
   */
  WebsitesPrivacy get websites => _createWebsitesPrivacy(_privacy['websites']);
}

/**
 * The IP handling policy of WebRTC.
 */
class IPHandlingPolicy extends ChromeEnum {
  static const IPHandlingPolicy DEFAULT = const IPHandlingPolicy._('default');
  static const IPHandlingPolicy DEFAULT_PUBLIC_AND_PRIVATE_INTERFACES = const IPHandlingPolicy._('default_public_and_private_interfaces');
  static const IPHandlingPolicy DEFAULT_PUBLIC_INTERFACE_ONLY = const IPHandlingPolicy._('default_public_interface_only');
  static const IPHandlingPolicy DISABLE_NON_PROXIED_UDP = const IPHandlingPolicy._('disable_non_proxied_udp');

  static const List<IPHandlingPolicy> VALUES = const[DEFAULT, DEFAULT_PUBLIC_AND_PRIVATE_INTERFACES, DEFAULT_PUBLIC_INTERFACE_ONLY, DISABLE_NON_PROXIED_UDP];

  const IPHandlingPolicy._(String str): super(str);
}

class NetworkPrivacy extends ChromeObject {
  NetworkPrivacy();
  NetworkPrivacy.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If enabled, Chrome attempts to speed up your web browsing experience by
   * pre-resolving DNS entries and preemptively opening TCP and SSL connections
   * to servers. This preference only affects actions taken by Chrome's internal
   * prediction service. It does not affect webpage-initiated prefectches or
   * preconnects. This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get networkPredictionEnabled => _createChromeSetting(jsProxy['networkPredictionEnabled']);

  /**
   * If enabled, Chrome will explore all possible routing options when using
   * WebRTC to find the most performant path, possibly exposing user's private
   * IP address. Otherwise, WebRTC traffic will be routed the same way as
   * regular HTTP. This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get webRTCMultipleRoutesEnabled => _createChromeSetting(jsProxy['webRTCMultipleRoutesEnabled']);

  /**
   * If enabled, Chrome is allowed to use non-proxied UDP to connect to peers or
   * TURN servers when using WebRTC. Since most proxy servers don't handle UDP,
   * using UDP possibly exposes user's IP address. Turning this off effectively
   * forces WebRTC to only use TCP for now, until UDP proxy support is available
   * in Chrome and such proxies are widely deployed. As a result, it also might
   * hurt media performance and increase the load for proxy servers. This
   * preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get webRTCNonProxiedUdpEnabled => _createChromeSetting(jsProxy['webRTCNonProxiedUdpEnabled']);

  /**
   * Allow users to specify the media performance/privacy tradeoffs which
   * impacts how WebRTC traffic will be routed and how much local address
   * information is exposed. This preference's value is of type
   * IPHandlingPolicy, defaulting to `default`.
   */
  ChromeSetting get webRTCIPHandlingPolicy => _createChromeSetting(jsProxy['webRTCIPHandlingPolicy']);
}

class ServicesPrivacy extends ChromeObject {
  ServicesPrivacy();
  ServicesPrivacy.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If enabled, Chrome uses a web service to help resolve navigation errors.
   * This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get alternateErrorPagesEnabled => _createChromeSetting(jsProxy['alternateErrorPagesEnabled']);

  /**
   * If enabled, Chrome offers to automatically fill in forms. This preference's
   * value is a boolean, defaulting to `true`.
   */
  ChromeSetting get autofillEnabled => _createChromeSetting(jsProxy['autofillEnabled']);

  /**
   * If enabled, the password manager will ask if you want to save passwords.
   * This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get passwordSavingEnabled => _createChromeSetting(jsProxy['passwordSavingEnabled']);

  /**
   * If enabled, Chrome does its best to protect you from phishing and malware.
   * This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get safeBrowsingEnabled => _createChromeSetting(jsProxy['safeBrowsingEnabled']);

  /**
   * If enabled, Chrome will send additional information to Google when
   * SafeBrowsing blocks a page, such as the content of the blocked page. This
   * preference's value is a boolean, defaulting to `false`.
   */
  ChromeSetting get safeBrowsingExtendedReportingEnabled => _createChromeSetting(jsProxy['safeBrowsingExtendedReportingEnabled']);

  /**
   * If enabled, Chrome sends the text you type into the Omnibox to your default
   * search engine, which provides predictions of websites and searches that are
   * likely completions of what you've typed so far. This preference's value is
   * a boolean, defaulting to `true`.
   */
  ChromeSetting get searchSuggestEnabled => _createChromeSetting(jsProxy['searchSuggestEnabled']);

  /**
   * If enabled, Chrome uses a web service to help correct spelling errors. This
   * preference's value is a boolean, defaulting to `false`.
   */
  ChromeSetting get spellingServiceEnabled => _createChromeSetting(jsProxy['spellingServiceEnabled']);

  /**
   * If enabled, Chrome offers to translate pages that aren't in a language you
   * read. This preference's value is a boolean, defaulting to `true`.
   */
  ChromeSetting get translationServiceEnabled => _createChromeSetting(jsProxy['translationServiceEnabled']);
}

class WebsitesPrivacy extends ChromeObject {
  WebsitesPrivacy();
  WebsitesPrivacy.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If disabled, Chrome blocks third-party sites from setting cookies. The
   * value of this preference is of type boolean, and the default value is
   * `true`.
   */
  ChromeSetting get thirdPartyCookiesAllowed => _createChromeSetting(jsProxy['thirdPartyCookiesAllowed']);

  /**
   * If enabled, Chrome sends auditing pings when requested by a website (`<a
   * ping>`). The value of this preference is of type boolean, and the default
   * value is `true`.
   */
  ChromeSetting get hyperlinkAuditingEnabled => _createChromeSetting(jsProxy['hyperlinkAuditingEnabled']);

  /**
   * If enabled, Chrome sends `referer` headers with your requests. Yes, the
   * name of this preference doesn't match the misspelled header. No, we're not
   * going to change it. The value of this preference is of type boolean, and
   * the default value is `true`.
   */
  ChromeSetting get referrersEnabled => _createChromeSetting(jsProxy['referrersEnabled']);

  /**
   * If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your
   * requests. The value of this preference is of type boolean, and the default
   * value is `false`.
   */
  ChromeSetting get doNotTrackEnabled => _createChromeSetting(jsProxy['doNotTrackEnabled']);

  /**
   * *Available on Windows and ChromeOS only*: If enabled, Chrome provides a
   * unique ID to plugins in order to run protected content. The value of this
   * preference is of type boolean, and the default value is `true`.
   */
  ChromeSetting get protectedContentEnabled => _createChromeSetting(jsProxy['protectedContentEnabled']);
}

NetworkPrivacy _createNetworkPrivacy(JsObject jsProxy) => jsProxy == null ? null : new NetworkPrivacy.fromProxy(jsProxy);
ServicesPrivacy _createServicesPrivacy(JsObject jsProxy) => jsProxy == null ? null : new ServicesPrivacy.fromProxy(jsProxy);
WebsitesPrivacy _createWebsitesPrivacy(JsObject jsProxy) => jsProxy == null ? null : new WebsitesPrivacy.fromProxy(jsProxy);
ChromeSetting _createChromeSetting(JsObject jsProxy) => jsProxy == null ? null : new ChromeSetting.fromProxy(jsProxy);
