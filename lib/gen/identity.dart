/* This file has been generated from identity.idl - do not edit */

/**
 * Use the `chrome.identity` API to get OAuth2 access tokens.
 */
library chrome.identity;

import '../src/common.dart';

/**
 * Accessor for the `chrome.identity` namespace.
 */
final ChromeIdentity identity = new ChromeIdentity._();

class ChromeIdentity extends ChromeApi {
  static final JsObject _identity = chrome['identity'];

  ChromeIdentity._();

  bool get available => _identity != null;

  /**
   * Gets an OAuth2 access token using the client ID and scopes specified in the
   * <a href="app_identity.html#update_manifest">`oauth2` section of
   * manifest.json</a>.
   * 
   * The Identity API caches access tokens in memory, so it's ok to call
   * `getAuthToken` any time a token is required. The token cache automatically
   * handles expiration.
   * 
   * [details]: Token options.
   * [callback]: Called with an OAuth2 access token as specified by the
   * manifest, or undefined if there was an error.
   */
  Future<String> getAuthToken([TokenDetails details]) {
    if (_identity == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _identity.callMethod('getAuthToken', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Removes an OAuth2 access token from the Identity API's token cache.
   * 
   * If an access token is discovered to be invalid, it should be passed to
   * removeCachedAuthToken to remove it from the cache. The app may then
   * retrieve a fresh token with `getAuthToken`.
   * 
   * [details]: Token information.
   * [callback]: Called when the token has been removed from the cache.
   */
  Future removeCachedAuthToken(InvalidTokenDetails details) {
    if (_identity == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _identity.callMethod('removeCachedAuthToken', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Starts an auth flow at the specified URL.
   * 
   * This method enables auth flows with non-Google identity providers by
   * launching a web view and navigating it to the first URL in the provider's
   * auth flow. When the provider redirects to a URL matching the pattern
   * `https://&lt;app-id&gt;.chromiumapp.org/`, the window will close, and the
   * final redirect URL will be passed to the [callback] function.
   * 
   * [details]: WebAuth flow options.
   * [callback]: Called with the URL redirected back to your application.
   */
  Future<String> launchWebAuthFlow(WebAuthFlowDetails details) {
    if (_identity == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _identity.callMethod('launchWebAuthFlow', [jsify(details), completer.callback]);
    return completer.future;
  }

  Stream<OnSignInChangedEvent> get onSignInChanged => _onSignInChanged.stream;

  final ChromeStreamController<OnSignInChangedEvent> _onSignInChanged =
      new ChromeStreamController<OnSignInChangedEvent>.twoArgs(_identity, 'onSignInChanged', _createOnSignInChangedEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.identity' is not available");
  }
}

class OnSignInChangedEvent {
  final AccountInfo account;

  final bool signedIn;

  OnSignInChangedEvent(this.account, this.signedIn);
}

class TokenDetails extends ChromeObject {
  TokenDetails({bool interactive}) {
    if (interactive != null) this.interactive = interactive;
  }
  TokenDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get interactive => jsProxy['interactive'];
  set interactive(bool value) => jsProxy['interactive'] = value;
}

class InvalidTokenDetails extends ChromeObject {
  InvalidTokenDetails({String token}) {
    if (token != null) this.token = token;
  }
  InvalidTokenDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get token => jsProxy['token'];
  set token(String value) => jsProxy['token'] = value;
}

class WebAuthFlowDetails extends ChromeObject {
  WebAuthFlowDetails({String url, bool interactive}) {
    if (url != null) this.url = url;
    if (interactive != null) this.interactive = interactive;
  }
  WebAuthFlowDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  bool get interactive => jsProxy['interactive'];
  set interactive(bool value) => jsProxy['interactive'] = value;
}

class AccountInfo extends ChromeObject {
  AccountInfo({String id}) {
    if (id != null) this.id = id;
  }
  AccountInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;
}

OnSignInChangedEvent _createOnSignInChangedEvent(JsObject account, bool signedIn) =>
    new OnSignInChangedEvent(_createAccountInfo(account), signedIn);
AccountInfo _createAccountInfo(JsObject jsProxy) => jsProxy == null ? null : new AccountInfo.fromProxy(jsProxy);
