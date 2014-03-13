// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.main;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/app.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/member.dart';
import 'package:dartdoc_viewer/read_yaml.dart';
import 'search.dart';

// TODO(alanknight): Clean up the dart-style CSS file's formatting once
// it's stable.
@CustomTag("dartdoc-main")
class MainElement extends DartdocElement with ChangeNotifier  {
  @reflectable @observable String get version => __$version; String __$version; @reflectable set version(String value) { __$version = notifyPropertyChange(#version, __$version, value); }
  @reflectable @observable String get pageContentClass => __$pageContentClass; String __$pageContentClass; @reflectable set pageContentClass(String value) { __$pageContentClass = notifyPropertyChange(#pageContentClass, __$pageContentClass, value); }
  @reflectable @observable bool get shouldShowLibraryPanel => __$shouldShowLibraryPanel; bool __$shouldShowLibraryPanel; @reflectable set shouldShowLibraryPanel(bool value) { __$shouldShowLibraryPanel = notifyPropertyChange(#shouldShowLibraryPanel, __$shouldShowLibraryPanel, value); }
  @reflectable @observable bool get shouldShowLibraryMinimap => __$shouldShowLibraryMinimap; bool __$shouldShowLibraryMinimap; @reflectable set shouldShowLibraryMinimap(bool value) { __$shouldShowLibraryMinimap = notifyPropertyChange(#shouldShowLibraryMinimap, __$shouldShowLibraryMinimap, value); }
  @reflectable @observable bool get shouldShowClassMinimap => __$shouldShowClassMinimap; bool __$shouldShowClassMinimap; @reflectable set shouldShowClassMinimap(bool value) { __$shouldShowClassMinimap = notifyPropertyChange(#shouldShowClassMinimap, __$shouldShowClassMinimap, value); }

  // TODO(jmesserly): somewhat unfortunate, but for now we don't have
  // polymer_expressions so we need a workaround.
  @reflectable @observable String get showOrHideLibraries => __$showOrHideLibraries; String __$showOrHideLibraries; @reflectable set showOrHideLibraries(String value) { __$showOrHideLibraries = notifyPropertyChange(#showOrHideLibraries, __$showOrHideLibraries, value); }
  @reflectable @observable String get showOrHideMinimap => __$showOrHideMinimap; String __$showOrHideMinimap; @reflectable set showOrHideMinimap(String value) { __$showOrHideMinimap = notifyPropertyChange(#showOrHideMinimap, __$showOrHideMinimap, value); }
  @reflectable @observable String get showOrHideInherited => __$showOrHideInherited; String __$showOrHideInherited; @reflectable set showOrHideInherited(String value) { __$showOrHideInherited = notifyPropertyChange(#showOrHideInherited, __$showOrHideInherited, value); }
  @reflectable @observable String get showOrHideObjectMembers => __$showOrHideObjectMembers; String __$showOrHideObjectMembers; @reflectable set showOrHideObjectMembers(String value) { __$showOrHideObjectMembers = notifyPropertyChange(#showOrHideObjectMembers, __$showOrHideObjectMembers, value); }
  @reflectable @observable String get showOrHidePackages => __$showOrHidePackages; String __$showOrHidePackages; @reflectable set showOrHidePackages(String value) { __$showOrHidePackages = notifyPropertyChange(#showOrHidePackages, __$showOrHidePackages, value); }

  @observable get showVersion {
    if (version == null) {
      version = ''; // Don't try twice.
      retrieveFileContents('docs/VERSION').then((value) {
        version = value;
        notifyPropertyChange(#showVersion, false, true);
      }).catchError((_) => null);
    }

    return version.isNotEmpty;
  }

  /// Records the timestamp of the event that opened the options menu.
  int _openedAt;

  MainElement.created() : super.created();

  void enteredView() {
    super.enteredView();

    registerObserver('viewer', viewer.changes.listen(_onViewerChange));
    registerObserver('onclick',
        onClick.listen(hideOptionsMenuWhenClickedOutside));

    _onViewerChange(null);
  }

  void _onViewerChange(changes) {
    if (!viewer.isDesktop) {
      pageContentClass = '';
    } else {
      var left = viewer.isPanel ? 'margin-left ' : '';
      var right = viewer.isMinimap ? 'margin-right' : '';
      pageContentClass = '$left$right';
    }

    shouldShowLibraryPanel =
        viewer.currentPage != null && viewer.isPanel;

    shouldShowClassMinimap =
        viewer.currentPage is Class && viewer.isMinimap;

    shouldShowLibraryMinimap =
        viewer.currentPage is Library && viewer.isMinimap;

    showOrHideLibraries = viewer.isPanel ? 'Hide' : 'Show';
    showOrHideMinimap = viewer.isMinimap ? 'Hide' : 'Show';
    showOrHideInherited = viewer.isInherited ? 'Hide' : 'Show';
    showOrHideObjectMembers = viewer.showObjectMembers ? 'Hide' : 'Show';
    showOrHidePackages = viewer.showPkgLibraries ? 'Hide' : 'Show';
  }

  Element query(String selectors) => shadowRoot.querySelector(selectors);

  void togglePanel() => viewer.togglePanel();
  void toggleInherited() => viewer.toggleInherited();
  void toggleObjectMembers() => viewer.toggleObjectMembers();
  void toggleMinimap() => viewer.toggleMinimap();
  void togglePkg() => viewer.togglePkg();

  /// We want the search and options to collapse into a menu button if there
  /// isn't room for them to fit, but the amount of room taken up by the
  /// breadcrumbs is dynamic, so we calculate the widths programmatically
  /// and set the collapse style if necessary. As a bonus, when we're expanding
  /// we have to make them visible first in order to measure the width to know
  /// if we should leave them visible or not.
  void collapseSearchAndOptionsIfNeeded() {
    // TODO(alanknight) : This is messy because we've deleted many of the
    // bootstrap-specific attributes, but we need some of it in order to have
    // things look right. This leads to the odd behavior where the drop-down
    // makes the crumbs appear either in the title bar or dropping down,
    // depending how wide the window is. I'm calling that a feature for now,
    // but it could still use cleanup.
    var permanentHeaders = shadowRoot.querySelectorAll(".navbar-brand");
    var searchAndOptions = shadowRoot.querySelector("#searchAndOptions");
    var searchBox = shadowRoot.querySelector("search-box") as Search;
    if (searchBox.isFocused) return;
    var wholeThing = shadowRoot.querySelector(".navbar-fixed-top");
    var navbar = shadowRoot.querySelector("#navbar");
    var collapsible = shadowRoot.querySelector("#nav-collapse-content");
    // First, we make it visible, so we can see how large it _would_ be.
    collapsible.classes.add("in");
    var allItems = permanentHeaders.toList()
      ..add(searchAndOptions)
      ..add(navbar);
    var innerWidth = allItems.fold(0,
        (sum, element) => sum + element.marginEdge.width);
    var outerWidth = wholeThing.contentEdge.width;
    var button = shadowRoot.querySelector("#nav-collapse-button");
    // Then if it's too big, we make it go away again.
    if (outerWidth <= innerWidth) {
      button.classes.add("visible");
      collapsible.classes.remove("in");
    } else {
      button.classes.remove("visible");
      collapsible.classes.add("in");
    }
  }

  void toggleOptionsMenu(MouseEvent event, detail, target) {
    var list = shadowRoot.querySelector(".dropdown-menu").parent;
    if (list.classes.contains("open")) {
      list.classes.remove("open");
    } else {
      _openedAt = event.timeStamp;
      list.classes.add("open");
    }
  }

  void hideOptionsMenuWhenClickedOutside(MouseEvent e) {
    if (_openedAt != null && _openedAt == e.timeStamp) {
      _openedAt == null;
      return;
    }
    hideOptionsMenu();
  }

  void hideOptionsMenu() {
    var list = shadowRoot.querySelector(".dropdown-menu").parent;
    list.classes.remove("open");
  }

  /// Collapse/expand the navbar when in mobile. Workaround for something
  /// that ought to happen magically with bootstrap, but fails in the
  /// presence of shadow DOM.
  void navHideShow(event, detail, target) {
    var nav = shadowRoot.querySelector("#nav-collapse-content");
    hideOrShowNavigation(hide: nav.classes.contains("in"), nav: nav);
  }

  void hideOrShowNavigation({bool hide: true, Element nav}) {
    var searchBox = shadowRoot.querySelector("search-box") as Search;
    if (searchBox.isFocused) return;
    if (nav == null) nav = shadowRoot.querySelector("#nav-collapse-content");
    var button = shadowRoot.querySelector("#nav-collapse-button");
    if (hide && button.getComputedStyle().display != 'none') {
      nav.classes.remove("in");
    } else {
      nav.classes.add("in");
    }
    // The navbar is fixed, but can change size. We need to tell the main
    // body to be below the expanding navbar. This seems to be the least
    // horrible way to do that. But this will only work on the current page,
    // so if we change pages we have to make sure we close this.
    var navbar = shadowRoot.querySelector(".navbar-fixed-top");
    Element body = shadowRoot.querySelector(".main-body");
    var height = navbar.marginEdge.height;
    var positioning = navbar.getComputedStyle().position;
    if (positioning == "fixed") {
      body.style.paddingTop = height.toString() + "px";
    } else {
      body.style.removeProperty("padding-top");
    }
  }
}
