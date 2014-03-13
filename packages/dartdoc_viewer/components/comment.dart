// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web.comment;

import 'dart:html';
import 'dart:js' as js;
import 'package:dartdoc_viewer/item.dart';
import 'package:dartdoc_viewer/location.dart';
import 'package:dartdoc_viewer/search.dart' show searchIndex;
import 'package:polymer/polymer.dart';
import 'package:dartdoc_viewer/app.dart' show viewer;
import 'package:dartdoc_viewer/member.dart';

// TODO(jmesserly): extend section once this bug is fixed?
// https://codereview.chromium.org/90113002/
@CustomTag('dartdoc-comment')
class CommentElement extends DivElement with Polymer, ChangeNotifier {
  @reflectable @published Container get item => __$item; Container __$item; @reflectable set item(Container value) { __$item = notifyPropertyChange(#item, __$item, value); }
  @reflectable @published bool get preview => __$preview; bool __$preview = false; @reflectable set preview(bool value) { __$preview = notifyPropertyChange(#preview, __$preview, value); }
  Element _commentElement;

  factory CommentElement() => new Element.tag('div', 'dartdoc-comment');

  CommentElement.created() : super.created() {
    polymerCreated();
    classes.add('description');
  }

  itemChanged() => _updateComment();
  previewChanged() => _updateComment();

  enteredView() {
    super.enteredView();
    searchIndex.onLoad(_updateComment);
  }

  /// Adds [item]'s comment to the the element with markdown links converted to
  /// working links.
  void _updateComment() {
    if (_commentElement != null) {
      _commentElement.remove();
      _commentElement = null;
    }

    if (item == null) return;

    var comment = item.comment;
    if (preview && (item is Class || item is Library)) {
      comment = (item as LazyItem).previewComment;
    }
    if (comment != '' && comment != null) {
      // TODO(jmesserly): for now, trusting doc comment HTML.
      _commentElement = new Element.html(comment, treeSanitizer: nullSanitizer);
      var firstParagraph = (_commentElement is ParagraphElement) ?
          _commentElement : _commentElement.querySelector("p");
      if (firstParagraph != null) {
        firstParagraph.classes.add("firstParagraph");
      }
      var links = _commentElement.querySelectorAll('a');
      for (AnchorElement link in links) {
        _resolveLink(link);
      }
      var codeBlocks = _commentElement.querySelectorAll('code');
      for (var e in codeBlocks) {
        var pretty = js.context.callMethod('prettyPrintOne',
            [e.innerHtml, 'dart']);
        // TODO(jmesserly): do we need to sanitize here?
        e.setInnerHtml(pretty, treeSanitizer: nullSanitizer);
      }
      append(_commentElement);
    }
  }

  /// If [link] refers to a method/function parameter, i.e. it's of the form
  ///       dart-core.Object.doStuff.param OR
  ///       dart-async.runZoned.param
  /// representing either a method or a function. then replace it with the
  /// last two elements as part of an @ tag instead. e.g.
  /// dart-core.Object@id_doStuff.param. Return true if we did so.
  bool _replaceWithParameterReference(AnchorElement link, DocsLocation loc) {
    var item = loc.item(viewer.homePage);
    if (item is! Parameter) return false;
    var newAnchor = new AnchorElement()
      ..href = item.prefixedAnchorHref
      ..text = loc.lastName;
    link.replaceWith(newAnchor);
    return true;
  }

  void _resolveLink(AnchorElement link) {
    if (link.href != '') return;
    var loc = new DocsLocation(link.text);
    if (_replaceWithParameterReference(link, loc)) return;
    if (searchIndex.map.containsKey(link.text)) {
      _setLinkReference(link, loc);
      return;
    }

    // Not everything that has links is in the index (examples are local links
    // to inherited methods like noSuchMethod). Check the parent and
    // see if you can link from there.
    if (searchIndex.map.containsKey(loc.parentQualifiedName)) {
      _setLinkReference(link, loc);
      return;
    }

    loc.packageName = null;
    if (searchIndex.map.containsKey(loc.withAnchor)) {
      _setLinkReference(link, loc);
      return;
    }
    // If markdown links to private or otherwise unknown members are
    // found, make them <i> tags instead of <a> tags for CSS.
    link.replaceWith(new Element.tag('i')..text = link.text);
  }

  void _setLinkReference(AnchorElement link, DocsLocation loc) {
    var linkable = new LinkableType(loc.withAnchor);
    link
      ..href = locationPrefixed(linkable.location)
      ..text = linkable.simpleType;
  }
}
