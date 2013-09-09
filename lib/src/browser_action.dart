library chrome.browser_action;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'tabs.dart';

/// accessor for the `chrome.browserAction` namespace.
final BrowserAction browserAction = new BrowserAction._();

/**
 * Encapsulation of the `chrome.browserAction` namespace.
 * The single instance of this class is accessed from the [browserAction]
 * getter.
 */
class BrowserAction {

  BrowserAction._();

  get _browserAction => chromeProxy.browserAction;

  /**
   * Sets the [title] of the browser action. This shows up in the tooltip.
   *
   * If no [tabId] is specified, the non-tab-specific title is set.
   */
  void setTitle(String title, {int tabId}) {
    var details = { 'title': title };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    js.scoped(() {
      _browserAction.setTitle(js.map(details));
    });
  }

  /**
   * Gets the title of the browser action.
   *
   * If no [tabId] is specified, the non-tab-specific title is returned.
   */
  Future<String> getTitle({int tabId}) {
    var details = { };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    var completer =
        new ChromeCompleter.oneArg();
    js.scoped(() {
      _browserAction.getTitle(js.map(details), completer.callback);
    });
    return completer.future;
  }

  /**
   * Sets the html document to be opened as a popup when the user clicks on the
   * browser action's icon.
   *
   * If [popup] is '', then no popup is shown.
   *
   * If no [tabId] is specified, the non-tab-specific popup is set.
   */
  void setPopup(String popup, {int tabId}) {
    var details = { 'popup': popup };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    js.scoped(() {
      _browserAction.setPopup(js.map(details));
    });
  }

  /**
   * Gets the html document set as the popup for this browser action.
   *
   * If no [tabId] is specified, the non-tab-specific popup is returned.
   */
  Future<String> getPopup({int tabId}) {
    var details = { };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    var completer =
        new ChromeCompleter.oneArg();
    js.scoped(() {
      _browserAction.getPopup(js.map(details), completer.callback);
    });
    return completer.future;
  }

  /**
   * Sets the badge text for the browser action. The badge is displayed on top
   * of the icon. Any number of characters can be passed, but only about four
   * can fit in the space.
   *
   * If no [tabId] is specified, the non-tab-specific badge test is set.
   */
  void setBadgeText(String text, {int tabId}) {
    var details = { 'text': text };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    js.scoped(() {
      _browserAction.setBadgeText(js.map(details));
    });
  }

  /**
   * Gets the badge text of the browser action.
   *
   * If no [tabId] is specified, the non-tab-specific badge text is returned.
   */
  Future<String> getBadgeText({int tabId}) {
    var details = { };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    var completer =
        new ChromeCompleter.oneArg();
    js.scoped(() {
      _browserAction.getBadgeText(js.map(details), completer.callback);
    });
    return completer.future;
  }

  /**
   * Sets the background color for the badge.
   *
   * If no [tabId] is specified, the non-tab-specific background color is set.
   */
  void setBadgeBackgroundColor(Color color, {int tabId}) {
    var details = { 'color': color.toArray() };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    js.scoped(() {
      _browserAction.setBadgeBackgroundColor(js.map(details));
    });
  }

  /**
   * Gets the background color of the browser action.
   *
   * If no [tabId] is specified, the non-tab-specific background color is
   * returned.
   */
  Future<Color> getBadgeBackgroundColor({int tabId}) {
    var details = { };
    if (tabId != null) {
      details['tabId'] = tabId;
    }
    var completer = new ChromeCompleter.oneArg((color) =>
        new Color(color[0], color[1], color[2], color[3]));
    js.scoped(() {
      _browserAction.getBadgeBackgroundColor(js.map(details), completer.callback);
    });
    return completer.future;
  }

  /**
   * Enables the browser action for a tab. By default, browser actions are
   * enabled.
   *
   * If no [tabId] is specified, the browser action is disabled for all tabs.
   */
  void enable({int tabId}) {
    js.scoped(() {
      if (tabId == null) {
        _browserAction.enable();
      } else {
        _browserAction.enable(tabId);
      }
    });
  }

  /**
   * Disables the browser action for a tab.
   *
   * If no [tabId] is specified, the browser action is enabled for all tabs.
   */
  void disable({int tabId}) {
    js.scoped(() {
      if (tabId == null) {
        _browserAction.disable();
      } else {
        _browserAction.disable(tabId);
      }
    });
  }

  final ChromeStreamController<Tab> _onClicked =
      new ChromeStreamController<Tab>.oneArg(
          () => chromeProxy.browserAction.onClicked,
          (tab) =>
              new Tab(tab));

  /**
   * Fired when a browser action icon is clicked. This event will not fire if
   * the browser action has a popup.
   */
  Stream<Tab> get onClicked => _onClicked.stream;
}

class Color {
  final int _red;
  final int _green;
  final int _blue;
  final int _alpha;

  const Color(this._red, this._green, this._blue, this._alpha);

  int get red => _red.clamp(0, 255);

  int get green => _green.clamp(0, 255);

  int get blue => _blue.clamp(0, 255);

  int get alpha => _alpha.clamp(0, 255);

  List<int> toArray() {
    return [ red, green, blue, alpha ];
  }

  String toString() {
    return toArray().toString();
  }

  bool operator ==(Color color) {
    return red == color.red &&
        green == color.green &&
        blue == color.blue &&
        alpha == color.alpha;
  }

  int get hashCode => red + green * 3 + blue * 5 + alpha * 7;
}
