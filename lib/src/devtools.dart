library chrome.devtools;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';

/// accessor for the `chrome.devtools` namespace.
const Devtools devtools = const Devtools._();

get _devtools => chromeProxy.devtools;

final InspectedWindow _iw = new InspectedWindow._();

get _inspectedWindow => _devtools.inspectedWindow;

class Devtools {
  const Devtools._();

  InspectedWindow get inspectedWindow => _iw;
}

class InspectedWindow {

  InspectedWindow._();

  /**
   *  The ID of the tab being inspected. This ID may be used with
   *  chrome.tabs.* API.
   */
  int get tabId => js.scoped(() => _inspectedWindow.tabId);

  /**
   * Evaluates a JavaScript [expression] in the context of the main frame of
   * the inspected page. The expression must evaluate to a
   * JSON-compliant object, otherwise an exception is thrown.
   */
  Future eval(String jsExpression) {
    var completer = new Completer();
    js.scoped(() {
      _inspectedWindow.eval(jsExpression, new js.Callback.once(
          (result, isException) {
            if (isException) {
              completer.completeError(result);
            } else {
              completer.complete(result);
            }
          }));
    });
    return completer.future;
  }

  /**
   * Reloads the inspected page.
   *
   * If [ignoreCache] is true, the loader will ignore the cache for all
   * inspected page resources loaded before the load event is fired. The effect
   * is similar to pressing Ctrl+Shift+R in the inspected window or within the
   * Developer Tools window.
   *
   * If [userAgent] is specified, the string will override the
   * value of the User-Agent HTTP header that's sent while loading the
   * resources of the inspected page. The string will also override the value
   * of the navigator.userAgent property that's returned to any scripts that
   * are running within the inspected page.
   *
   * if [injectedScript] is specified, the script will be injected into every
   * frame of the inspected page immediately upon load, before any of the
   * frame's scripts. The script will not be injected after subsequent
   * reloads—for example, if the user presses Ctrl+R.
   */
  void reload({bool ignoreCache, String userAgent, String injectedScript}) {
    Map<String, dynamic> reloadOptions = {};
    if (ignoreCache is bool) {
      reloadOptions['ignoreCache'] = ignoreCache;
    }
    if (userAgent is String) {
      reloadOptions['userAgent'] = userAgent;
    }
    if (injectedScript is String) {
      reloadOptions['injectedScript'] = injectedScript;
    }
    js.scoped(() {
      _inspectedWindow.reload(js.map(reloadOptions));
    });
  }

  /// Retrieves the list of resources from the inspected page.
  Future<List<Resource>> getResources() {
    var completer = new ChromeCompleter.oneArg((List resources) =>
        resources.map((resource) => new Resource._(resource.url)));
    js.scoped(() {
      _inspectedWindow.getResources(completer.callback);
    });
    return completer.future;
  }

  final ChromeStreamController<Resource> _onResourceAdded =
      new ChromeStreamController<Resource>.oneArg(
          () => _inspectedWindow.onResourceAdded,
          (resource) => new Resource._(resource));

  /// Fired when a new resource is added to the inspected page.
  Stream<Resource> get onResourceAdded => _onResourceAdded.stream;

  final ChromeStreamController<ResourceContentCommittedEvent>
      _onResourceContentCommitted =
          new ChromeStreamController<ResourceContentCommittedEvent>.twoArgs(
              () => _inspectedWindow.onResourceContentCommitted,
              (resource, content) => new ResourceContentCommittedEvent._(
                  new Resource._(resource), content));

  /**
   * Fired when a new revision of the resource is committed (e.g. user saves
   * an edited version of the resource in the Developer Tools).
   */
  Stream<ResourceContentCommittedEvent> get onResourceContentCommitted =>
      _onResourceContentCommitted.stream;
}

class Resource {
  final _resource;

  Resource._(this._resource) {
    js.retain(_resource);
  }

  Future<ResourceContent> getContent() {
    var completer = new ChromeCompleter.twoArgs((content, encoding) =>
        new ResourceContent._(content, encoding));
    js.scoped(() {
      _resource.getContent(completer.callback);
    });
    return completer.future;
  }

  Future setContent(String content, bool commit) {
    var completer = new Completer();
    js.scoped(() {
      _resource.setContent(content, commit, new js.Callback.once((error) {
        if (error != null) {
          completer.completeError(error);
        } else {
          completer.complete();
        }
      }));
    });
    return completer.future;
  }

  void release() {
    js.release(_resource);
  }
}

class ResourceContent {
  final String content;
  final String encoding;

  const ResourceContent._(this.content, this.encoding);
}

class ResourceContentCommittedEvent {
  final Resource resource;
  final String content;

  const ResourceContentCommittedEvent._(this.resource, this.content);
}