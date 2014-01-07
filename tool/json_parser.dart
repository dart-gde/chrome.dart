
library json_parser;

import 'dart:convert';
import 'dart:io';

import 'json_model.dart';

void main(List<String> args) {
  JsonNamespace namespace = parse(new File(args.first).readAsStringSync());

  print(namespace);
}

JsonNamespace parse(String jsonText) {
  // pre-filter to remove line comments -
  List<String> lines = new LineSplitter().convert(jsonText);
  Iterable newLines = lines.map((String line) {
    int index = line.indexOf('//');

    // If we find // foo, we remove it from the line, unless it looks like
    // :// foo (as in, http://cheese.com).

    if (index == -1) {
      return line;
    } else if (index == 0 || line.codeUnitAt(index - 1) != 58) { // 58 == ':'
      return line.substring(0, index);
    } else {
      return line;
    }
  });

  return _parseJson(JSON.decode(newLines.join('\n')));
}

JsonNamespace _parseJson(dynamic json) {
  Map m = json[0];

  return new JsonNamespace(json[0]);
}
