library chrome.context_menus;

import 'dart:async';

import 'package:js/js.dart' as js;

import 'common.dart';
import 'tabs.dart';

ContextMenus contextMenus = new ContextMenus();

/**
 * @param info Information about the item clicked and the context where the
 *             click happened.
 * @param tab The details of the tab where the click took place. If the click
 *            did not take place in a tab, this parameter will be missing.
 */
typedef void onContextMenuClickedCallback(
    OnContextMenuClickData info, {Tab tab});

class ContextMenus {

  js.Proxy get _contextMenus => js.context.chrome.contextMenus;

  /**
   * Creates a new context menu item.
   *
   * @param type The type of menu item. Defaults to 'normal' if not specified.
   * @param id The unique ID to assign to this item. Mandatory for event pages.
   *           Cannot be the same as another ID for this extension.
   * @param title The text to be displayed in the item; this is required unless
   *              type is 'separator'. When the context is 'selection', you can
   *              use %s within the string to show the selected text. For
   *              example, if this parameter's value is "Translate '%s' to
   *              Pig Latin" and the user selects the word "cool", the context
   *              menu item for the selection is "Translate 'cool' to
   *              Pig Latin".
   * @param checked The initial state of a checkbox or radio item: true for
   *                selected and false for unselected. Only one radio item can
   *                be selected at a time in a given group of radio items.
   * @param contexts List of contexts this menu item will appear in. Defaults
   *                 to ['page'] if not specified. Specifying ['all'] is
   *                 equivalent to the combination of all other contexts except
   *                 for 'launcher'. The 'launcher' context is only supported
   *                 by apps and is used to add menu items to the context menu
   *                 that appears when clicking on the app icon in the
   *                 launcher/taskbar/dock/etc. Different platforms might put
   *                 limitations on what is actually supported in a launcher
   *                 context menu.
   * @param onclick A function that will be called back when the menu item is
   *                clicked. Event pages cannot use this; instead, they should
   *                register a listener for chrome.contextMenus.onClicked.
   * @param parentId The ID of a parent menu item; this makes the item a child
   *                 of a previously added item.
   * @param documentUrlPatterns Lets you restrict the item to apply only to
   *                            documents whose URL matches one of the given
   *                            patterns. (This applies to frames as well.) For
   *                            details on the format of a pattern, see Match
   *                            Patterns.
   * @param targetUrlPatterns Similar to documentUrlPatterns, but lets you
   *                          filter based on the src attribute of
   *                          img/audio/video tags and the href of anchor tags.
   * @param enabled Whether this context menu item is enabled or disabled.
   *                Defaults to true.
   */
  Future create({
    ContextMenuType type,
      String id,
      String title,
      bool checked,
      List<ContextMenuContext> contexts,
      onContextMenuClickedCallback onClick,
      String parentId,
      List<String> documentUrlPatterns,
      List<String> targetUrlPatterns,
      bool enabled}) {
    Map<String, dynamic> createProperties = { };
    if (type != null) {
      createProperties['type'] = type.toString();
    }
    if (id != null) {
      createProperties['id'] = id;
    }
    if (title != null) {
      createProperties['title'] = title;
    }
    if (checked != null) {
      createProperties['checked'] = checked;
    }
    if (contexts != null) {
      createProperties['contexts'] = contexts.map((context) =>
          context.toString());
    }
    if (onClick != null) {
      createProperties['onclick'] = _createClickListenerFunction(onClick);
    }
    if (parentId != null) {
      createProperties['parentId'] = parentId;
    }
    if (documentUrlPatterns != null) {
      createProperties['documentUrlPatterns'] = documentUrlPatterns;
    }
    if (targetUrlPatterns != null) {
      createProperties['targetUrlPatterns'] = targetUrlPatterns;
    }
    if (enabled != null) {
      createProperties['enabled'] = enabled;
    }

    ChromeCompleter completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _contextMenus.create(js.map(createProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Updates a previously created context menu item.
   *
   * @param id The ID of the item to update.
   * @param parentId Note: You cannot change an item to be a child of one of
   *                 its own descendants.
   */
  Future update(String id, {
    ContextMenuType type,
      String title,
      bool checked,
      List<ContextMenuContext> contexts,
      onContextMenuClickedCallback onClick,
      String parentId,
      List<String> documentUrlPatterns,
      List<String> targetUrlPatterns,
      bool enabled}) {
    Map<String, dynamic> updateProperties = { };
    if (type != null) {
      updateProperties['type'] = type.toString();
    }
    if (title != null) {
      updateProperties['title'] = title;
    }
    if (checked != null) {
      updateProperties['checked'] = checked;
    }
    if (contexts != null) {
      updateProperties['contexts'] = contexts.map((context) =>
          context.toString());
    }
    if (onClick != null) {
      updateProperties['onclick'] = _createClickListenerFunction(onClick);
    }
    if (parentId != null) {
      updateProperties['parentId'] = parentId;
    }
    if (documentUrlPatterns != null) {
      updateProperties['documentUrlPatterns'] = documentUrlPatterns;
    }
    if (targetUrlPatterns != null) {
      updateProperties['targetUrlPatterns'] = targetUrlPatterns;
    }
    if (enabled != null) {
      updateProperties['enabled'] = enabled;
    }

    ChromeCompleter completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _contextMenus.update(id, js.map(updateProperties), completer.callback);
    });
    return completer.future;
  }

  /**
   * Removes a context menu item.
   *
   * @param id The ID of the context menu item to remove.
   */
  Future remove(String id) {
    ChromeCompleter completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _contextMenus.remove(id, completer.callback);
    });
    return completer.future;
  }

  /**
   * Removes all context menu items added by this extension.
   */
  Future removeAll() {
    ChromeCompleter completer = new ChromeCompleter.noArgs();
    js.scoped(() {
      _contextMenus.removeAll(completer.callback);
    });
    return completer.future;
  }

  /**
   * Fired when a context menu item is clicked.
   */
  void onClicked(onContextMenuClickedCallback listener) {
    js.scoped(() {
      _contextMenus.onClicked
          .addListener(_createClickListenerFunction(listener));
    });
  }

  js.Callback _createClickListenerFunction(onContextMenuClickedCallback listener) {
    return new js.Callback.many((dynamic clickData, [dynamic tab]) {
      if (listener != null) {
        if (tab != null) {
          listener(new OnContextMenuClickData(clickData), tab: new Tab(tab));
        } else {
          listener(new OnContextMenuClickData(clickData));
        }
      }
    });
  }
}

class OnContextMenuClickData {
  js.Proxy _onClickData;

  OnContextMenuClickData(this._onClickData);

  String get menuItemId {
    return _onClickData.menutItemId.toString();
  }

  String get parentMenuItemId {
    return _onClickData.parentMenuItemId.toString();
  }

  String get mediaType {
    return _onClickData.mediaType;
  }

  String get linkUrl {
    return _onClickData.linkUrl;
  }

  String get srcUrl {
    return _onClickData.srcUrl;
  }

  String get pageUrl {
    return _onClickData.pageUrl;
  }

  String get frameUrl {
    return _onClickData.frameUrl;
  }

  String get selectionText {
    return _onClickData.selectionText;
  }

  bool get editable {
    return _onClickData.editable;
  }

  bool get wasChecked {
    return _onClickData.wasChecked;
  }

  bool get checked {
    return _onClickData.checked;
  }
}

class ContextMenuType {
  final String _type;

  const ContextMenuType._internal(this._type);

  factory ContextMenuType(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return NORMAL;
      case 'checkbox':
        return CHECKBOX;
      case 'radio':
        return RADIO;
      case 'separator':
        return SEPARATOR;
      default:
        throw 'Unknown ContextMenuType: $type';
    }
  }

  String toString() {
    return _type;
  }

  static const ContextMenuType NORMAL =
      const ContextMenuType._internal('normal');
  static const ContextMenuType CHECKBOX =
      const ContextMenuType._internal('checkbox');
  static const ContextMenuType RADIO =
      const ContextMenuType._internal('radio');
  static const ContextMenuType SEPARATOR =
      const ContextMenuType._internal('separator');
}

class ContextMenuContext {
  final String _context;

  const ContextMenuContext._internal(this._context);

  factory ContextMenuContext(String context) {
    switch (context.toLowerCase()) {
      case 'all':
        return ALL;
      case 'page':
        return PAGE;
      case 'frame':
        return FRAME;
      case 'selection':
        return SELECTION;
      case 'link':
        return LINK;
      case 'editable':
        return EDITABLE;
      case 'image':
        return IMAGE;
      case 'video':
        return VIDEO;
      case 'audio':
        return AUDIO;
      case 'launcher':
        return LAUNCHER;
      default:
        throw 'Unknown ContextMenuContext: $context';
    }
  }

  String toString() {
    return _context;
  }

  static const ContextMenuContext ALL =
      const ContextMenuContext._internal('all');
  static const ContextMenuContext PAGE =
      const ContextMenuContext._internal('page');
  static const ContextMenuContext FRAME =
      const ContextMenuContext._internal('frame');
  static const ContextMenuContext SELECTION =
      const ContextMenuContext._internal('selection');
  static const ContextMenuContext LINK =
      const ContextMenuContext._internal('link');
  static const ContextMenuContext EDITABLE =
      const ContextMenuContext._internal('editable');
  static const ContextMenuContext IMAGE =
      const ContextMenuContext._internal('image');
  static const ContextMenuContext VIDEO =
      const ContextMenuContext._internal('video');
  static const ContextMenuContext AUDIO =
      const ContextMenuContext._internal('audio');
  static const ContextMenuContext LAUNCHER =
      const ContextMenuContext._internal('launcher');

}