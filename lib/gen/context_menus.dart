/* This file has been generated from context_menus.json - do not edit */

/**
 * Use the `chrome.contextMenus` API to add items to Google Chrome's context
 * menu. You can choose what types of objects your context menu additions apply
 * to, such as images, hyperlinks, and pages.
 */
library chrome.contextMenus;

//import 'context_menus_internal.dart';
//import 'tabs.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.contextMenus` namespace.
 */
final ChromeContextMenus contextMenus = new ChromeContextMenus._();

class ChromeContextMenus extends ChromeApi {
  JsObject get _contextMenus => chrome['contextMenus'];

  Stream get onClicked => _onClicked.stream;
  ChromeStreamController _onClicked;

  ChromeContextMenus._() {
    var getApi = () => _contextMenus;
    _onClicked = new ChromeStreamController.noArgs(getApi, 'onClicked');
  }

  bool get available => _contextMenus != null;

  /**
   * The maximum number of top level extension items that can be added to an
   * extension action context menu. Any items beyond this limit will be ignored.
   */
  int get ACTION_MENU_TOP_LEVEL_LIMIT => _contextMenus['ACTION_MENU_TOP_LEVEL_LIMIT'];

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

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.contextMenus' is not available");
  }
}

/**
 * The different contexts a menu can appear in. Specifying 'all' is equivalent
 * to the combination of all other contexts except for 'launcher'. The
 * 'launcher' context is only supported by apps and is used to add menu items to
 * the context menu that appears when clicking on the app icon in the
 * launcher/taskbar/dock/etc. Different platforms might put limitations on what
 * is actually supported in a launcher context menu.
 * enum of `all`, `page`, `frame`, `selection`, `link`, `editable`, `image`,
 * `video`, `audio`, `launcher`, `browser_action`, `page_action`
 */
class ContextType extends ChromeObject {
  ContextType();
  ContextType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * The type of menu item.
 * enum of `normal`, `checkbox`, `radio`, `separator`
 */
class ItemType extends ChromeObject {
  ItemType();
  ItemType.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

class ContextMenusCreateParams extends ChromeObject {
  ContextMenusCreateParams({ItemType type, String id, String title, bool checked, List<ContextType> contexts, var parentId, List<String> documentUrlPatterns, List<String> targetUrlPatterns, bool enabled}) {
    if (type != null) this.type = type;
    if (id != null) this.id = id;
    if (title != null) this.title = title;
    if (checked != null) this.checked = checked;
    if (contexts != null) this.contexts = contexts;
    if (parentId != null) this.parentId = parentId;
    if (documentUrlPatterns != null) this.documentUrlPatterns = documentUrlPatterns;
    if (targetUrlPatterns != null) this.targetUrlPatterns = targetUrlPatterns;
    if (enabled != null) this.enabled = enabled;
  }
  ContextMenusCreateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The type of menu item. Defaults to 'normal' if not specified.
   */
  ItemType get type => _createItemType(jsProxy['type']);
  set type(ItemType value) => jsProxy['type'] = jsify(value);

  /**
   * The unique ID to assign to this item. Mandatory for event pages. Cannot be
   * the same as another ID for this extension.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The text to be displayed in the item; this is _required_ unless `type` is
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
   * specified.
   */
  List<ContextType> get contexts => listify(jsProxy['contexts'], _createContextType);
  set contexts(List<ContextType> value) => jsProxy['contexts'] = jsify(value);

  void onclick([var arg1]) =>
         jsProxy.callMethod('onclick', [jsify(arg1)]);

  /**
   * The ID of a parent menu item; this makes the item a child of a previously
   * added item.
   */
  dynamic get parentId => jsProxy['parentId'];
  set parentId(var value) => jsProxy['parentId'] = jsify(value);

  /**
   * Lets you restrict the item to apply only to documents whose URL matches one
   * of the given patterns. (This applies to frames as well.) For details on the
   * format of a pattern, see [Match Patterns](match_patterns).
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
  ContextMenusUpdateParams({ItemType type, String title, bool checked, List<ContextType> contexts, var parentId, List<String> documentUrlPatterns, List<String> targetUrlPatterns, bool enabled}) {
    if (type != null) this.type = type;
    if (title != null) this.title = title;
    if (checked != null) this.checked = checked;
    if (contexts != null) this.contexts = contexts;
    if (parentId != null) this.parentId = parentId;
    if (documentUrlPatterns != null) this.documentUrlPatterns = documentUrlPatterns;
    if (targetUrlPatterns != null) this.targetUrlPatterns = targetUrlPatterns;
    if (enabled != null) this.enabled = enabled;
  }
  ContextMenusUpdateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ItemType get type => _createItemType(jsProxy['type']);
  set type(ItemType value) => jsProxy['type'] = jsify(value);

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  bool get checked => jsProxy['checked'];
  set checked(bool value) => jsProxy['checked'] = value;

  List<ContextType> get contexts => listify(jsProxy['contexts'], _createContextType);
  set contexts(List<ContextType> value) => jsProxy['contexts'] = jsify(value);

  void onclick([var arg1]) =>
         jsProxy.callMethod('onclick', [jsify(arg1)]);

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

ItemType _createItemType(JsObject jsProxy) => jsProxy == null ? null : new ItemType.fromProxy(jsProxy);
ContextType _createContextType(JsObject jsProxy) => jsProxy == null ? null : new ContextType.fromProxy(jsProxy);
