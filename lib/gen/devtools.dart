/* This file has been generated - do not edit */

library chrome.devtools;

import '../src/common.dart';

final ChromeDevtools devtools = new ChromeDevtools._();

class ChromeDevtools {
  ChromeDevtools._();

  /**
   * Accessor for the `chrome.devtools.inspectedWindow` namespace.
   */
  final ChromeDevtoolsInspectedWindow inspectedWindow = new ChromeDevtoolsInspectedWindow._();

  /**
   * Accessor for the `chrome.devtools.network` namespace.
   */
  final ChromeDevtoolsNetwork network = new ChromeDevtoolsNetwork._();

  /**
   * Accessor for the `chrome.devtools.panels` namespace.
   */
  final ChromeDevtoolsPanels panels = new ChromeDevtoolsPanels._();
}

/**
 * Use the `chrome.devtools.inspectedWindow` API to interact with the inspected
 * window: obtain the tab ID for the inspected page, evaluate the code in the
 * context of the inspected window, reload the page, or obtain the list of
 * resources within the page.
 */
class ChromeDevtoolsInspectedWindow extends ChromeApi {
  static final JsObject _devtools_inspectedWindow = chrome['devtools']['inspectedWindow'];

  ChromeDevtoolsInspectedWindow._();

  bool get available => _devtools_inspectedWindow != null;

  /**
   * The ID of the tab being inspected. This ID may be used with chrome.tabs.*
   * API.
   */
  int get tabId => _devtools_inspectedWindow['tabId'];

  /**
   * Evaluates a JavaScript expression in the context of the main frame of the
   * inspected page. The expression must evaluate to a JSON-compliant object,
   * otherwise an exception is thrown.
   * 
   * [expression] An expression to evaluate.
   * 
   * Returns:
   * [result] The result of evaluation.
   * [isException] Set if an exception was caught while evaluating the
   * expression.
   */
  Future<EvalResult> eval(String expression) {
    if (_devtools_inspectedWindow == null) _throwNotAvailable();

    var completer = new ChromeCompleter<EvalResult>.twoArgs(EvalResult._create);
    _devtools_inspectedWindow.callMethod('eval', [expression, completer.callback]);
    return completer.future;
  }

  /**
   * Reloads the inspected page.
   */
  void reload([DevtoolsInspectedWindowReloadParams reloadOptions]) {
    if (_devtools_inspectedWindow == null) _throwNotAvailable();

    _devtools_inspectedWindow.callMethod('reload', [jsify(reloadOptions)]);
  }

  /**
   * Retrieves the list of resources from the inspected page.
   * 
   * Returns:
   * The resources within the page.
   */
  Future<List<Resource>> getResources() {
    if (_devtools_inspectedWindow == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Resource>>.oneArg((e) => listify(e, _createResource));
    _devtools_inspectedWindow.callMethod('getResources', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a new resource is added to the inspected page.
   */
  Stream<Resource> get onResourceAdded => _onResourceAdded.stream;

  final ChromeStreamController<Resource> _onResourceAdded =
      new ChromeStreamController<Resource>.oneArg(_devtools_inspectedWindow, 'onResourceAdded', _createResource);

  /**
   * Fired when a new revision of the resource is committed (e.g. user saves an
   * edited version of the resource in the Developer Tools).
   */
  Stream<OnResourceContentCommittedEvent> get onResourceContentCommitted => _onResourceContentCommitted.stream;

  final ChromeStreamController<OnResourceContentCommittedEvent> _onResourceContentCommitted =
      new ChromeStreamController<OnResourceContentCommittedEvent>.twoArgs(_devtools_inspectedWindow, 'onResourceContentCommitted', _createOnResourceContentCommittedEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.devtools.inspectedWindow' is not available");
  }
}

/**
 * Fired when a new revision of the resource is committed (e.g. user saves an
 * edited version of the resource in the Developer Tools).
 */
class OnResourceContentCommittedEvent {
  final Resource resource;

  /**
   * New content of the resource.
   */
  final String content;

  OnResourceContentCommittedEvent(this.resource, this.content);
}

/**
 * A resource within the inspected page, such as a document, a script, or an
 * image.
 */
class Resource extends ChromeObject {
  Resource({String url}) {
    if (url != null) this.url = url;
  }
  Resource.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL of the resource.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * Gets the content of the resource.
   * 
   * Returns:
   * [content] Content of the resource (potentially encoded).
   * [encoding] Empty if content is not encoded, encoding name otherwise.
   * Currently, only base64 is supported.
   */
  Future<GetResourceContentResult> getContent() {
    var completer = new ChromeCompleter<GetResourceContentResult>.twoArgs(GetResourceContentResult._create);
    jsProxy.callMethod('getContent', [completer.callback]);
    return completer.future;
  }

  /**
   * Sets the content of the resource.
   * 
   * [content] New content of the resource. Only resources with the text type
   * are currently supported.
   * 
   * [commit] True if the user has finished editing the resource, and the new
   * content of the resource should be persisted; false if this is a minor
   * change sent in progress of the user editing the resource.
   * 
   * Returns:
   * Set to undefined if the resource content was set successfully; describes
   * error otherwise.
   */
  Future<Map<String, dynamic>> setContent(String content, bool commit) {
    var completer = new ChromeCompleter<Map<String, dynamic>>.oneArg(mapify);
    jsProxy.callMethod('setContent', [content, commit, completer.callback]);
    return completer.future;
  }
}

class DevtoolsInspectedWindowReloadParams extends ChromeObject {
  DevtoolsInspectedWindowReloadParams({bool ignoreCache, String userAgent, String injectedScript}) {
    if (ignoreCache != null) this.ignoreCache = ignoreCache;
    if (userAgent != null) this.userAgent = userAgent;
    if (injectedScript != null) this.injectedScript = injectedScript;
  }
  DevtoolsInspectedWindowReloadParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * When true, the loader will ignore the cache for all inspected page
   * resources loaded before the `load` event is fired. The effect is similar to
   * pressing Ctrl+Shift+R in the inspected window or within the Developer Tools
   * window.
   */
  bool get ignoreCache => jsProxy['ignoreCache'];
  set ignoreCache(bool value) => jsProxy['ignoreCache'] = value;

  /**
   * If specified, the string will override the value of the `User-Agent` HTTP
   * header that's sent while loading the resources of the inspected page. The
   * string will also override the value of the `navigator.userAgent` property
   * that's returned to any scripts that are running within the inspected page.
   */
  String get userAgent => jsProxy['userAgent'];
  set userAgent(String value) => jsProxy['userAgent'] = value;

  /**
   * If specified, the script will be injected into every frame of the inspected
   * page immediately upon load, before any of the frame's scripts. The script
   * will not be injected after subsequent reloads-for example, if the user
   * presses Ctrl+R.
   */
  String get injectedScript => jsProxy['injectedScript'];
  set injectedScript(String value) => jsProxy['injectedScript'] = value;
}

/**
 * The return type for [eval].
 */
class EvalResult {
  static EvalResult _create(result, isException) {
    return new EvalResult._(mapify(result), isException);
  }

  Map<String, dynamic> result;
  bool isException;

  EvalResult._(this.result, this.isException);
}

/**
 * The return type for [getContent].
 */
class GetResourceContentResult {
  static GetResourceContentResult _create(content, encoding) {
    return new GetResourceContentResult._(content, encoding);
  }

  String content;
  String encoding;

  GetResourceContentResult._(this.content, this.encoding);
}

Resource _createResource(JsObject jsProxy) => jsProxy == null ? null : new Resource.fromProxy(jsProxy);
OnResourceContentCommittedEvent _createOnResourceContentCommittedEvent(JsObject resource, String content) =>
    new OnResourceContentCommittedEvent(_createResource(resource), content);

/**
 * Use the `chrome.devtools.network` API to retrieve the information about
 * network requests displayed by the Developer Tools in the Network panel.
 */
class ChromeDevtoolsNetwork extends ChromeApi {
  static final JsObject _devtools_network = chrome['devtools']['network'];

  ChromeDevtoolsNetwork._();

  bool get available => _devtools_network != null;

  /**
   * Returns HAR log that contains all known network requests.
   * 
   * Returns:
   * A HAR log. See HAR specification for details.
   */
  Future<Map<String, dynamic>> getHAR() {
    if (_devtools_network == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map<String, dynamic>>.oneArg(mapify);
    _devtools_network.callMethod('getHAR', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a network request is finished and all request data are
   * available.
   */
  Stream<Request> get onRequestFinished => _onRequestFinished.stream;

  final ChromeStreamController<Request> _onRequestFinished =
      new ChromeStreamController<Request>.oneArg(_devtools_network, 'onRequestFinished', _createRequest);

  /**
   * Fired when the inspected window navigates to a new page.
   */
  Stream<String> get onNavigated => _onNavigated.stream;

  final ChromeStreamController<String> _onNavigated =
      new ChromeStreamController<String>.oneArg(_devtools_network, 'onNavigated', selfConverter);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.devtools.network' is not available");
  }
}

/**
 * Represents a network request for a document resource (script, image and so
 * on). See HAR Specification for reference.
 */
class Request extends ChromeObject {
  Request();
  Request.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Returns content of the response body.
   * 
   * Returns:
   * [content] Content of the response body (potentially encoded).
   * [encoding] Empty if content is not encoded, encoding name otherwise.
   * Currently, only base64 is supported.
   */
  Future<GetRequestContentResult> getContent() {
    var completer = new ChromeCompleter<GetRequestContentResult>.twoArgs(GetRequestContentResult._create);
    jsProxy.callMethod('getContent', [completer.callback]);
    return completer.future;
  }
}

/**
 * The return type for [getContent].
 */
class GetRequestContentResult {
  static GetRequestContentResult _create(content, encoding) {
    return new GetRequestContentResult._(content, encoding);
  }

  String content;
  String encoding;

  GetRequestContentResult._(this.content, this.encoding);
}

Request _createRequest(JsObject jsProxy) => jsProxy == null ? null : new Request.fromProxy(jsProxy);

/**
 * Use the `chrome.devtools.panels` API to integrate your extension into
 * Developer Tools window UI: create your own panels, access existing panels,
 * and add sidebars.
 */
class ChromeDevtoolsPanels extends ChromeApi {
  static final JsObject _devtools_panels = chrome['devtools']['panels'];

  ChromeDevtoolsPanels._();

  bool get available => _devtools_panels != null;

  /**
   * Elements panel.
   */
  ElementsPanel get elements => _createElementsPanel(_devtools_panels['elements']);

  /**
   * Creates an extension panel.
   * 
   * [title] Title that is displayed next to the extension icon in the Developer
   * Tools toolbar.
   * 
   * [iconPath] Path of the panel's icon relative to the extension directory.
   * 
   * [pagePath] Path of the panel's HTML page relative to the extension
   * directory.
   * 
   * Returns:
   * An ExtensionPanel object representing the created panel.
   */
  Future<ExtensionPanel> create(String title, String iconPath, String pagePath) {
    if (_devtools_panels == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ExtensionPanel>.oneArg(_createExtensionPanel);
    _devtools_panels.callMethod('create', [title, iconPath, pagePath, completer.callback]);
    return completer.future;
  }

  /**
   * Specifies the function to be called when the user clicks a resource link in
   * the Developer Tools window. To unset the handler, either call the method
   * with no parameters or pass null as the parameter.
   * 
   * Returns:
   * A [devtools.inspectedWindow.Resource] object for the resource that was
   * clicked.
   */
  Future<Resource> setOpenResourceHandler() {
    if (_devtools_panels == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Resource>.oneArg(_createResource);
    _devtools_panels.callMethod('setOpenResourceHandler', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.devtools.panels' is not available");
  }
}

/**
 * Represents the Elements panel.
 */
class ElementsPanel extends ChromeObject {
  ElementsPanel();
  ElementsPanel.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Creates a pane within panel's sidebar.
   * 
   * [title] Text that is displayed in sidebar caption.
   * 
   * Returns:
   * An ExtensionSidebarPane object for created sidebar pane.
   */
  Future<ExtensionSidebarPane> createSidebarPane(String title) {
    var completer = new ChromeCompleter<ExtensionSidebarPane>.oneArg(_createExtensionSidebarPane);
    jsProxy.callMethod('createSidebarPane', [title, completer.callback]);
    return completer.future;
  }
}

/**
 * Represents a panel created by extension.
 */
class ExtensionPanel extends ChromeObject {
  ExtensionPanel();
  ExtensionPanel.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Appends a button to the status bar of the panel.
   * 
   * [iconPath] Path to the icon of the button. The file should contain a
   * 64x24-pixel image composed of two 32x24 icons. The left icon is used when
   * the button is inactive; the right icon is displayed when the button is
   * pressed.
   * 
   * [tooltipText] Text shown as a tooltip when user hovers the mouse over the
   * button.
   * 
   * [disabled] Whether the button is disabled.
   */
  Button createStatusBarButton(String iconPath, String tooltipText, bool disabled) {
    return _createButton(jsProxy.callMethod('createStatusBarButton', [iconPath, tooltipText, disabled]));
  }
}

/**
 * A sidebar created by the extension.
 */
class ExtensionSidebarPane extends ChromeObject {
  ExtensionSidebarPane();
  ExtensionSidebarPane.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Sets the height of the sidebar.
   * 
   * [height] A CSS-like size specification, such as `'100px'` or `'12ex'`.
   */
  void setHeight(String height) {
    jsProxy.callMethod('setHeight', [height]);
  }

  /**
   * Sets an expression that is evaluated within the inspected page. The result
   * is displayed in the sidebar pane.
   * 
   * [expression] An expression to be evaluated in context of the inspected
   * page. JavaScript objects and DOM nodes are displayed in an expandable tree
   * similar to the console/watch.
   * 
   * [rootTitle] An optional title for the root of the expression tree.
   */
  Future setExpression(String expression, [String rootTitle]) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('setExpression', [expression, rootTitle, completer.callback]);
    return completer.future;
  }

  /**
   * Sets a JSON-compliant object to be displayed in the sidebar pane.
   * 
   * [jsonObject] An object to be displayed in context of the inspected page.
   * Evaluated in the context of the caller (API client).
   * 
   * [rootTitle] An optional title for the root of the expression tree.
   */
  Future setObject(String jsonObject, [String rootTitle]) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('setObject', [jsonObject, rootTitle, completer.callback]);
    return completer.future;
  }

  /**
   * Sets an HTML page to be displayed in the sidebar pane.
   * 
   * [path] Relative path of an extension page to display within the sidebar.
   */
  void setPage(String path) {
    jsProxy.callMethod('setPage', [path]);
  }
}

/**
 * A button created by the extension.
 */
class Button extends ChromeObject {
  Button();
  Button.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Updates the attributes of the button. If some of the arguments are omitted
   * or `null`, the corresponding attributes are not updated.
   * 
   * [iconPath] Path to the new icon of the button.
   * 
   * [tooltipText] Text shown as a tooltip when user hovers the mouse over the
   * button.
   * 
   * [disabled] Whether the button is disabled.
   */
  void update([String iconPath, String tooltipText, bool disabled]) {
    jsProxy.callMethod('update', [iconPath, tooltipText, disabled]);
  }
}

ElementsPanel _createElementsPanel(JsObject jsProxy) => jsProxy == null ? null : new ElementsPanel.fromProxy(jsProxy);
ExtensionPanel _createExtensionPanel(JsObject jsProxy) => jsProxy == null ? null : new ExtensionPanel.fromProxy(jsProxy);
ExtensionSidebarPane _createExtensionSidebarPane(JsObject jsProxy) => jsProxy == null ? null : new ExtensionSidebarPane.fromProxy(jsProxy);
Button _createButton(JsObject jsProxy) => jsProxy == null ? null : new Button.fromProxy(jsProxy);
