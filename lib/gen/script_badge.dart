/* This file has been generated from script_badge.json - do not edit */

/**
 * Use the `chrome.scriptBadge` API to control the behaviour of the script
 * badge.
 */
library chrome.scriptBadge;

import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.scriptBadge` namespace.
 */
final ChromeScriptBadge scriptBadge = new ChromeScriptBadge._();

class ChromeScriptBadge extends ChromeApi {
  static final JsObject _scriptBadge = chrome['scriptBadge'];

  ChromeScriptBadge._();

  bool get available => _scriptBadge != null;

  /**
   * Sets the html document to be opened as a popup when the user clicks on the
   * script badge's icon.
   */
  void setPopup(ScriptBadgeSetPopupParams details) {
    if (_scriptBadge == null) _throwNotAvailable();

    _scriptBadge.callMethod('setPopup', [jsify(details)]);
  }

  /**
   * Gets the html document set as the popup for this script badge.
   */
  Future<String> getPopup(ScriptBadgeGetPopupParams details) {
    if (_scriptBadge == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _scriptBadge.callMethod('getPopup', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Brings the script badge to the attention of the user, imploring her to
   * click.  You should call this when you detect that you can do something to a
   * particular tab.  Do not call this for every tab. That's tacky.  If the user
   * clicks on the badge, the activeTab APIs become available. If the extension
   * has already run on this tab, this call does nothing.
   */
  void getAttention(ScriptBadgeGetAttentionParams details) {
    if (_scriptBadge == null) _throwNotAvailable();

    _scriptBadge.callMethod('getAttention', [jsify(details)]);
  }

  /**
   * Fired when a script badge icon is clicked.  This event will not fire if the
   * script badge has a popup.
   */
  Stream<Tab> get onClicked => _onClicked.stream;

  final ChromeStreamController<Tab> _onClicked =
      new ChromeStreamController<Tab>.oneArg(_scriptBadge, 'onClicked', _createTab);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.scriptBadge' is not available");
  }
}

class ScriptBadgeSetPopupParams extends ChromeObject {
  ScriptBadgeSetPopupParams({int tabId, String popup}) {
    if (tabId != null) this.tabId = tabId;
    if (popup != null) this.popup = popup;
  }
  ScriptBadgeSetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The id of the tab for which you want to modify the script badge.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;

  /**
   * The html file to show in a popup.  If set to the empty string (''), no
   * popup is shown.
   */
  String get popup => jsProxy['popup'];
  set popup(String value) => jsProxy['popup'] = value;
}

class ScriptBadgeGetPopupParams extends ChromeObject {
  ScriptBadgeGetPopupParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  ScriptBadgeGetPopupParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to get the popup from.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

class ScriptBadgeGetAttentionParams extends ChromeObject {
  ScriptBadgeGetAttentionParams({int tabId}) {
    if (tabId != null) this.tabId = tabId;
  }
  ScriptBadgeGetAttentionParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Specify the tab to request to act on.
   */
  int get tabId => jsProxy['tabId'];
  set tabId(int value) => jsProxy['tabId'] = value;
}

Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
