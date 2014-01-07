/* This file has been generated - do not edit */

library chrome.input;

import '../src/common.dart';

final ChromeInput input = new ChromeInput._();

class ChromeInput {
  ChromeInput._();

  /**
   * Accessor for the `chrome.input.ime` namespace.
   */
  final ChromeInputIme ime = new ChromeInputIme._();
}

/**
 * Use the `chrome.input.ime` API to implement a custom IME for Chrome OS. This
 * allows your extension to handle keystrokes, set the composition, and manage
 * the candidate window.
 */
class ChromeInputIme extends ChromeApi {
  static final JsObject _input_ime = chrome['input']['ime'];

  ChromeInputIme._();

  bool get available => _input_ime != null;

  /**
   * Set the current composition. If this extension does not own the active IME,
   * this fails.
   */
  Future<bool> setComposition(InputImeSetCompositionParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('setComposition', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Clear the current composition. If this extension does not own the active
   * IME, this fails.
   */
  Future<bool> clearComposition(InputImeClearCompositionParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('clearComposition', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Commits the provided text to the current input.
   */
  Future<bool> commitText(InputImeCommitTextParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('commitText', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the properties of the candidate window. This fails if the extension
   * doesn’t own the active IME
   */
  Future<bool> setCandidateWindowProperties(InputImeSetCandidateWindowPropertiesParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('setCandidateWindowProperties', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Sets the current candidate list. This fails if this extension doesn’t own
   * the active IME
   */
  Future<bool> setCandidates(InputImeSetCandidatesParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('setCandidates', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Set the position of the cursor in the candidate window. This is a no-op if
   * this extension does not own the active IME.
   */
  Future<bool> setCursorPosition(InputImeSetCursorPositionParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _input_ime.callMethod('setCursorPosition', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Adds the provided menu items to the language menu when this IME is active.
   */
  Future setMenuItems(InputImeSetMenuItemsParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _input_ime.callMethod('setMenuItems', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Updates the state of the MenuItems specified
   */
  Future updateMenuItems(InputImeUpdateMenuItemsParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _input_ime.callMethod('updateMenuItems', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Deletes the text around the caret.
   */
  Future deleteSurroundingText(InputImeDeleteSurroundingTextParams parameters) {
    if (_input_ime == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _input_ime.callMethod('deleteSurroundingText', [jsify(parameters), completer.callback]);
    return completer.future;
  }

  /**
   * Indicates that the key event received by onKeyEvent is handled.  This
   * should only be called if the onKeyEvent listener is asynchronous.
   * 
   * [requestId] Request id of the event that was handled.  This should come
   * from keyEvent.requestId
   * 
   * [response] True if the keystroke was handled, false if not
   */
  void keyEventHandled(String requestId, bool response) {
    if (_input_ime == null) _throwNotAvailable();

    _input_ime.callMethod('keyEventHandled', [requestId, response]);
  }

  /**
   * This event is sent when an IME is activated. It signals that the IME will
   * be receiving onKeyPress events.
   */
  Stream<String> get onActivate => _onActivate.stream;

  final ChromeStreamController<String> _onActivate =
      new ChromeStreamController<String>.oneArg(_input_ime, 'onActivate', selfConverter);

  /**
   * This event is sent when an IME is deactivated. It signals that the IME will
   * no longer be receiving onKeyPress events.
   */
  Stream<String> get onDeactivated => _onDeactivated.stream;

  final ChromeStreamController<String> _onDeactivated =
      new ChromeStreamController<String>.oneArg(_input_ime, 'onDeactivated', selfConverter);

  /**
   * This event is sent when focus enters a text box. It is sent to all
   * extensions that are listening to this event, and enabled by the user.
   */
  Stream<InputContext> get onFocus => _onFocus.stream;

  final ChromeStreamController<InputContext> _onFocus =
      new ChromeStreamController<InputContext>.oneArg(_input_ime, 'onFocus', _createInputContext);

  /**
   * This event is sent when focus leaves a text box. It is sent to all
   * extensions that are listening to this event, and enabled by the user.
   */
  Stream<int> get onBlur => _onBlur.stream;

  final ChromeStreamController<int> _onBlur =
      new ChromeStreamController<int>.oneArg(_input_ime, 'onBlur', selfConverter);

  /**
   * This event is sent when the properties of the current InputContext change,
   * such as the the type. It is sent to all extensions that are listening to
   * this event, and enabled by the user.
   */
  Stream<InputContext> get onInputContextUpdate => _onInputContextUpdate.stream;

  final ChromeStreamController<InputContext> _onInputContextUpdate =
      new ChromeStreamController<InputContext>.oneArg(_input_ime, 'onInputContextUpdate', _createInputContext);

  /**
   * This event is sent if this extension owns the active IME.
   */
  Stream<OnKeyEventEvent> get onKeyEvent => _onKeyEvent.stream;

  final ChromeStreamController<OnKeyEventEvent> _onKeyEvent =
      new ChromeStreamController<OnKeyEventEvent>.twoArgs(_input_ime, 'onKeyEvent', _createOnKeyEventEvent);

  /**
   * This event is sent if this extension owns the active IME.
   */
  Stream<OnCandidateClickedEvent> get onCandidateClicked => _onCandidateClicked.stream;

  final ChromeStreamController<OnCandidateClickedEvent> _onCandidateClicked =
      new ChromeStreamController<OnCandidateClickedEvent>.threeArgs(_input_ime, 'onCandidateClicked', _createOnCandidateClickedEvent);

  /**
   * Called when the user selects a menu item
   */
  Stream<OnMenuItemActivatedEvent> get onMenuItemActivated => _onMenuItemActivated.stream;

  final ChromeStreamController<OnMenuItemActivatedEvent> _onMenuItemActivated =
      new ChromeStreamController<OnMenuItemActivatedEvent>.twoArgs(_input_ime, 'onMenuItemActivated', _createOnMenuItemActivatedEvent);

  /**
   * Called when the editable string around caret is changed or when the caret
   * position is moved. The text length is limited to 100 characters for each
   * back and forth direction.
   */
  Stream<OnSurroundingTextChangedEvent> get onSurroundingTextChanged => _onSurroundingTextChanged.stream;

  final ChromeStreamController<OnSurroundingTextChangedEvent> _onSurroundingTextChanged =
      new ChromeStreamController<OnSurroundingTextChangedEvent>.twoArgs(_input_ime, 'onSurroundingTextChanged', _createOnSurroundingTextChangedEvent);

  /**
   * This event is sent when chrome terminates ongoing text input session.
   */
  Stream<String> get onReset => _onReset.stream;

  final ChromeStreamController<String> _onReset =
      new ChromeStreamController<String>.oneArg(_input_ime, 'onReset', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.input.ime' is not available");
  }
}

/**
 * This event is sent if this extension owns the active IME.
 */
class OnKeyEventEvent {
  /**
   * ID of the engine receiving the event
   */
  final String engineID;

  /**
   * Data on the key event
   */
  final KeyboardEvent keyData;

  OnKeyEventEvent(this.engineID, this.keyData);
}

/**
 * This event is sent if this extension owns the active IME.
 */
class OnCandidateClickedEvent {
  /**
   * ID of the engine receiving the event
   */
  final String engineID;

  /**
   * ID of the candidate that was clicked.
   */
  final int candidateID;

  /**
   * Which mouse buttons was clicked.
   * enum of `left`, `middle`, `right`
   */
  final String button;

  OnCandidateClickedEvent(this.engineID, this.candidateID, this.button);
}

/**
 * Called when the user selects a menu item
 */
class OnMenuItemActivatedEvent {
  /**
   * ID of the engine receiving the event
   */
  final String engineID;

  /**
   * Name of the MenuItem which was activated
   */
  final String name;

  OnMenuItemActivatedEvent(this.engineID, this.name);
}

/**
 * Called when the editable string around caret is changed or when the caret
 * position is moved. The text length is limited to 100 characters for each back
 * and forth direction.
 */
class OnSurroundingTextChangedEvent {
  /**
   * ID of the engine receiving the event
   */
  final String engineID;

  /**
   * The surrounding information.
   */
  final Map surroundingInfo;

  OnSurroundingTextChangedEvent(this.engineID, this.surroundingInfo);
}

class PropertiesInputIme extends ChromeObject {
  PropertiesInputIme({bool visible, bool cursorVisible, bool vertical, int pageSize, String auxiliaryText, bool auxiliaryTextVisible, String windowPosition}) {
    if (visible != null) this.visible = visible;
    if (cursorVisible != null) this.cursorVisible = cursorVisible;
    if (vertical != null) this.vertical = vertical;
    if (pageSize != null) this.pageSize = pageSize;
    if (auxiliaryText != null) this.auxiliaryText = auxiliaryText;
    if (auxiliaryTextVisible != null) this.auxiliaryTextVisible = auxiliaryTextVisible;
    if (windowPosition != null) this.windowPosition = windowPosition;
  }
  PropertiesInputIme.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * True to show the Candidate window, false to hide it.
   */
  bool get visible => jsProxy['visible'];
  set visible(bool value) => jsProxy['visible'] = value;

  /**
   * True to show the cursor, false to hide it.
   */
  bool get cursorVisible => jsProxy['cursorVisible'];
  set cursorVisible(bool value) => jsProxy['cursorVisible'] = value;

  /**
   * True if the candidate window should be rendered vertical, false to make it
   * horizontal.
   */
  bool get vertical => jsProxy['vertical'];
  set vertical(bool value) => jsProxy['vertical'] = value;

  /**
   * The number of candidates to display per page.
   */
  int get pageSize => jsProxy['pageSize'];
  set pageSize(int value) => jsProxy['pageSize'] = value;

  /**
   * Text that is shown at the bottom of the candidate window.
   */
  String get auxiliaryText => jsProxy['auxiliaryText'];
  set auxiliaryText(String value) => jsProxy['auxiliaryText'] = value;

  /**
   * True to display the auxiliary text, false to hide it.
   */
  bool get auxiliaryTextVisible => jsProxy['auxiliaryTextVisible'];
  set auxiliaryTextVisible(bool value) => jsProxy['auxiliaryTextVisible'] = value;

  /**
   * Where to display the candidate window. If set to 'cursor', the window
   * follows the cursor. If set to 'composition', the window is locked to the
   * beginning of the composition.
   * enum of `cursor`, `composition`
   */
  String get windowPosition => jsProxy['windowPosition'];
  set windowPosition(String value) => jsProxy['windowPosition'] = value;
}

class UsageInputIme extends ChromeObject {
  UsageInputIme({String title, String body}) {
    if (title != null) this.title = title;
    if (body != null) this.body = body;
  }
  UsageInputIme.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The title string of details description.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * The body string of detail description.
   */
  String get body => jsProxy['body'];
  set body(String value) => jsProxy['body'] = value;
}

/**
 * See http://www.w3.org/TR/DOM-Level-3-Events/#events-KeyboardEvent
 */
class KeyboardEvent extends ChromeObject {
  KeyboardEvent({String type, String requestId, String key, String code, bool altKey, bool ctrlKey, bool shiftKey, bool capsLock}) {
    if (type != null) this.type = type;
    if (requestId != null) this.requestId = requestId;
    if (key != null) this.key = key;
    if (code != null) this.code = code;
    if (altKey != null) this.altKey = altKey;
    if (ctrlKey != null) this.ctrlKey = ctrlKey;
    if (shiftKey != null) this.shiftKey = shiftKey;
    if (capsLock != null) this.capsLock = capsLock;
  }
  KeyboardEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * One of keyup or keydown.
   * enum of `keyup`, `keydown`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  /**
   * The ID of the request.
   */
  String get requestId => jsProxy['requestId'];
  set requestId(String value) => jsProxy['requestId'] = value;

  /**
   * Value of the key being pressed
   */
  String get key => jsProxy['key'];
  set key(String value) => jsProxy['key'] = value;

  /**
   * Value of the physical key being pressed. The value is not affected by
   * current keyboard layout or modifier state.
   */
  String get code => jsProxy['code'];
  set code(String value) => jsProxy['code'] = value;

  /**
   * Whether or not the ALT key is pressed.
   */
  bool get altKey => jsProxy['altKey'];
  set altKey(bool value) => jsProxy['altKey'] = value;

  /**
   * Whether or not the CTRL key is pressed.
   */
  bool get ctrlKey => jsProxy['ctrlKey'];
  set ctrlKey(bool value) => jsProxy['ctrlKey'] = value;

  /**
   * Whether or not the SHIFT key is pressed.
   */
  bool get shiftKey => jsProxy['shiftKey'];
  set shiftKey(bool value) => jsProxy['shiftKey'] = value;

  /**
   * Whether or not the CAPS_LOCK is enabled.
   */
  bool get capsLock => jsProxy['capsLock'];
  set capsLock(bool value) => jsProxy['capsLock'] = value;
}

/**
 * Describes an input Context
 */
class InputContext extends ChromeObject {
  InputContext({int contextID, String type}) {
    if (contextID != null) this.contextID = contextID;
    if (type != null) this.type = type;
  }
  InputContext.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * This is used to specify targets of text field operations.  This ID becomes
   * invalid as soon as onBlur is called.
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * Type of value this text field edits, (Text, Number, Password, etc)
   * enum of `text`, `number`, `password`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;
}

/**
 * A menu item used by an input method to interact with the user from the
 * language menu.
 */
class MenuItem extends ChromeObject {
  MenuItem({String id, String label, String style, bool visible, bool checked, bool enabled}) {
    if (id != null) this.id = id;
    if (label != null) this.label = label;
    if (style != null) this.style = style;
    if (visible != null) this.visible = visible;
    if (checked != null) this.checked = checked;
    if (enabled != null) this.enabled = enabled;
  }
  MenuItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * String that will be passed to callbacks referencing this MenuItem.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * Text displayed in the menu for this item.
   */
  String get label => jsProxy['label'];
  set label(String value) => jsProxy['label'] = value;

  /**
   * Enum representing if this item is: check, radio, or a separator.  Radio
   * buttons between separators are considered grouped.
   * enum of `check`, `radio`, `separator`
   */
  String get style => jsProxy['style'];
  set style(String value) => jsProxy['style'] = value;

  /**
   * Indicates this item is visible.
   */
  bool get visible => jsProxy['visible'];
  set visible(bool value) => jsProxy['visible'] = value;

  /**
   * Indicates this item should be drawn with a check.
   */
  bool get checked => jsProxy['checked'];
  set checked(bool value) => jsProxy['checked'] = value;

  /**
   * Indicates this item is enabled.
   */
  bool get enabled => jsProxy['enabled'];
  set enabled(bool value) => jsProxy['enabled'] = value;
}

class InputImeSetCompositionParams extends ChromeObject {
  InputImeSetCompositionParams({int contextID, String text, int selectionStart, int selectionEnd, int cursor, List<Map> segments}) {
    if (contextID != null) this.contextID = contextID;
    if (text != null) this.text = text;
    if (selectionStart != null) this.selectionStart = selectionStart;
    if (selectionEnd != null) this.selectionEnd = selectionEnd;
    if (cursor != null) this.cursor = cursor;
    if (segments != null) this.segments = segments;
  }
  InputImeSetCompositionParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the context where the composition text will be set
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * Text to set
   */
  String get text => jsProxy['text'];
  set text(String value) => jsProxy['text'] = value;

  /**
   * Position in the text that the selection starts at.
   */
  int get selectionStart => jsProxy['selectionStart'];
  set selectionStart(int value) => jsProxy['selectionStart'] = value;

  /**
   * Position in the text that the selection ends at.
   */
  int get selectionEnd => jsProxy['selectionEnd'];
  set selectionEnd(int value) => jsProxy['selectionEnd'] = value;

  /**
   * Position in the text of the cursor.
   */
  int get cursor => jsProxy['cursor'];
  set cursor(int value) => jsProxy['cursor'] = value;

  /**
   * List of segments and their associated types.
   */
  List<Map> get segments => listify(jsProxy['segments'], mapify);
  set segments(List<Map> value) => jsProxy['segments'] = jsify(value);
}

class InputImeClearCompositionParams extends ChromeObject {
  InputImeClearCompositionParams({int contextID}) {
    if (contextID != null) this.contextID = contextID;
  }
  InputImeClearCompositionParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the context where the composition will be cleared
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;
}

class InputImeCommitTextParams extends ChromeObject {
  InputImeCommitTextParams({int contextID, String text}) {
    if (contextID != null) this.contextID = contextID;
    if (text != null) this.text = text;
  }
  InputImeCommitTextParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the context where the text will be committed
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * The text to commit
   */
  String get text => jsProxy['text'];
  set text(String value) => jsProxy['text'] = value;
}

class InputImeSetCandidateWindowPropertiesParams extends ChromeObject {
  InputImeSetCandidateWindowPropertiesParams({String engineID, PropertiesInputIme properties}) {
    if (engineID != null) this.engineID = engineID;
    if (properties != null) this.properties = properties;
  }
  InputImeSetCandidateWindowPropertiesParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the engine to set properties on.
   */
  String get engineID => jsProxy['engineID'];
  set engineID(String value) => jsProxy['engineID'] = value;

  PropertiesInputIme get properties => _createPropertiesInputIme(jsProxy['properties']);
  set properties(PropertiesInputIme value) => jsProxy['properties'] = jsify(value);
}

class InputImeSetCandidatesParams extends ChromeObject {
  InputImeSetCandidatesParams({int contextID, List<Map> candidates}) {
    if (contextID != null) this.contextID = contextID;
    if (candidates != null) this.candidates = candidates;
  }
  InputImeSetCandidatesParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the context that owns the candidate window.
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * List of candidates to show in the candidate window
   */
  List<Map> get candidates => listify(jsProxy['candidates'], mapify);
  set candidates(List<Map> value) => jsProxy['candidates'] = jsify(value);
}

class InputImeSetCursorPositionParams extends ChromeObject {
  InputImeSetCursorPositionParams({int contextID, int candidateID}) {
    if (contextID != null) this.contextID = contextID;
    if (candidateID != null) this.candidateID = candidateID;
  }
  InputImeSetCursorPositionParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the context that owns the candidate window.
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * ID of the candidate to select.
   */
  int get candidateID => jsProxy['candidateID'];
  set candidateID(int value) => jsProxy['candidateID'] = value;
}

class InputImeSetMenuItemsParams extends ChromeObject {
  InputImeSetMenuItemsParams({String engineID, List<MenuItem> items}) {
    if (engineID != null) this.engineID = engineID;
    if (items != null) this.items = items;
  }
  InputImeSetMenuItemsParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the engine to use
   */
  String get engineID => jsProxy['engineID'];
  set engineID(String value) => jsProxy['engineID'] = value;

  /**
   * MenuItems to add. They will be added in the order they exist in the array.
   */
  List<MenuItem> get items => listify(jsProxy['items'], _createMenuItem);
  set items(List<MenuItem> value) => jsProxy['items'] = jsify(value);
}

class InputImeUpdateMenuItemsParams extends ChromeObject {
  InputImeUpdateMenuItemsParams({String engineID, List<MenuItem> items}) {
    if (engineID != null) this.engineID = engineID;
    if (items != null) this.items = items;
  }
  InputImeUpdateMenuItemsParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the engine to use
   */
  String get engineID => jsProxy['engineID'];
  set engineID(String value) => jsProxy['engineID'] = value;

  /**
   * Array of MenuItems to update
   */
  List<MenuItem> get items => listify(jsProxy['items'], _createMenuItem);
  set items(List<MenuItem> value) => jsProxy['items'] = jsify(value);
}

class InputImeDeleteSurroundingTextParams extends ChromeObject {
  InputImeDeleteSurroundingTextParams({String engineID, int contextID, int offset, int length}) {
    if (engineID != null) this.engineID = engineID;
    if (contextID != null) this.contextID = contextID;
    if (offset != null) this.offset = offset;
    if (length != null) this.length = length;
  }
  InputImeDeleteSurroundingTextParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * ID of the engine receiving the event.
   */
  String get engineID => jsProxy['engineID'];
  set engineID(String value) => jsProxy['engineID'] = value;

  /**
   * ID of the context where the surrounding text will be deleted.
   */
  int get contextID => jsProxy['contextID'];
  set contextID(int value) => jsProxy['contextID'] = value;

  /**
   * The offset from the caret position where deletion will start. This value
   * can be negative.
   */
  int get offset => jsProxy['offset'];
  set offset(int value) => jsProxy['offset'] = value;

  /**
   * The number of characters to be deleted
   */
  int get length => jsProxy['length'];
  set length(int value) => jsProxy['length'] = value;
}

InputContext _createInputContext(JsObject jsProxy) => jsProxy == null ? null : new InputContext.fromProxy(jsProxy);
OnKeyEventEvent _createOnKeyEventEvent(String engineID, JsObject keyData) =>
    new OnKeyEventEvent(engineID, _createKeyboardEvent(keyData));
OnCandidateClickedEvent _createOnCandidateClickedEvent(String engineID, int candidateID, String button) =>
    new OnCandidateClickedEvent(engineID, candidateID, button);
OnMenuItemActivatedEvent _createOnMenuItemActivatedEvent(String engineID, String name) =>
    new OnMenuItemActivatedEvent(engineID, name);
OnSurroundingTextChangedEvent _createOnSurroundingTextChangedEvent(String engineID, JsObject surroundingInfo) =>
    new OnSurroundingTextChangedEvent(engineID, mapify(surroundingInfo));
PropertiesInputIme _createPropertiesInputIme(JsObject jsProxy) => jsProxy == null ? null : new PropertiesInputIme.fromProxy(jsProxy);
MenuItem _createMenuItem(JsObject jsProxy) => jsProxy == null ? null : new MenuItem.fromProxy(jsProxy);
KeyboardEvent _createKeyboardEvent(JsObject jsProxy) => jsProxy == null ? null : new KeyboardEvent.fromProxy(jsProxy);
