/* This file has been generated from context_menus.json - do not edit */

/**
 * Use the `chrome.contextMenus` API to add items to Google Chrome's context
 * menu. You can choose what types of objects your context menu additions apply
 * to, such as images, hyperlinks, and pages.
 */
library chrome.contextMenus;

import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.contextMenus` namespace.
 */
final ChromeContextMenus contextMenus = new ChromeContextMenus._();

class ChromeContextMenus extends ChromeApi {
  static final JsObject _contextMenus = chrome['contextMenus'];

  ChromeContextMenus._();

  bool get available => _contextMenus != null;

  /**
   * Creates a new context menu item. Note that if an error occurs during
   * creation, you may not find out until the creation callback fires (the
   * details will be in chrome.runtime.lastError).
   * 
   * [callback] Called when the item has been created in the browser. If there
   * were any problems creating the item, details will be available in
   * chrome.runtime.lastError.
   * 
   * Returns:
   * The ID of the newly created item.
   */
  dynamic create(ContextMenusCreateParams createProperties, [dynamic callback]) {
    if (_contextMenus == null) _throwNotAvailable();

    return _contextMenus.callMethod('create', [jsify(createProperties), jsify(callback)]);
  }

  /**
   * Updates a previously created context menu item.
   * 
   * [id] The ID of the item to update.
   * 
   * [updateProperties] The properties to update. Accepts the same values as the
   * create function.
   */
  Future update(dynamic id, ContextMenusUpdateParams updateProperties) {
    if (_contextMenus == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _contextMenus.callMethod('update', [jsify(id), jsify(updateProperties), completer.callback]);
    return completer.future;
  }

  /**
   * Removes a context menu item.
   * 
   * [menuItemId] The ID of the context menu item to remove.
   */
  Future remove(dynamic menuItemId) {
    if (_contextMenus == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _contextMenus.callMethod('remove', [jsify(menuItemId), completer.callback]);
    return completer.future;
  }

  /**
   * Removes all context menu items added by this extension.
   */
  Future removeAll() {
    if (_contextMenus == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _contextMenus.callMethod('removeAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a context menu item is clicked.
   */
  Stream<OnClickedEvent> get onClicked => _onClicked.stream;

  final ChromeStreamController<OnClickedEvent> _onClicked =
      new ChromeStreamController<OnClickedEvent>.twoArgs(_contextMenus, 'onClicked', _createOnClickedEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.contextMenus' is not available");
  }
}

/**
 * Fired when a context menu item is clicked.
 */
class OnClickedEvent {
  /**
   * Information about the item clicked and the context where the click
   * happened.
   */
  final OnClickData info;

  /**
   * The details of the tab where the click took place. If the click did not
   * take place in a tab, this parameter will be missing.
   * `optional`
   * 
   * The details of the tab where the click took place. If the click did not
   * take place in a tab, this parameter will be missing.
   */
  final Tab tab;

  OnClickedEvent(this.info, this.tab);
}

/**
 * Information sent when a context menu item is clicked.
 */
class OnClickData extends ChromeObject {
  OnClickData({var menuItemId, var parentMenuItemId, String mediaType, String linkUrl, String srcUrl, String pageUrl, String frameUrl, String selectionText, bool editable, bool wasChecked, bool checked}) {
    if (menuItemId != null) this.menuItemId = menuItemId;
    if (parentMenuItemId != null) this.parentMenuItemId = parentMenuItemId;
    if (mediaType != null) this.mediaType = mediaType;
    if (linkUrl != null) this.linkUrl = linkUrl;
    if (srcUrl != null) this.srcUrl = srcUrl;
    if (pageUrl != null) this.pageUrl = pageUrl;
    if (frameUrl != null) this.frameUrl = frameUrl;
    if (selectionText != null) this.selectionText = selectionText;
    if (editable != null) this.editable = editable;
    if (wasChecked != null) this.wasChecked = wasChecked;
    if (checked != null) this.checked = checked;
  }
  OnClickData.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The ID of the menu item that was clicked.
   */
  dynamic get menuItemId => jsProxy['menuItemId'];
  set menuItemId(var value) => jsProxy['menuItemId'] = jsify(value);

  /**
   * The parent ID, if any, for the item clicked.
   */
  dynamic get parentMenuItemId => jsProxy['parentMenuItemId'];
  set parentMenuItemId(var value) => jsProxy['parentMenuItemId'] = jsify(value);

  /**
   * One of 'image', 'video', or 'audio' if the context menu was activated on
   * one of these types of elements.
   */
  String get mediaType => jsProxy['mediaType'];
  set mediaType(String value) => jsProxy['mediaType'] = value;

  /**
   * If the element is a link, the URL it points to.
   */
  String get linkUrl => jsProxy['linkUrl'];
  set linkUrl(String value) => jsProxy['linkUrl'] = value;

  /**
   * Will be present for elements with a 'src' URL.
   */
  String get srcUrl => jsProxy['srcUrl'];
  set srcUrl(String value) => jsProxy['srcUrl'] = value;

  /**
   * The URL of the page where the menu item was clicked. This property is not
   * set if the click occured in a context where there is no current page, such
   * as in a launcher context menu.
   */
  String get pageUrl => jsProxy['pageUrl'];
  set pageUrl(String value) => jsProxy['pageUrl'] = value;

  /**
   * The URL of the frame of the element where the context menu was clicked, if
   * it was in a frame.
   */
  String get frameUrl => jsProxy['frameUrl'];
  set frameUrl(String value) => jsProxy['frameUrl'] = value;

  /**
   * The text for the context selection, if any.
   */
  String get selectionText => jsProxy['selectionText'];
  set selectionText(String value) => jsProxy['selectionText'] = value;

  /**
   * A flag indicating whether the element is editable (text input, textarea,
   * etc.).
   */
  bool get editable => jsProxy['editable'];
  set editable(bool value) => jsProxy['editable'] = value;

  /**
   * A flag indicating the state of a checkbox or radio item before it was
   * clicked.
   */
  bool get wasChecked => jsProxy['wasChecked'];
  set wasChecked(bool value) => jsProxy['wasChecked'] = value;

  /**
   * A flag indicating the state of a checkbox or radio item after it is
   * clicked.
   */
  bool get checked => jsProxy['checked'];
  set checked(bool value) => jsProxy['checked'] = value;
}

class ContextMenusCreateParams extends ChromeObject {
  ContextMenusCreateParams({String type, String id, String title, bool checked, List<String> contexts, var onclick, var parentId, List<String> documentUrlPatterns, List<String> targetUrlPatterns, bool enabled}) {
    if (type != null) this.type = type;
    if (id != null) this.id = id;
    if (title != null) this.title = title;
    if (checked != null) this.checked = checked;
    if (contexts != null) this.contexts = contexts;
    if (onclick != null) this.onclick = onclick;
    if (parentId != null) this.parentId = parentId;
    if (documentUrlPatterns != null) this.documentUrlPatterns = documentUrlPatterns;
    if (targetUrlPatterns != null) this.targetUrlPatterns = targetUrlPatterns;
    if (enabled != null) this.enabled = enabled;
  }
  ContextMenusCreateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The type of menu item. Defaults to 'normal' if not specified.
   * enum of `normal`, `checkbox`, `radio`, `separator`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  /**
   * The unique ID to assign to this item. Mandatory for event pages. Cannot be
   * the same as another ID for this extension.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The text to be displayed in the item; this is _required_ unless _type_ is
   * 'separator'. When the context is 'selection', you can use `%s` within the
   * string to show the selected text. For example, if this parameter's value is
   * "Translate '%s' to Pig Latin" and the user selects the word "cool", the
   * context menu item for the selection is "Translate 'cool' to Pig Latin".
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * The initial state of a checkbox or radio item: true for selected and false
   * for unselected. Only one radio item can be selected at a time in a given
   * group of radio items.
   */
  bool get checked => jsProxy['checked'];
  set checked(bool value) => jsProxy['checked'] = value;

  /**
   * List of contexts this menu item will appear in. Defaults to ['page'] if not
   * specified. Specifying ['all'] is equivalent to the combination of all other
   * contexts except for 'launcher'. The 'launcher' context is only supported by
   * apps and is used to add menu items to the context menu that appears when
   * clicking on the app icon in the launcher/taskbar/dock/etc. Different
   * platforms might put limitations on what is actually supported in a launcher
   * context menu.
   */
  List<String> get contexts => listify(jsProxy['contexts']);
  set contexts(List<String> value) => jsProxy['contexts'] = jsify(value);

  /**
   * A function that will be called back when the menu item is clicked. Event
   * pages cannot use this; instead, they should register a listener for
   * chrome.contextMenus.onClicked.
   */
  dynamic get onclick => jsProxy['onclick'];
  set onclick(var value) => jsProxy['onclick'] = jsify(value);

  /**
   * The ID of a parent menu item; this makes the item a child of a previously
   * added item.
   */
  dynamic get parentId => jsProxy['parentId'];
  set parentId(var value) => jsProxy['parentId'] = jsify(value);

  /**
   * Lets you restrict the item to apply only to documents whose URL matches one
   * of the given patterns. (This applies to frames as well.) For details on the
   * format of a pattern, see [Match Patterns](match_patterns.html).
   */
  List<String> get documentUrlPatterns => listify(jsProxy['documentUrlPatterns']);
  set documentUrlPatterns(List<String> value) => jsProxy['documentUrlPatterns'] = jsify(value);

  /**
   * Similar to documentUrlPatterns, but lets you filter based on the src
   * attribute of img/audio/video tags and the href of anchor tags.
   */
  List<String> get targetUrlPatterns => listify(jsProxy['targetUrlPatterns']);
  set targetUrlPatterns(List<String> value) => jsProxy['targetUrlPatterns'] = jsify(value);

  /**
   * Whether this context menu item is enabled or disabled. Defaults to true.
   */
  bool get enabled => jsProxy['enabled'];
  set enabled(bool value) => jsProxy['enabled'] = value;
}

class ContextMenusUpdateParams extends ChromeObject {
  ContextMenusUpdateParams({String type, String title, bool checked, List<String> contexts, var onclick, var parentId, List<String> documentUrlPatterns, List<String> targetUrlPatterns, bool enabled}) {
    if (type != null) this.type = type;
    if (title != null) this.title = title;
    if (checked != null) this.checked = checked;
    if (contexts != null) this.contexts = contexts;
    if (onclick != null) this.onclick = onclick;
    if (parentId != null) this.parentId = parentId;
    if (documentUrlPatterns != null) this.documentUrlPatterns = documentUrlPatterns;
    if (targetUrlPatterns != null) this.targetUrlPatterns = targetUrlPatterns;
    if (enabled != null) this.enabled = enabled;
  }
  ContextMenusUpdateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * enum of `normal`, `checkbox`, `radio`, `separator`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  bool get checked => jsProxy['checked'];
  set checked(bool value) => jsProxy['checked'] = value;

  List<String> get contexts => listify(jsProxy['contexts']);
  set contexts(List<String> value) => jsProxy['contexts'] = jsify(value);

  dynamic get onclick => jsProxy['onclick'];
  set onclick(var value) => jsProxy['onclick'] = jsify(value);

  /**
   * Note: You cannot change an item to be a child of one of its own
   * descendants.
   */
  dynamic get parentId => jsProxy['parentId'];
  set parentId(var value) => jsProxy['parentId'] = jsify(value);

  List<String> get documentUrlPatterns => listify(jsProxy['documentUrlPatterns']);
  set documentUrlPatterns(List<String> value) => jsProxy['documentUrlPatterns'] = jsify(value);

  List<String> get targetUrlPatterns => listify(jsProxy['targetUrlPatterns']);
  set targetUrlPatterns(List<String> value) => jsProxy['targetUrlPatterns'] = jsify(value);

  bool get enabled => jsProxy['enabled'];
  set enabled(bool value) => jsProxy['enabled'] = value;
}

OnClickedEvent _createOnClickedEvent(JsObject info, JsObject tab) =>
    new OnClickedEvent(_createOnClickData(info), _createTab(tab));
OnClickData _createOnClickData(JsObject jsProxy) => jsProxy == null ? null : new OnClickData.fromProxy(jsProxy);
Tab _createTab(JsObject jsProxy) => jsProxy == null ? null : new Tab.fromProxy(jsProxy);
