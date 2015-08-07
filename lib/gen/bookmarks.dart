/* This file has been generated from bookmarks.json - do not edit */

/**
 * Use the `chrome.bookmarks` API to create, organize, and otherwise manipulate
 * bookmarks. Also see [Override Pages](override), which you can use to create a
 * custom Bookmark Manager page.
 */
library chrome.bookmarks;

import '../src/common.dart';

/**
 * Accessor for the `chrome.bookmarks` namespace.
 */
final ChromeBookmarks bookmarks = new ChromeBookmarks._();

class ChromeBookmarks extends ChromeApi {
  JsObject get _bookmarks => chrome['bookmarks'];

  /**
   * Fired when a bookmark or folder is created.
   */
  Stream<OnCreatedEvent> get onCreated => _onCreated.stream;
  ChromeStreamController<OnCreatedEvent> _onCreated;

  /**
   * Fired when a bookmark or folder is removed.  When a folder is removed
   * recursively, a single notification is fired for the folder, and none for
   * its contents.
   */
  Stream<BookmarksOnRemovedEvent> get onRemoved => _onRemoved.stream;
  ChromeStreamController<BookmarksOnRemovedEvent> _onRemoved;

  /**
   * Fired when a bookmark or folder changes.  <b>Note:</b> Currently, only
   * title and url changes trigger this.
   */
  Stream<BookmarksOnChangedEvent> get onChanged => _onChanged.stream;
  ChromeStreamController<BookmarksOnChangedEvent> _onChanged;

  /**
   * Fired when a bookmark or folder is moved to a different parent folder.
   */
  Stream<BookmarksOnMovedEvent> get onMoved => _onMoved.stream;
  ChromeStreamController<BookmarksOnMovedEvent> _onMoved;

  /**
   * Fired when the children of a folder have changed their order due to the
   * order being sorted in the UI.  This is not called as a result of a move().
   */
  Stream<OnChildrenReorderedEvent> get onChildrenReordered => _onChildrenReordered.stream;
  ChromeStreamController<OnChildrenReorderedEvent> _onChildrenReordered;

  /**
   * Fired when a bookmark import session is begun.  Expensive observers should
   * ignore onCreated updates until onImportEnded is fired.  Observers should
   * still handle other notifications immediately.
   */
  Stream get onImportBegan => _onImportBegan.stream;
  ChromeStreamController _onImportBegan;

  /**
   * Fired when a bookmark import session is ended.
   */
  Stream get onImportEnded => _onImportEnded.stream;
  ChromeStreamController _onImportEnded;

  ChromeBookmarks._() {
    var getApi = () => _bookmarks;
    _onCreated = new ChromeStreamController<OnCreatedEvent>.twoArgs(getApi, 'onCreated', _createOnCreatedEvent);
    _onRemoved = new ChromeStreamController<BookmarksOnRemovedEvent>.twoArgs(getApi, 'onRemoved', _createOnRemovedEvent);
    _onChanged = new ChromeStreamController<BookmarksOnChangedEvent>.twoArgs(getApi, 'onChanged', _createOnChangedEvent);
    _onMoved = new ChromeStreamController<BookmarksOnMovedEvent>.twoArgs(getApi, 'onMoved', _createOnMovedEvent);
    _onChildrenReordered = new ChromeStreamController<OnChildrenReorderedEvent>.twoArgs(getApi, 'onChildrenReordered', _createOnChildrenReorderedEvent);
    _onImportBegan = new ChromeStreamController.noArgs(getApi, 'onImportBegan');
    _onImportEnded = new ChromeStreamController.noArgs(getApi, 'onImportEnded');
  }

  bool get available => _bookmarks != null;

  /**
   * 
   */
  int get MAX_WRITE_OPERATIONS_PER_HOUR => _bookmarks['MAX_WRITE_OPERATIONS_PER_HOUR'];

  /**
   * 
   */
  int get MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE => _bookmarks['MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE'];

  /**
   * Retrieves the specified BookmarkTreeNode(s).
   * 
   * [idOrIdList] A single string-valued id, or an array of string-valued ids
   */
  Future<List<BookmarkTreeNode>> get(dynamic idOrIdList) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('get', [jsify(idOrIdList), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the children of the specified BookmarkTreeNode id.
   */
  Future<List<BookmarkTreeNode>> getChildren(String id) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('getChildren', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the recently added bookmarks.
   * 
   * [numberOfItems] The maximum number of items to return.
   */
  Future<List<BookmarkTreeNode>> getRecent(int numberOfItems) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('getRecent', [numberOfItems, completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves the entire Bookmarks hierarchy.
   */
  Future<List<BookmarkTreeNode>> getTree() {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('getTree', [completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves part of the Bookmarks hierarchy, starting at the specified node.
   * 
   * [id] The ID of the root of the subtree to retrieve.
   */
  Future<List<BookmarkTreeNode>> getSubTree(String id) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('getSubTree', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Searches for BookmarkTreeNodes matching the given query. Queries specified
   * with an object produce BookmarkTreeNodes matching all specified properties.
   * 
   * [query] Either a string of words and quoted phrases that are matched
   * against bookmark URLs and titles, or an object. If an object, the
   * properties `query`, `url`, and `title` may be specified and bookmarks
   * matching all specified properties will be produced.
   */
  Future<List<BookmarkTreeNode>> search(dynamic query) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<BookmarkTreeNode>>.oneArg((e) => listify(e, _createBookmarkTreeNode));
    _bookmarks.callMethod('search', [jsify(query), completer.callback]);
    return completer.future;
  }

  /**
   * Creates a bookmark or folder under the specified parentId.  If url is NULL
   * or missing, it will be a folder.
   */
  Future<BookmarkTreeNode> create(CreateDetails bookmark) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BookmarkTreeNode>.oneArg(_createBookmarkTreeNode);
    _bookmarks.callMethod('create', [jsify(bookmark), completer.callback]);
    return completer.future;
  }

  /**
   * Moves the specified BookmarkTreeNode to the provided location.
   */
  Future<BookmarkTreeNode> move(String id, BookmarksMoveParams destination) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BookmarkTreeNode>.oneArg(_createBookmarkTreeNode);
    _bookmarks.callMethod('move', [id, jsify(destination), completer.callback]);
    return completer.future;
  }

  /**
   * Updates the properties of a bookmark or folder. Specify only the properties
   * that you want to change; unspecified properties will be left unchanged.
   * <b>Note:</b> Currently, only 'title' and 'url' are supported.
   */
  Future<BookmarkTreeNode> update(String id, BookmarksUpdateParams changes) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter<BookmarkTreeNode>.oneArg(_createBookmarkTreeNode);
    _bookmarks.callMethod('update', [id, jsify(changes), completer.callback]);
    return completer.future;
  }

  /**
   * Removes a bookmark or an empty bookmark folder.
   */
  Future remove(String id) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bookmarks.callMethod('remove', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Recursively removes a bookmark folder.
   */
  Future removeTree(String id) {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bookmarks.callMethod('removeTree', [id, completer.callback]);
    return completer.future;
  }

  /**
   * Imports bookmarks from a chrome html bookmark file
   */
  Future import() {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bookmarks.callMethod('import', [completer.callback]);
    return completer.future;
  }

  /**
   * Exports bookmarks to a chrome html bookmark file
   */
  Future export() {
    if (_bookmarks == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _bookmarks.callMethod('export', [completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.bookmarks' is not available");
  }
}

/**
 * Fired when a bookmark or folder is created.
 */
class OnCreatedEvent {
  final String id;

  final BookmarkTreeNode bookmark;

  OnCreatedEvent(this.id, this.bookmark);
}

/**
 * Fired when a bookmark or folder is removed.  When a folder is removed
 * recursively, a single notification is fired for the folder, and none for its
 * contents.
 */
class BookmarksOnRemovedEvent {
  final String id;

  final Map removeInfo;

  BookmarksOnRemovedEvent(this.id, this.removeInfo);
}

/**
 * Fired when a bookmark or folder changes.  <b>Note:</b> Currently, only title
 * and url changes trigger this.
 */
class BookmarksOnChangedEvent {
  final String id;

  final Map changeInfo;

  BookmarksOnChangedEvent(this.id, this.changeInfo);
}

/**
 * Fired when a bookmark or folder is moved to a different parent folder.
 */
class BookmarksOnMovedEvent {
  final String id;

  final Map moveInfo;

  BookmarksOnMovedEvent(this.id, this.moveInfo);
}

/**
 * Fired when the children of a folder have changed their order due to the order
 * being sorted in the UI.  This is not called as a result of a move().
 */
class OnChildrenReorderedEvent {
  final String id;

  final Map reorderInfo;

  OnChildrenReorderedEvent(this.id, this.reorderInfo);
}

/**
 * Indicates the reason why this node is unmodifiable. The [managed] value
 * indicates that this node was configured by the system administrator or by the
 * custodian of a supervised user. Omitted if the node can be modified by the
 * user and the extension (default).
 * enum of `managed`
 */
class BookmarkTreeNodeUnmodifiable extends ChromeObject {
  BookmarkTreeNodeUnmodifiable();
  BookmarkTreeNodeUnmodifiable.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);
}

/**
 * A node (either a bookmark or a folder) in the bookmark tree.  Child nodes are
 * ordered within their parent folder.
 */
class BookmarkTreeNode extends ChromeObject {
  BookmarkTreeNode({String id, String parentId, int index, String url, String title, var dateAdded, var dateGroupModified, BookmarkTreeNodeUnmodifiable unmodifiable, List<BookmarkTreeNode> children}) {
    if (id != null) this.id = id;
    if (parentId != null) this.parentId = parentId;
    if (index != null) this.index = index;
    if (url != null) this.url = url;
    if (title != null) this.title = title;
    if (dateAdded != null) this.dateAdded = dateAdded;
    if (dateGroupModified != null) this.dateGroupModified = dateGroupModified;
    if (unmodifiable != null) this.unmodifiable = unmodifiable;
    if (children != null) this.children = children;
  }
  BookmarkTreeNode.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The unique identifier for the node. IDs are unique within the current
   * profile, and they remain valid even after the browser is restarted.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The `id` of the parent folder.  Omitted for the root node.
   */
  String get parentId => jsProxy['parentId'];
  set parentId(String value) => jsProxy['parentId'] = value;

  /**
   * The 0-based position of this node within its parent folder.
   */
  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  /**
   * The URL navigated to when a user clicks the bookmark. Omitted for folders.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The text displayed for the node.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * When this node was created, in milliseconds since the epoch (`new
   * Date(dateAdded)`).
   */
  dynamic get dateAdded => jsProxy['dateAdded'];
  set dateAdded(var value) => jsProxy['dateAdded'] = jsify(value);

  /**
   * When the contents of this folder last changed, in milliseconds since the
   * epoch.
   */
  dynamic get dateGroupModified => jsProxy['dateGroupModified'];
  set dateGroupModified(var value) => jsProxy['dateGroupModified'] = jsify(value);

  /**
   * Indicates the reason why this node is unmodifiable. The [managed] value
   * indicates that this node was configured by the system administrator or by
   * the custodian of a supervised user. Omitted if the node can be modified by
   * the user and the extension (default).
   */
  BookmarkTreeNodeUnmodifiable get unmodifiable => _createBookmarkTreeNodeUnmodifiable(jsProxy['unmodifiable']);
  set unmodifiable(BookmarkTreeNodeUnmodifiable value) => jsProxy['unmodifiable'] = jsify(value);

  /**
   * An ordered list of children of this node.
   */
  List<BookmarkTreeNode> get children => listify(jsProxy['children'], _createBookmarkTreeNode);
  set children(List<BookmarkTreeNode> value) => jsProxy['children'] = jsify(value);
}

/**
 * Object passed to the create() function.
 */
class CreateDetails extends ChromeObject {
  CreateDetails({String parentId, int index, String title, String url}) {
    if (parentId != null) this.parentId = parentId;
    if (index != null) this.index = index;
    if (title != null) this.title = title;
    if (url != null) this.url = url;
  }
  CreateDetails.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Defaults to the Other Bookmarks folder.
   */
  String get parentId => jsProxy['parentId'];
  set parentId(String value) => jsProxy['parentId'] = value;

  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

class BookmarksMoveParams extends ChromeObject {
  BookmarksMoveParams({String parentId, int index}) {
    if (parentId != null) this.parentId = parentId;
    if (index != null) this.index = index;
  }
  BookmarksMoveParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get parentId => jsProxy['parentId'];
  set parentId(String value) => jsProxy['parentId'] = value;

  int get index => jsProxy['index'];
  set index(int value) => jsProxy['index'] = value;
}

class BookmarksUpdateParams extends ChromeObject {
  BookmarksUpdateParams({String title, String url}) {
    if (title != null) this.title = title;
    if (url != null) this.url = url;
  }
  BookmarksUpdateParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

OnCreatedEvent _createOnCreatedEvent(String id, JsObject bookmark) =>
    new OnCreatedEvent(id, _createBookmarkTreeNode(bookmark));
BookmarksOnRemovedEvent _createOnRemovedEvent(String id, JsObject removeInfo) =>
    new BookmarksOnRemovedEvent(id, mapify(removeInfo));
BookmarksOnChangedEvent _createOnChangedEvent(String id, JsObject changeInfo) =>
    new BookmarksOnChangedEvent(id, mapify(changeInfo));
BookmarksOnMovedEvent _createOnMovedEvent(String id, JsObject moveInfo) =>
    new BookmarksOnMovedEvent(id, mapify(moveInfo));
OnChildrenReorderedEvent _createOnChildrenReorderedEvent(String id, JsObject reorderInfo) =>
    new OnChildrenReorderedEvent(id, mapify(reorderInfo));
BookmarkTreeNode _createBookmarkTreeNode(JsObject jsProxy) => jsProxy == null ? null : new BookmarkTreeNode.fromProxy(jsProxy);
BookmarkTreeNodeUnmodifiable _createBookmarkTreeNodeUnmodifiable(JsObject jsProxy) => jsProxy == null ? null : new BookmarkTreeNodeUnmodifiable.fromProxy(jsProxy);
