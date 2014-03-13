// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * Library to hold all the data needed in the app.
 */
library data;

import 'package:dartdoc_viewer/item.dart';

// Pages generated from the YAML file. Keys are the title of the pages.
final Map<String, Item> pageIndex = {};

// Determines if the input files are in YAML format or JSON format.
bool isYaml = false;
