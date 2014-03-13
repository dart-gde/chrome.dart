
library string_codecs;

import 'dart:convert';

class SeparatorCodec extends Codec<List<String>, String> {

  Pattern _splitter;
  String _joiner;

  factory SeparatorCodec(String joiner, {Pattern splitter}) {
    if(splitter == null) splitter = joiner;
    return new SeparatorCodec._(joiner, splitter);
  }

  SeparatorCodec._(this._joiner, this._splitter);

  Converter<String, List<String>> get decoder => new Splitter(_splitter);

  Converter<List<String>, String> get encoder => new Joiner(_joiner);
}

class Splitter extends Converter<String, List<String>> {
  final Pattern _splitter;

  Splitter(this._splitter);

  List<String> convert(String input) => input.split(this._splitter);
}

class Joiner extends Converter<List<String>, String> {
  final String _joiner;

  Joiner(this._joiner);

  String convert(List<String> input) => input.join(this._joiner);
}

class CamelCaseCodec extends Codec<List<String>, String> {

  final bool _capitalizeFirst;

  CamelCaseCodec(this._capitalizeFirst);

  Converter<String, List<String>> get decoder =>
      new CamelCaseDecoder(_capitalizeFirst);

  Converter<List<String>, String> get encoder =>
      new CamelCaseEncoder(_capitalizeFirst);
}

class CamelCaseDecoder extends Converter<String, List<String>> {

  final bool _capitalizeFirst;

  CamelCaseDecoder(this._capitalizeFirst);

  List<String> convert(String input) {
    var segment = new RegExp(r'.[^A-Z]*');
    var matches = segment.allMatches(input);
    return matches
        .map((Match match) =>
            withCapitalization(
                match.input.substring(match.start, match.end),
                false))
        .toList();
  }
}

class CamelCaseEncoder extends Converter<List<String>, String> {

  final bool _capitalizeFirst;

  CamelCaseEncoder(this._capitalizeFirst);

  String convert(List<String> input) {
    var upperCamelCase = input
        .map((item) => withCapitalization(item, true))
        .join("");
    return withCapitalization(upperCamelCase, _capitalizeFirst);
  }
}

final dashesToCamelCase = new SeparatorCodec("-", splitter: new RegExp(r'[_-]'))
    .inverted
    .fuse(new CamelCaseCodec(false));

// Upper-case or lower-case the first charater of a String.
String withCapitalization(String s, bool capitalized) {
  if(s.isEmpty || capitalized == null) return s;
  var firstLetter = s[0];
  firstLetter = capitalized ?
      firstLetter.toUpperCase() :
      firstLetter.toLowerCase();
  return firstLetter + s.substring(1);
}
