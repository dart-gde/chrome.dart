// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library read_yaml;

import 'package:dartdoc_viewer/data.dart';
import 'package:dartdoc_viewer/item.dart';
import 'package:yaml/yaml.dart';

import 'dart:async';
import 'dart:html';
import 'dart:convert';

/**
 * Retrieves a file at the given [path].
 */
Future<String> retrieveFileContents(String path) =>
    HttpRequest.getString(Uri.encodeFull(path));

/**
 * Creates a [Library] object from the [response] string of YAML.
 */
Item loadData(String response) {
  var doc = isYaml ? loadYaml(response) :
      response == '' ? null : JSON.decode(response);
  return doc == null ? null : new Library(doc);
}
