// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

part of persistent;

abstract class LinkedList<E> implements Iterable<E> {
  bool get isNil;
  bool get isCons;
  Nil<E> get asNil;
  Cons<E> get asCons;

  void foreach(f(A));
  /// A strict (non-lazy) version of [:map:].
  LinkedList strictMap(f(A));
  /// A strict (non-lazy) version of [:where:].
  LinkedList<E> strictWhere(bool f(A));
}

class LinkedListBuilder<E> {
  LinkedList<E> _first = null;
  Cons<E> _last = null;

  void add(E x) {
    Cons<E> cons = new Cons<E>(x, null);
    if (_first == null) {
      _first = cons;
    } else {
      _last.tail = cons;
    }
    _last = cons;
  }

  LinkedList<E> build([tail = null]) {
    if (tail == null)
      tail = new Nil<E>();
    if (_first == null) {
      return tail;
    } else {
      _last.tail = tail;
      return _first;
    }
  }
}

abstract class _LinkedListBase<E> extends IterableBase<E>
    implements LinkedList<E> {

  void foreach(f(A)) {
    LinkedList<E> it = this;
    while (!it.isNil) {
      Cons<E> cons = it.asCons;
      f(cons.elem);
      it = cons.tail;
    }
  }

  LinkedList strictMap(f(A)) {
    LinkedListBuilder<E> builder = new LinkedListBuilder<E>();
    LinkedList<E> it = this;
    while (it.isCons) {
      Cons<E> cons = it.asCons;
      E elem = cons.elem;
      builder.add(f(elem));
      it = cons.tail;
    }
    return builder.build();
  }

  LinkedList<E> strictWhere(bool f(A)) {
    LinkedListBuilder<E> builder = new LinkedListBuilder<E>();
    LinkedList<E> it = this;
    while (it.isCons) {
      Cons<E> cons = it.asCons;
      E elem = cons.elem;
      if (f(elem)) builder.add(elem);
      it = cons.tail;
    }
    return builder.build();
  }
}

class _NilIterator<E> implements Iterator<E> {
  const _NilIterator();
  E get current => null;
  bool moveNext() => false;
}

class Nil<E> extends _LinkedListBase<E> {
  bool get isNil => true;
  bool get isCons => false;
  Nil<E> get asNil => this;
  Cons<E> get asCons => null;

  toString() => "nil()";

  int get length => 0;

  Iterator<E> get iterator => const _NilIterator();
}

class _ConsIterator<E> implements Iterator<E> {
  final LinkedList<E> _head;
  LinkedList<E> _current = null;

  _ConsIterator(this._head);

  E get current => _current.isCons ? _current.asCons.elem : null;

  bool moveNext() {
    if (_current == null) {
      _current = _head;
      return _current.isCons;
    }
    if (_current.isCons) {
      _current = _current.asCons.tail;
      return _current.isCons;
    }
    return false;
  }
}

class Cons<E> extends _LinkedListBase<E> {
  int _length = null;

  final E elem;
  LinkedList<E> tail;

  Cons(this.elem, this.tail);

  bool get isNil => false;
  bool get isCons => true;
  Nil<E> get asNil => null;
  Cons<E> get asCons => this;

  toString() => "cons($elem, $tail)";

  int get length {
    if (_length == null) {
      _length = tail.length + 1;
    }
    return _length;
  }

  Iterator<E> get iterator => new _ConsIterator<E>(this);
}
