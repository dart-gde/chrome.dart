library chrome.browser_action;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'tabs.dart';

final BrowserAction browserAction = new BrowserAction._();

class BrowserAction {

  BrowserAction._();

  js.Proxy get _browserAction => js.context.chrome.browserAction;

  /**
   * Sets the title of the browser action. This shows up in the tooltip.
   *
   * @param title The string the browser action should display when moused over.
   * @param tabId Limits the change to when a particular tab is selected.
   *              Automatically resets when the tab is closed.
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
   * @param tabId Specify the tab to get the title from. If no tab is specified,
   *              the non-tab-specific title is returned.
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
   * @param popup The html file to show in a popup. If set to the empty string
   *              (''), no popup is shown.
   * @param tabId Limits the change to when a particular tab is selected.
   *              Automatically resets when the tab is closed.
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
   * @param tabId Specify the tab to get the popup from. If no tab is specified,
   *              the non-tab-specific popup is returned.
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
   * of the icon.
   *
   * @param text Any number of characters can be passed, but only about four
   *             can fit in the space.
   * @param tabId Limits the change to when a particular tab is selected.
   *              Automatically resets when the tab is closed.
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
   * Gets the badge text of the browser action. If no tab is specified, the
   * non-tab-specific badge text is returned.
   *
   * @param tabId Specify the tab to get the badge text from. If no tab is
   *              specified, the non-tab-specific badge text is returned.
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
   * @param color The RGBA color of the badge.
   * @param tabId Limits the change to when a particular tab is selected.
   *              Automatically resets when the tab is closed.
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
   * @param tabId Specify the tab to get the badge background color from. If no
   *               tab is specified, the non-tab-specific badge background
   *               color is returned.
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
   * @param tabId The id of the tab for which you want to modify the browser
   *              action.
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
   * @param tabId The id of the tab for which you want to modify the browser
   *              action.
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
          () => js.context.chrome.browserAction.onClicked,
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
