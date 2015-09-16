/* This file has been generated from file_system.idl - do not edit */

/**
 * Use the `chrome.fileSystem` API to create, read, navigate, and write to the
 * user's local file system. With this API, Chrome Apps can read and write to a
 * user-selected location. For example, a text editor app can use the API to
 * read and write local documents. All failures are notified via
 * chrome.runtime.lastError.
 */
library chrome.fileSystem;

import '../src/files.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.fileSystem` namespace.
 */
final ChromeFileSystem fileSystem = new ChromeFileSystem._();

class ChromeFileSystem extends ChromeApi {
  JsObject get _fileSystem => chrome['fileSystem'];

  Stream<VolumeListChangedEvent> get onVolumeListChanged => _onVolumeListChanged.stream;
  ChromeStreamController<VolumeListChangedEvent> _onVolumeListChanged;

  Stream<EntryChangedEvent> get onEntryChanged => _onEntryChanged.stream;
  ChromeStreamController<EntryChangedEvent> _onEntryChanged;

  Stream<EntryRemovedEvent> get onEntryRemoved => _onEntryRemoved.stream;
  ChromeStreamController<EntryRemovedEvent> _onEntryRemoved;

  ChromeFileSystem._() {
    var getApi = () => _fileSystem;
    _onVolumeListChanged = new ChromeStreamController<VolumeListChangedEvent>.oneArg(getApi, 'onVolumeListChanged', _createVolumeListChangedEvent);
    _onEntryChanged = new ChromeStreamController<EntryChangedEvent>.oneArg(getApi, 'onEntryChanged', _createEntryChangedEvent);
    _onEntryRemoved = new ChromeStreamController<EntryRemovedEvent>.oneArg(getApi, 'onEntryRemoved', _createEntryRemovedEvent);
  }

  bool get available => _fileSystem != null;

  /**
   * Get the display path of an Entry object. The display path is based on the
   * full path of the file or directory on the local file system, but may be
   * made more readable for display purposes.
   */
  Future<String> getDisplayPath(Entry entry) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<String>.oneArg();
    _fileSystem.callMethod('getDisplayPath', [jsify(entry), completer.callback]);
    return completer.future;
  }

  /**
   * Get a writable Entry from another Entry. This call will fail with a runtime
   * error if the application does not have the 'write' permission under
   * 'fileSystem'. If entry is a DirectoryEntry, this call will fail if the
   * application does not have the 'directory' permission under 'fileSystem'.
   */
  Future<Entry> getWritableEntry(Entry entry) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Entry>.oneArg(_createEntry);
    _fileSystem.callMethod('getWritableEntry', [jsify(entry), completer.callback]);
    return completer.future;
  }

  /**
   * Gets whether this Entry is writable or not.
   */
  Future<bool> isWritableEntry(Entry entry) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _fileSystem.callMethod('isWritableEntry', [jsify(entry), completer.callback]);
    return completer.future;
  }

  /**
   * Ask the user to choose a file or directory.
   * 
   * Returns:
   * [entry] null
   * [fileEntries] null
   */
  Future<ChooseEntryResult> chooseEntry([ChooseEntryOptions options]) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<ChooseEntryResult>.twoArgs(ChooseEntryResult._create);
    _fileSystem.callMethod('chooseEntry', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns the file entry with the given id if it can be restored. This call
   * will fail with a runtime error otherwise.
   */
  Future<Entry> restoreEntry(String id) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<Entry>.oneArg(_createEntry);
    _fileSystem.callMethod('restoreEntry', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Returns whether the app has permission to restore the entry with the given
   * id.
   */
  Future<bool> isRestorable(String id) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _fileSystem.callMethod('isRestorable', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Returns an id that can be passed to restoreEntry to regain access to a
   * given file entry. Only the 500 most recently used entries are retained,
   * where calls to retainEntry and restoreEntry count as use. If the app has
   * the 'retainEntries' permission under 'fileSystem', entries are retained
   * indefinitely. Otherwise, entries are retained only while the app is running
   * and across restarts.
   */
  String retainEntry(Entry entry) {
    if (_fileSystem == null) _throwNotAvailable();

    return _fileSystem.callMethod('retainEntry', [jsify(entry)]);
  }

  /**
   * Requests access to a file system for a volume represented by `
   * options.volumeId`. If `options.writable` is set to true, then the file
   * system will be writable. Otherwise, it will be read-only. The `writable`
   * option requires the ` "fileSystem": {"write"}` permission in the manifest.
   * Available to kiosk apps running in kiosk session only. For manual-launch
   * kiosk mode, a confirmation dialog will be shown on top of the active app
   * window. In case of an error, `fileSystem` will be undefined, and
   * `chrome.runtime.lastError` will be set.
   */
  Future<FileSystem> requestFileSystem(RequestFileSystemOptions options) {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<FileSystem>.oneArg(_createFileSystem);
    _fileSystem.callMethod('requestFileSystem', [jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Returns a list of volumes available for `requestFileSystem()`. The
   * `"fileSystem": {"requestFileSystem"}` manifest permission is required.
   * Available to kiosk apps running in the kiosk session only. In case of an
   * error, `volumes` will be undefined, and ` chrome.runtime.lastError` will be
   * set.
   */
  Future<List<Volume>> getVolumeList() {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Volume>>.oneArg((e) => listify(e, _createVolume));
    _fileSystem.callMethod('getVolumeList', [completer.callback]);
    return completer.future;
  }

  /**
   * Observes a directory entry. Emits an event if the tracked directory is
   * changed (including the list of files on it), or removed. If ` recursive` is
   * set to true, then also all accessible subdirectories will be tracked.
   * Observers are automatically removed once the extension is closed or
   * suspended, unless `entry` is retained using
   * `chrome.fileSystem.retainEntry`.
   * 
   * In such case of retained entries, the observer stays active across restarts
   * until `unobserveEntry` is explicitly called. Note, that once the `entry` is
   * not retained anymore, the observer will be removed automatically. Observed
   * entries are also automatically restored when either `getObservers` is
   * called, or an observing event for it is invoked.
   */
  void observeDirectory(DirectoryEntry entry, [bool recursive]) {
    if (_fileSystem == null) _throwNotAvailable();

    _fileSystem.callMethod('observeDirectory', [jsify(entry), recursive]);
  }

  /**
   * Unobserves a previously observed either a file or a directory.
   */
  void unobserveEntry(Entry entry) {
    if (_fileSystem == null) _throwNotAvailable();

    _fileSystem.callMethod('unobserveEntry', [jsify(entry)]);
  }

  /**
   * Lists all observed entries.
   */
  Future<List<Entry>> getObservedEntries() {
    if (_fileSystem == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<Entry>>.oneArg((e) => listify(e, _createEntry));
    _fileSystem.callMethod('getObservedEntries', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.fileSystem' is not available");
  }
}

class ChooseEntryType extends ChromeEnum {
  static const ChooseEntryType OPEN_FILE = const ChooseEntryType._('openFile');
  static const ChooseEntryType OPEN_WRITABLE_FILE = const ChooseEntryType._('openWritableFile');
  static const ChooseEntryType SAVE_FILE = const ChooseEntryType._('saveFile');
  static const ChooseEntryType OPEN_DIRECTORY = const ChooseEntryType._('openDirectory');

  static const List<ChooseEntryType> VALUES = const[OPEN_FILE, OPEN_WRITABLE_FILE, SAVE_FILE, OPEN_DIRECTORY];

  const ChooseEntryType._(String str): super(str);
}

/**
 * Type of a change happened to a child entry within a tracked directory.
 */
class ChildChangeType extends ChromeEnum {
  static const ChildChangeType CREATED = const ChildChangeType._('created');
  static const ChildChangeType REMOVED = const ChildChangeType._('removed');
  static const ChildChangeType CHANGED = const ChildChangeType._('changed');

  static const List<ChildChangeType> VALUES = const[CREATED, REMOVED, CHANGED];

  const ChildChangeType._(String str): super(str);
}

class AcceptOption extends ChromeObject {
  AcceptOption({String description, List<String> mimeTypes, List<String> extensions}) {
    if (description != null) this.description = description;
    if (mimeTypes != null) this.mimeTypes = mimeTypes;
    if (extensions != null) this.extensions = extensions;
  }
  AcceptOption.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get description => jsProxy['description'];
  set description(String value) => jsProxy['description'] = value;

  List<String> get mimeTypes => listify(jsProxy['mimeTypes']);
  set mimeTypes(List<String> value) => jsProxy['mimeTypes'] = jsify(value);

  List<String> get extensions => listify(jsProxy['extensions']);
  set extensions(List<String> value) => jsProxy['extensions'] = jsify(value);
}

class ChooseEntryOptions extends ChromeObject {
  ChooseEntryOptions({ChooseEntryType type, String suggestedName, List<AcceptOption> accepts, bool acceptsAllTypes, bool acceptsMultiple}) {
    if (type != null) this.type = type;
    if (suggestedName != null) this.suggestedName = suggestedName;
    if (accepts != null) this.accepts = accepts;
    if (acceptsAllTypes != null) this.acceptsAllTypes = acceptsAllTypes;
    if (acceptsMultiple != null) this.acceptsMultiple = acceptsMultiple;
  }
  ChooseEntryOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  ChooseEntryType get type => _createChooseEntryType(jsProxy['type']);
  set type(ChooseEntryType value) => jsProxy['type'] = jsify(value);

  String get suggestedName => jsProxy['suggestedName'];
  set suggestedName(String value) => jsProxy['suggestedName'] = value;

  List<AcceptOption> get accepts => listify(jsProxy['accepts'], _createAcceptOption);
  set accepts(List<AcceptOption> value) => jsProxy['accepts'] = jsify(value);

  bool get acceptsAllTypes => jsProxy['acceptsAllTypes'];
  set acceptsAllTypes(bool value) => jsProxy['acceptsAllTypes'] = value;

  bool get acceptsMultiple => jsProxy['acceptsMultiple'];
  set acceptsMultiple(bool value) => jsProxy['acceptsMultiple'] = value;
}

class RequestFileSystemOptions extends ChromeObject {
  RequestFileSystemOptions({String volumeId, bool writable}) {
    if (volumeId != null) this.volumeId = volumeId;
    if (writable != null) this.writable = writable;
  }
  RequestFileSystemOptions.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get volumeId => jsProxy['volumeId'];
  set volumeId(String value) => jsProxy['volumeId'] = value;

  bool get writable => jsProxy['writable'];
  set writable(bool value) => jsProxy['writable'] = value;
}

/**
 * Represents a mounted volume, which can be accessed via `chrome.
 * fileSystem.requestFileSystem`.
 */
class Volume extends ChromeObject {
  Volume({String volumeId, bool writable}) {
    if (volumeId != null) this.volumeId = volumeId;
    if (writable != null) this.writable = writable;
  }
  Volume.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get volumeId => jsProxy['volumeId'];
  set volumeId(String value) => jsProxy['volumeId'] = value;

  bool get writable => jsProxy['writable'];
  set writable(bool value) => jsProxy['writable'] = value;
}

/**
 * Change to an entry within a tracked directory.
 */
class ChildChange extends ChromeObject {
  ChildChange({Entry entry, ChildChangeType type}) {
    if (entry != null) this.entry = entry;
    if (type != null) this.type = type;
  }
  ChildChange.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Entry get entry => _createEntry(jsProxy['entry']);
  set entry(Entry value) => jsProxy['entry'] = jsify(value);

  ChildChangeType get type => _createChildChangeType(jsProxy['type']);
  set type(ChildChangeType value) => jsProxy['type'] = jsify(value);
}

/**
 * Event notifying about an inserted or a removed volume from the system.
 */
class VolumeListChangedEvent extends ChromeObject {
  VolumeListChangedEvent({List<Volume> volumes}) {
    if (volumes != null) this.volumes = volumes;
  }
  VolumeListChangedEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  List<Volume> get volumes => listify(jsProxy['volumes'], _createVolume);
  set volumes(List<Volume> value) => jsProxy['volumes'] = jsify(value);
}

/**
 * Event notifying about a change in a file or a directory, including its
 * contents.
 */
class EntryChangedEvent extends ChromeObject {
  EntryChangedEvent({Entry target, List<ChildChange> childChanges}) {
    if (target != null) this.target = target;
    if (childChanges != null) this.childChanges = childChanges;
  }
  EntryChangedEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Entry get target => _createEntry(jsProxy['target']);
  set target(Entry value) => jsProxy['target'] = jsify(value);

  List<ChildChange> get childChanges => listify(jsProxy['childChanges'], _createChildChange);
  set childChanges(List<ChildChange> value) => jsProxy['childChanges'] = jsify(value);
}

/**
 * Event notifying about a tracked file or a directory being removed.
 */
class EntryRemovedEvent extends ChromeObject {
  EntryRemovedEvent({Entry target}) {
    if (target != null) this.target = target;
  }
  EntryRemovedEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  Entry get target => _createEntry(jsProxy['target']);
  set target(Entry value) => jsProxy['target'] = jsify(value);
}

/**
 * The return type for [chooseEntry].
 */
class ChooseEntryResult {
  static ChooseEntryResult _create(entry, fileEntries) {
    return new ChooseEntryResult._(_createEntry(entry), listify(fileEntries, _createFileEntry));
  }

  Entry entry;
  List<FileEntry> fileEntries;

  ChooseEntryResult._(this.entry, this.fileEntries);
}

VolumeListChangedEvent _createVolumeListChangedEvent(JsObject jsProxy) => jsProxy == null ? null : new VolumeListChangedEvent.fromProxy(jsProxy);
EntryChangedEvent _createEntryChangedEvent(JsObject jsProxy) => jsProxy == null ? null : new EntryChangedEvent.fromProxy(jsProxy);
EntryRemovedEvent _createEntryRemovedEvent(JsObject jsProxy) => jsProxy == null ? null : new EntryRemovedEvent.fromProxy(jsProxy);
Entry _createEntry(JsObject jsProxy) => jsProxy == null ? null : new CrEntry.fromProxy(jsProxy);
FileSystem _createFileSystem(JsObject jsProxy) => jsProxy == null ? null : new CrFileSystem.fromProxy(jsProxy);
Volume _createVolume(JsObject jsProxy) => jsProxy == null ? null : new Volume.fromProxy(jsProxy);
ChooseEntryType _createChooseEntryType(String value) => ChooseEntryType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
AcceptOption _createAcceptOption(JsObject jsProxy) => jsProxy == null ? null : new AcceptOption.fromProxy(jsProxy);
ChildChangeType _createChildChangeType(String value) => ChildChangeType.VALUES.singleWhere((ChromeEnum e) => e.value == value);
ChildChange _createChildChange(JsObject jsProxy) => jsProxy == null ? null : new ChildChange.fromProxy(jsProxy);
FileEntry _createFileEntry(JsObject jsProxy) => jsProxy == null ? null : new ChromeFileEntry.fromProxy(jsProxy);
