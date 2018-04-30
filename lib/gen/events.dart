/* This file has been generated from events.json - do not edit */

/**
 * The `chrome.events` namespace contains common types used by APIs dispatching
 * events to notify you when something interesting happens.
 */
library chrome.events;

import '../src/common.dart';

/**
 * Accessor for the `chrome.events` namespace.
 */
final ChromeEvents events = new ChromeEvents._();

class ChromeEvents extends ChromeApi {
  JsObject get _events => chrome['events'];

  ChromeEvents._();

  bool get available => _events != null;
}

/**
 * Description of a declarative rule for handling events.
 */
class Rule extends ChromeObject {
  Rule({String id, List<String> tags, List<dynamic> conditions, List<dynamic> actions, int priority}) {
    if (id != null) this.id = id;
    if (tags != null) this.tags = tags;
    if (conditions != null) this.conditions = conditions;
    if (actions != null) this.actions = actions;
    if (priority != null) this.priority = priority;
  }
  Rule.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Optional identifier that allows referencing this rule.
   */
  String get id => jsProxy['id'];
  set id(String value) => jsProxy['id'] = value;

  /**
   * Tags can be used to annotate rules and perform operations on sets of rules.
   */
  List<String> get tags => listify(jsProxy['tags']);
  set tags(List<String> value) => jsProxy['tags'] = jsify(value);

  /**
   * List of conditions that can trigger the actions.
   */
  List<dynamic> get conditions => listify(jsProxy['conditions']);
  set conditions(List<dynamic> value) => jsProxy['conditions'] = jsify(value);

  /**
   * List of actions that are triggered if one of the conditions is fulfilled.
   */
  List<dynamic> get actions => listify(jsProxy['actions']);
  set actions(List<dynamic> value) => jsProxy['actions'] = jsify(value);

  /**
   * Optional priority of this rule. Defaults to 100.
   */
  int get priority => jsProxy['priority'];
  set priority(int value) => jsProxy['priority'] = value;
}

/**
 * An object which allows the addition and removal of listeners for a Chrome
 * event.
 */
class ChromeEvent extends ChromeObject {
  ChromeEvent();
  ChromeEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Registers an event listener _callback_ to an event.
   */
  Future addListener() {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('addListener', [completer.callback]);
    return completer.future;
  }

  /**
   * Deregisters an event listener _callback_ from an event.
   */
  Future removeListener() {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('removeListener', [completer.callback]);
    return completer.future;
  }

  bool hasListener(dynamic callback) {
    return jsProxy.callMethod('hasListener', [jsify(callback)]);
  }

  bool hasListeners() {
    return jsProxy.callMethod('hasListeners');
  }

  /**
   * Registers rules to handle events.
   * 
   * [eventName] Name of the event this function affects.
   * 
   * [webViewInstanceId] If provided, this is an integer that uniquely identfies
   * the <webview> associated with this function call.
   * 
   * [rules] Rules to be registered. These do not replace previously registered
   * rules.
   * 
   * Returns:
   * Rules that were registered, the optional parameters are filled with values.
   */
  Future<List<Rule>> addRules(String eventName, int webViewInstanceId, List<Rule> rules) {
    var completer = new ChromeCompleter<List<Rule>>.oneArg((e) => listify(e, _createRule));
    jsProxy.callMethod('addRules', [eventName, webViewInstanceId, jsify(rules), completer.callback]);
    return completer.future;
  }

  /**
   * Returns currently registered rules.
   * 
   * [eventName] Name of the event this function affects.
   * 
   * [webViewInstanceId] If provided, this is an integer that uniquely identfies
   * the <webview> associated with this function call.
   * 
   * [ruleIdentifiers] If an array is passed, only rules with identifiers
   * contained in this array are returned.
   * 
   * Returns:
   * Rules that were registered, the optional parameters are filled with values.
   */
  Future<List<Rule>> getRules(String eventName, int webViewInstanceId, [List<String> ruleIdentifiers]) {
    var completer = new ChromeCompleter<List<Rule>>.oneArg((e) => listify(e, _createRule));
    jsProxy.callMethod('getRules', [eventName, webViewInstanceId, jsify(ruleIdentifiers), completer.callback]);
    return completer.future;
  }

  /**
   * Unregisters currently registered rules.
   * 
   * [eventName] Name of the event this function affects.
   * 
   * [webViewInstanceId] If provided, this is an integer that uniquely identfies
   * the <webview> associated with this function call.
   * 
   * [ruleIdentifiers] If an array is passed, only rules with identifiers
   * contained in this array are unregistered.
   */
  Future removeRules(String eventName, int webViewInstanceId, [List<String> ruleIdentifiers]) {
    var completer = new ChromeCompleter.noArgs();
    jsProxy.callMethod('removeRules', [eventName, webViewInstanceId, jsify(ruleIdentifiers), completer.callback]);
    return completer.future;
  }
}

/**
 * Filters URLs for various criteria. See [event filtering](events#filtered).
 * All criteria are case sensitive.
 */
class UrlFilter extends ChromeObject {
  UrlFilter({String hostContains, String hostEquals, String hostPrefix, String hostSuffix, String pathContains, String pathEquals, String pathPrefix, String pathSuffix, String queryContains, String queryEquals, String queryPrefix, String querySuffix, String urlContains, String urlEquals, String urlMatches, String originAndPathMatches, String urlPrefix, String urlSuffix, List<String> schemes, List<dynamic> ports}) {
    if (hostContains != null) this.hostContains = hostContains;
    if (hostEquals != null) this.hostEquals = hostEquals;
    if (hostPrefix != null) this.hostPrefix = hostPrefix;
    if (hostSuffix != null) this.hostSuffix = hostSuffix;
    if (pathContains != null) this.pathContains = pathContains;
    if (pathEquals != null) this.pathEquals = pathEquals;
    if (pathPrefix != null) this.pathPrefix = pathPrefix;
    if (pathSuffix != null) this.pathSuffix = pathSuffix;
    if (queryContains != null) this.queryContains = queryContains;
    if (queryEquals != null) this.queryEquals = queryEquals;
    if (queryPrefix != null) this.queryPrefix = queryPrefix;
    if (querySuffix != null) this.querySuffix = querySuffix;
    if (urlContains != null) this.urlContains = urlContains;
    if (urlEquals != null) this.urlEquals = urlEquals;
    if (urlMatches != null) this.urlMatches = urlMatches;
    if (originAndPathMatches != null) this.originAndPathMatches = originAndPathMatches;
    if (urlPrefix != null) this.urlPrefix = urlPrefix;
    if (urlSuffix != null) this.urlSuffix = urlSuffix;
    if (schemes != null) this.schemes = schemes;
    if (ports != null) this.ports = ports;
  }
  UrlFilter.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * Matches if the host name of the URL contains a specified string. To test
   * whether a host name component has a prefix 'foo', use hostContains: '.foo'.
   * This matches 'www.foobar.com' and 'foo.com', because an implicit dot is
   * added at the beginning of the host name. Similarly, hostContains can be
   * used to match against component suffix ('foo.') and to exactly match
   * against components ('.foo.'). Suffix- and exact-matching for the last
   * components need to be done separately using hostSuffix, because no implicit
   * dot is added at the end of the host name.
   */
  String get hostContains => jsProxy['hostContains'];
  set hostContains(String value) => jsProxy['hostContains'] = value;

  /**
   * Matches if the host name of the URL is equal to a specified string.
   */
  String get hostEquals => jsProxy['hostEquals'];
  set hostEquals(String value) => jsProxy['hostEquals'] = value;

  /**
   * Matches if the host name of the URL starts with a specified string.
   */
  String get hostPrefix => jsProxy['hostPrefix'];
  set hostPrefix(String value) => jsProxy['hostPrefix'] = value;

  /**
   * Matches if the host name of the URL ends with a specified string.
   */
  String get hostSuffix => jsProxy['hostSuffix'];
  set hostSuffix(String value) => jsProxy['hostSuffix'] = value;

  /**
   * Matches if the path segment of the URL contains a specified string.
   */
  String get pathContains => jsProxy['pathContains'];
  set pathContains(String value) => jsProxy['pathContains'] = value;

  /**
   * Matches if the path segment of the URL is equal to a specified string.
   */
  String get pathEquals => jsProxy['pathEquals'];
  set pathEquals(String value) => jsProxy['pathEquals'] = value;

  /**
   * Matches if the path segment of the URL starts with a specified string.
   */
  String get pathPrefix => jsProxy['pathPrefix'];
  set pathPrefix(String value) => jsProxy['pathPrefix'] = value;

  /**
   * Matches if the path segment of the URL ends with a specified string.
   */
  String get pathSuffix => jsProxy['pathSuffix'];
  set pathSuffix(String value) => jsProxy['pathSuffix'] = value;

  /**
   * Matches if the query segment of the URL contains a specified string.
   */
  String get queryContains => jsProxy['queryContains'];
  set queryContains(String value) => jsProxy['queryContains'] = value;

  /**
   * Matches if the query segment of the URL is equal to a specified string.
   */
  String get queryEquals => jsProxy['queryEquals'];
  set queryEquals(String value) => jsProxy['queryEquals'] = value;

  /**
   * Matches if the query segment of the URL starts with a specified string.
   */
  String get queryPrefix => jsProxy['queryPrefix'];
  set queryPrefix(String value) => jsProxy['queryPrefix'] = value;

  /**
   * Matches if the query segment of the URL ends with a specified string.
   */
  String get querySuffix => jsProxy['querySuffix'];
  set querySuffix(String value) => jsProxy['querySuffix'] = value;

  /**
   * Matches if the URL (without fragment identifier) contains a specified
   * string. Port numbers are stripped from the URL if they match the default
   * port number.
   */
  String get urlContains => jsProxy['urlContains'];
  set urlContains(String value) => jsProxy['urlContains'] = value;

  /**
   * Matches if the URL (without fragment identifier) is equal to a specified
   * string. Port numbers are stripped from the URL if they match the default
   * port number.
   */
  String get urlEquals => jsProxy['urlEquals'];
  set urlEquals(String value) => jsProxy['urlEquals'] = value;

  /**
   * Matches if the URL (without fragment identifier) matches a specified
   * regular expression. Port numbers are stripped from the URL if they match
   * the default port number. The regular expressions use the [RE2
   * syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
   */
  String get urlMatches => jsProxy['urlMatches'];
  set urlMatches(String value) => jsProxy['urlMatches'] = value;

  /**
   * Matches if the URL without query segment and fragment identifier matches a
   * specified regular expression. Port numbers are stripped from the URL if
   * they match the default port number. The regular expressions use the [RE2
   * syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
   */
  String get originAndPathMatches => jsProxy['originAndPathMatches'];
  set originAndPathMatches(String value) => jsProxy['originAndPathMatches'] = value;

  /**
   * Matches if the URL (without fragment identifier) starts with a specified
   * string. Port numbers are stripped from the URL if they match the default
   * port number.
   */
  String get urlPrefix => jsProxy['urlPrefix'];
  set urlPrefix(String value) => jsProxy['urlPrefix'] = value;

  /**
   * Matches if the URL (without fragment identifier) ends with a specified
   * string. Port numbers are stripped from the URL if they match the default
   * port number.
   */
  String get urlSuffix => jsProxy['urlSuffix'];
  set urlSuffix(String value) => jsProxy['urlSuffix'] = value;

  /**
   * Matches if the scheme of the URL is equal to any of the schemes specified
   * in the array.
   */
  List<String> get schemes => listify(jsProxy['schemes']);
  set schemes(List<String> value) => jsProxy['schemes'] = jsify(value);

  /**
   * Matches if the port of the URL is contained in any of the specified port
   * lists. For example `[80, 443, [1000, 1200]]` matches all requests on port
   * 80, 443 and in the range 1000-1200.
   */
  List<dynamic> get ports => listify(jsProxy['ports']);
  set ports(List<dynamic> value) => jsProxy['ports'] = jsify(value);
}

Rule _createRule(JsObject jsProxy) => jsProxy == null ? null : new Rule.fromProxy(jsProxy);
