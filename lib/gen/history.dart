/* This file has been generated from history.json - do not edit */

/**
 * Use the `chrome.history` API to interact with the browser's record of visited
 * pages. You can add, remove, and query for URLs in the browser's history. To
 * override the history page with your own version, see [Override
 * Pages](override.html).
 */
library chrome.history;

import '../src/common.dart';

/**
 * Accessor for the `chrome.history` namespace.
 */
final ChromeHistory history = new ChromeHistory._();

class ChromeHistory extends ChromeApi {
  static final JsObject _history = chrome['history'];

  ChromeHistory._();

  bool get available => _history != null;

  /**
   * Searches the history for the last visit time of each page matching the
   * query.
   */
  Future<List<HistoryItem>> search(HistorySearchParams query) {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<HistoryItem>>.oneArg((e) => listify(e, _createHistoryItem));
    _history.callMethod('search', [jsify(query), completer.callback]);
    return completer.future;
  }

  /**
   * Retrieves information about visits to a URL.
   */
  Future<List<VisitItem>> getVisits(HistoryGetVisitsParams details) {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<VisitItem>>.oneArg((e) => listify(e, _createVisitItem));
    _history.callMethod('getVisits', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Adds a URL to the history at the current time with a [transition
   * type](#transition_types) of "link".
   */
  Future addUrl(HistoryAddUrlParams details) {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _history.callMethod('addUrl', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Removes all occurrences of the given URL from the history.
   */
  Future deleteUrl(HistoryDeleteUrlParams details) {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _history.callMethod('deleteUrl', [jsify(details), completer.callback]);
    return completer.future;
  }

  /**
   * Removes all items within the specified date range from the history.  Pages
   * will not be removed from the history unless all visits fall within the
   * range.
   */
  Future deleteRange(HistoryDeleteRangeParams range) {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _history.callMethod('deleteRange', [jsify(range), completer.callback]);
    return completer.future;
  }

  /**
   * Deletes all items from the history.
   */
  Future deleteAll() {
    if (_history == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _history.callMethod('deleteAll', [completer.callback]);
    return completer.future;
  }

  /**
   * Fired when a URL is visited, providing the HistoryItem data for that URL.
   * This event fires before the page has loaded.
   */
  Stream<HistoryItem> get onVisited => _onVisited.stream;

  final ChromeStreamController<HistoryItem> _onVisited =
      new ChromeStreamController<HistoryItem>.oneArg(_history, 'onVisited', _createHistoryItem);

  /**
   * Fired when one or more URLs are removed from the history service.  When all
   * visits have been removed the URL is purged from history.
   */
  Stream<Map> get onVisitRemoved => _onVisitRemoved.stream;

  final ChromeStreamController<Map> _onVisitRemoved =
      new ChromeStreamController<Map>.oneArg(_history, 'onVisitRemoved', mapify);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.history' is not available");
  }
}

/**
 * An object encapsulating one result of a history query.
 */
class HistoryItem extends ChromeObject {
  HistoryItem({String id, String url, String title, var lastVisitTime, int visitCount, int typedCount}) {
    if (id != null) this.id = id;
    if (url != null) this.url = url;
    if (title != null) this.title = title;
    if (lastVisitTime != null) this.lastVisitTime = lastVisitTime;
    if (visitCount != null) this.visitCount = visitCount;
    if (typedCount != null) this.typedCount = typedCount;
  }
  HistoryItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The unique identifier for the item.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The URL navigated to by a user.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;

  /**
   * The title of the page when it was last loaded.
   */
  String get title => jsProxy['title'];
  set title(String value) => jsProxy['title'] = value;

  /**
   * When this page was last loaded, represented in milliseconds since the
   * epoch.
   */
  dynamic get lastVisitTime => jsProxy['lastVisitTime'];
  set lastVisitTime(var value) => jsProxy['lastVisitTime'] = jsify(value);

  /**
   * The number of times the user has navigated to this page.
   */
  int get visitCount => jsProxy['visitCount'];
  set visitCount(int value) => jsProxy['visitCount'] = value;

  /**
   * The number of times the user has navigated to this page by typing in the
   * address.
   */
  int get typedCount => jsProxy['typedCount'];
  set typedCount(int value) => jsProxy['typedCount'] = value;
}

/**
 * An object encapsulating one visit to a URL.
 */
class VisitItem extends ChromeObject {
  VisitItem({String id, String visitId, var visitTime, String referringVisitId, String transition}) {
    if (id != null) this.id = id;
    if (visitId != null) this.visitId = visitId;
    if (visitTime != null) this.visitTime = visitTime;
    if (referringVisitId != null) this.referringVisitId = referringVisitId;
    if (transition != null) this.transition = transition;
  }
  VisitItem.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The unique identifier for the item.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * The unique identifier for this visit.
   */
  String get visitId => jsProxy['visitId'];
  set visitId(String value) => jsProxy['visitId'] = value;

  /**
   * When this visit occurred, represented in milliseconds since the epoch.
   */
  dynamic get visitTime => jsProxy['visitTime'];
  set visitTime(var value) => jsProxy['visitTime'] = jsify(value);

  /**
   * The visit ID of the referrer.
   */
  String get referringVisitId => jsProxy['referringVisitId'];
  set referringVisitId(String value) => jsProxy['referringVisitId'] = value;

  /**
   * The [transition type](#transition_types) for this visit from its referrer.
   * enum of `link`, `typed`, `auto_bookmark`, `auto_subframe`,
   * `manual_subframe`, `generated`, `auto_toplevel`, `form_submit`, `reload`,
   * `keyword`, `keyword_generated`
   */
  String get transition => jsProxy['transition'];
  set transition(String value) => jsProxy['transition'] = value;
}

class HistorySearchParams extends ChromeObject {
  HistorySearchParams({String text, var startTime, var endTime, int maxResults}) {
    if (text != null) this.text = text;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (maxResults != null) this.maxResults = maxResults;
  }
  HistorySearchParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * A free-text query to the history service.  Leave empty to retrieve all
   * pages.
   */
  String get text => jsProxy['text'];
  set text(String value) => jsProxy['text'] = value;

  /**
   * Limit results to those visited after this date, represented in milliseconds
   * since the epoch.
   */
  dynamic get startTime => jsProxy['startTime'];
  set startTime(var value) => jsProxy['startTime'] = jsify(value);

  /**
   * Limit results to those visited before this date, represented in
   * milliseconds since the epoch.
   */
  dynamic get endTime => jsProxy['endTime'];
  set endTime(var value) => jsProxy['endTime'] = jsify(value);

  /**
   * The maximum number of results to retrieve.  Defaults to 100.
   */
  int get maxResults => jsProxy['maxResults'];
  set maxResults(int value) => jsProxy['maxResults'] = value;
}

class HistoryGetVisitsParams extends ChromeObject {
  HistoryGetVisitsParams({String url}) {
    if (url != null) this.url = url;
  }
  HistoryGetVisitsParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL for which to retrieve visit information.  It must be in the format
   * as returned from a call to history.search.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

class HistoryAddUrlParams extends ChromeObject {
  HistoryAddUrlParams({String url}) {
    if (url != null) this.url = url;
  }
  HistoryAddUrlParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL to add.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

class HistoryDeleteUrlParams extends ChromeObject {
  HistoryDeleteUrlParams({String url}) {
    if (url != null) this.url = url;
  }
  HistoryDeleteUrlParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The URL to remove.
   */
  String get url => jsProxy['url'];
  set url(String value) => jsProxy['url'] = value;
}

class HistoryDeleteRangeParams extends ChromeObject {
  HistoryDeleteRangeParams({var startTime, var endTime}) {
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
  }
  HistoryDeleteRangeParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Items added to history after this date, represented in milliseconds since
   * the epoch.
   */
  dynamic get startTime => jsProxy['startTime'];
  set startTime(var value) => jsProxy['startTime'] = jsify(value);

  /**
   * Items added to history before this date, represented in milliseconds since
   * the epoch.
   */
  dynamic get endTime => jsProxy['endTime'];
  set endTime(var value) => jsProxy['endTime'] = jsify(value);
}

HistoryItem _createHistoryItem(JsObject jsProxy) => jsProxy == null ? null : new HistoryItem.fromProxy(jsProxy);
VisitItem _createVisitItem(JsObject jsProxy) => jsProxy == null ? null : new VisitItem.fromProxy(jsProxy);
