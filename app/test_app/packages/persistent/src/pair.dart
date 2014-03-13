// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

part of persistent;

class Pair<A, B> {
  final A fst;
  final B snd;
  Pair(this.fst, this.snd);
  bool operator ==(Pair<A, B> other) =>
      (other is Pair<A, B>)
      && fst == other.fst
      && snd == other.snd;
  int get hashCode => fst.hashCode + 31 * snd.hashCode;
  String toString() => "Pair($fst, $snd)";
}
