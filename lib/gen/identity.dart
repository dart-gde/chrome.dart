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
  JsObject get _identity => chrome['identity'];

  Stream<OnSignInChangedEvent> get onSignInChanged => _onSignInChanged.stream;
  ChromeStreamController<OnSignInChangedEvent> _onSignInChanged;

  ChromeIdentity._() {
    var getApi = () => _identity;
    _onSignInChanged = new ChromeStreamController<OnSignInChangedEvent>.twoArgs(getApi, 'onSignInChanged', _createOnSignInChangedEvent);
  }

  bool get available => _identity != null;

  /**
   * Retrieves a list of AccountInfo objects describing the accounts present on
   * the profile.
   * 
   * `getAccounts` is only supported on dev channel.
   */
  Future<List<AccountInfo>> getAccounts() {
    if (_identity == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<AccountInfo>>.oneArg((e) => listify(e, _createAccountInfo));
    _identity.callMethod('getAccounts', [completer.callback]);
    return completer.future;
  }

  /**
   * Gets an OAuth2 access token using the client ID and scopes specified in the
   * <a href="app_identity.html#update_manifest">`oauth2` section of
   * manifest.json</a>.
   * 
   * The Identity API caches access tokens in memory, so it's ok to call
   * `getAuthToken` non-interactively any time a token is required. The token
   * cache automatically handles expiration.
   * 
   * For a good user experience it is important interactive token requests are
   * initiated by UI in your app explaining what the authorization is for.
   * Failing to do this will cause your users to get authorization requests, or
   * Chrome sign in screens if they are not signed in, with with no context. In
   * particular, do not use `getAuthToken` interactively when your app is first
   * launched.
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
   * Retrieves email address and obfuscated gaia id of the user signed into a
   * profile.
   * 
   * This API is different from identity.getAccounts in two ways. The
   * information returned is available offline, and it only applies to the
   * primary account for the profile.
   */
  Future<ProfileUserInfo> getProfileUserInfo() {
    if (_identity == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ProfileUserInfo>.oneArg(_createProfileUserInfo);
    _identity.callMethod('getProfileUserInfo', [completer.callback]);
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
   * `https://<app-id>.chromiumapp.org/`, the window will close, and the final
   * redirect URL will be passed to the [callback] function.
   * 
   * For a good user experience it is important interactive auth flows are
   * initiated by UI in your app explaining what the authorization is for.
   * Failing to do this will cause your users to get authorization requests with
   * no context. In particular, do not launch an interactive auth flow when your
   * app is first launched.
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

  /**
   * Generates a redirect URL to be used in [launchWebAuthFlow].
   * 
   * The generated URLs match the pattern `https://<app-id>.chromiumapp.org/`.
   * 
   * [path]: The path appended to the end of the generated URL.
   */
  String getRedirectURL([String path]) {
    if (_identity == null) _throwNotAvailable();

    return _identity.callMethod('getRedirectURL', [path]);
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.identity' is not available");
  }
}

class OnSignInChangedEvent {
  final AccountInfo account;

  final bool signedIn;

  OnSignInChangedEvent(this.account, this.signedIn);
}

class AccountInfo extends ChromeObject {
  AccountInfo({String id}) {
    if (id != null) this.id = id;
  }
  AccountInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;
}

class ProfileUserInfo extends ChromeObject {
  ProfileUserInfo({String email, String id}) {
    if (email != null) this.email = email;
    if (id != null) this.id = id;
  }
  ProfileUserInfo.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get email => jsProxy['email'];
  set email(String value) => jsProxy['email'] = value;

  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;
}

class TokenDetails extends ChromeObject {
  TokenDetails({bool interactive, AccountInfo account, List<String> scopes}) {
    if (interactive != null) this.interactive = interactive;
    if (account != null) this.account = account;
    if (scopes != null) this.scopes = scopes;
  }
  TokenDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  bool get interactive => jsProxy['interactive'];
  set interactive(bool value) => jsProxy['interactive'] = value;

  AccountInfo get account => _createAccountInfo(jsProxy['account']);
  set account(AccountInfo value) => jsProxy['account'] = jsify(value);

  List<String> get scopes => listify(jsProxy['scopes']);
  set scopes(List<String> value) => jsProxy['scopes'] = jsify(value);
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

OnSignInChangedEvent _createOnSignInChangedEvent(JsObject account, bool signedIn) =>
    new OnSignInChangedEvent(_createAccountInfo(account), signedIn);
AccountInfo _createAccountInfo(JsObject jsProxy) => jsProxy == null ? null : new AccountInfo.fromProxy(jsProxy);
ProfileUserInfo _createProfileUserInfo(JsObject jsProxy) => jsProxy == null ? null : new ProfileUserInfo.fromProxy(jsProxy);
