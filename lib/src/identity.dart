library chrome.identity;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'common.dart';

/**
 * Use the [chromeIdentity] API to get OAuth2 access tokens.
 */
const ChromeIdentity chromeIdentity = const ChromeIdentity._();

/**
 * Description:  Use the chrome.identity API to get OAuth2 access tokens.
 * Availability: Beta and dev channels only.
 * Permissions:   "identity"
 * Learn More:  Identify User https://developer.chrome.com/apps/app_identity.html
 */
class ChromeIdentity {
  const ChromeIdentity._();

  /**
   * Gets an OAuth2 access token using the client ID and scopes specified in
   * the oauth2 section of manifest.json. The Identity API caches access tokens
   * in memory, so it's ok to call getAuthToken any time a token is required.
   * The token cache automatically handles expiration.
   *
   * [interactive] ( optional boolean )
   * Fetching a token may require the user to sign-in to Chrome, or approve
   * the application's requested scopes. If the interactive flag is true,
   * [getAuthToken] will prompt the user as necessary. When the flag is false
   * or ommitted, getAuthToken will return failure any time a prompt would be
   * required.
   *
   * Future completes with an OAuth2 access token as specified by the manifest,
   * or undefined if there was an error.
   */
  Future<String> getAuthToken({bool interactive: false}) {
    ChromeCompleter completer = new ChromeCompleter.oneArg();

    js.scoped(() {
      chromeProxy.identity
        .getAuthToken(js.map({'interactive': interactive}), completer.callback);
    });

    return completer.future;
  }

  /**
   * Removes an OAuth2 access token from the Identity API's token cache.
   *
   * If an access token is discovered to be invalid, it should be passed to
   * [removeCachedAuthToken] to remove it from the cache. The app may then
   * retrieve a fresh token with [getAuthToken].
   *
   * [token] ( string ) The specific token that should be removed from the cache.
   *
   * Future completes when the token has been removed from the cache.
   */
  Future removeCachedAuthToken(String token) {
    ChromeCompleter completer = new ChromeCompleter.noArgs();

    js.scoped(() {
      chromeProxy.identity
        .removeCachedAuthToken(js.map({'token': token}), completer.callback);
    });

    return completer.future;
  }

  /**
   * Starts an auth flow at the specified URL.
   *
   * This method enables auth flows with non-Google identity providers by
   * launching a web view and navigating it to the first URL in the provider's
   * auth flow. When the provider redirects to a URL matching the pattern
   * https://<app-id>.chromiumapp.org/\*, the window will close, and the final
   * redirect URL will be passed to the callback function.
   *
   * [url] ( string ) The URL that initiates the auth flow.
   *
   * [interactive] ( optional boolean ) Whether to launch auth flow in
   * interactive mode.
   *
   * Since some auth flows may immediately redirect to a result URL,
   * [launchWebAuthFlow] hides its web view until the first navigation either
   * redirects to the final URL, or finishes loading a page meant to be
   * displayed.
   *
   * If the [interactive] flag is true, the window will be displayed when a page
   * load completes. If the flag is false or ommitted, [launchWebAuthFlow] will
   * return with an error if the initial navigation does not complete the flow.
   *
   * Future completes with the URL redirected back to your application.
   */
  Future<String> launchWebAuthFlow(String url, {bool interactive: false}) {
    ChromeCompleter completer = new ChromeCompleter.oneArg();

    js.scoped(() {
      chromeProxy.identity
        .launchWebAuthFlow(js.map({'url': url, 'interactive': interactive}),
            completer.callback);
    });

    return completer.future;
  }

}