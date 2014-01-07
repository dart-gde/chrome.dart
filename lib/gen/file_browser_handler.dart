/* This file has been generated from file_browser_handler.json - do not edit */

/**
 * Use the `chrome.fileBrowserHandler` API to extend the Chrome OS file browser.
 * For example, you can use this API to enable users to upload files to your
 * website.
 */
library chrome.fileBrowserHandler;

import '../src/common.dart';

/**
 * Accessor for the `chrome.fileBrowserHandler` namespace.
 */
final ChromeFileBrowserHandler fileBrowserHandler = new ChromeFileBrowserHandler._();

class ChromeFileBrowserHandler extends ChromeApi {
  static final JsObject _fileBrowserHandler = chrome['fileBrowserHandler'];

  ChromeFileBrowserHandler._();

  bool get available => _fileBrowserHandler != null;

  /**
   * Prompts user to select file path under which file should be saved. When the
   * file is selected, file access permission required to use the file (read,
   * write and create) are granted to the caller. The file will not actually get
   * created during the function call, so function caller must ensure its
   * existence before using it. The function has to be invoked with a user
   * gesture.
   * 
   * [selectionParams] Parameters that will be used while selecting the file.
   * 
   * Returns:
   * Result of the method.
   */
  Future<Map> selectFile(FileBrowserHandlerSelectFileParams selectionParams) {
    if (_fileBrowserHandler == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Map>.oneArg(mapify);
    _fileBrowserHandler.callMethod('selectFile', [jsify(selectionParams), completer.callback]);
    return completer.future;
  }

  /**
   * Fired when file system action is executed from ChromeOS file browser.
   */
  Stream<OnExecuteEvent> get onExecute => _onExecute.stream;

  final ChromeStreamController<OnExecuteEvent> _onExecute =
      new ChromeStreamController<OnExecuteEvent>.twoArgs(_fileBrowserHandler, 'onExecute', _createOnExecuteEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.fileBrowserHandler' is not available");
  }
}

/**
 * Fired when file system action is executed from ChromeOS file browser.
 */
class OnExecuteEvent {
  /**
   * File browser action id as specified in the listener component's manifest.
   */
  final String id;

  /**
   * File handler execute event details.
   */
  final FileHandlerExecuteEventDetails details;

  OnExecuteEvent(this.id, this.details);
}

/**
 * Event details payload for fileBrowserHandler.onExecute event.
 */
class FileHandlerExecuteEventDetails extends ChromeObject {
  FileHandlerExecuteEventDetails({List<dynamic> entries, int tab_id}) {
    if (entries != null) this.entries = entries;
    if (tab_id != null) this.tab_id = tab_id;
  }
  FileHandlerExecuteEventDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Array of Entry instances representing files that are targets of this action
   * (selected in ChromeOS file browser).
   */
  List<dynamic> get entries => listify(jsProxy['entries']);
  set entries(List<dynamic> value) => jsProxy['entries'] = jsify(value);

  /**
   * The ID of the tab that raised this event. Tab IDs are unique within a
   * browser session.
   */
  int get tab_id => jsProxy['tab_id'];
  set tab_id(int value) => jsProxy['tab_id'] = value;
}

class FileBrowserHandlerSelectFileParams extends ChromeObject {
  FileBrowserHandlerSelectFileParams({String suggestedName, List<String> allowedFileExtensions}) {
    if (suggestedName != null) this.suggestedName = suggestedName;
    if (allowedFileExtensions != null) this.allowedFileExtensions = allowedFileExtensions;
  }
  FileBrowserHandlerSelectFileParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Suggested name for the file.
   */
  String get suggestedName => jsProxy['suggestedName'];
  set suggestedName(String value) => jsProxy['suggestedName'] = value;

  /**
   * List of file extensions that the selected file can have. The list is also
   * used to specify what files to be shown in the select file dialog. Files
   * with the listed extensions are only shown in the dialog. Extensions should
   * not include the leading '.'. Example: ['jpg', 'png']
   */
  List<String> get allowedFileExtensions => listify(jsProxy['allowedFileExtensions']);
  set allowedFileExtensions(List<String> value) => jsProxy['allowedFileExtensions'] = jsify(value);
}

OnExecuteEvent _createOnExecuteEvent(String id, JsObject details) =>
    new OnExecuteEvent(id, _createFileHandlerExecuteEventDetails(details));
FileHandlerExecuteEventDetails _createFileHandlerExecuteEventDetails(JsObject jsProxy) => jsProxy == null ? null : new FileHandlerExecuteEventDetails.fromProxy(jsProxy);
