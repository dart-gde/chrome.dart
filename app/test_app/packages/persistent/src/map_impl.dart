// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

part of persistent;

final _random = new Random();

/**
 * Exception used for aborting forEach loops.
 */
class _Stop implements Exception {}

/**
 * Superclass for _EmptyMap, _Leaf and _SubMap.
 */
abstract class _APersistentMap<K, V> extends PersistentMapBase<K, V> {
  final int length;

  _APersistentMap(this.length, this.isEmpty, this._isLeaf);

  final bool isEmpty;
  final bool _isLeaf;

  Option<V> _lookup(K key, int hash, int depth);
  PersistentMap<K, V> _insertWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth);
  PersistentMap<K, V> _intersectWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth);
  PersistentMap<K, V> _delete(K key, int hash, int depth);
  PersistentMap<K, V> _adjust(K key, V update(V), int hash, int depth);

  _APersistentMap<K, V>
      _unionWith(_APersistentMap<K, V> m, V combine(V x, V y), int depth);
  _APersistentMap<K, V>
      _unionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y), int depth);
  _APersistentMap<K, V>
      _unionWithLeaf(_Leaf<K, V> m, V combine(V x, V y), int depth);
  _APersistentMap<K, V>
      _unionWithSubMap(_SubMap<K, V> m, V combine(V x, V y), int depth);

  _APersistentMap<K, V>
      _intersectionWith(_APersistentMap<K, V> m, V combine(V x, V y),
                        int depth);
  _APersistentMap<K, V>
      _intersectionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y),
                                int depth);
  _APersistentMap<K, V>
      _intersectionWithLeaf(_Leaf<K, V> m, V combine(V x, V y), int depth);
  _APersistentMap<K, V>
      _intersectionWithSubMap(_SubMap<K, V> m, V combine(V x, V y), int depth);

  Pair<K, V> _elementAt(int index);

  LinkedList<Pair<K, V>> _onePair(K key, V value) =>
      new Cons<Pair<K, V>>(new Pair<K, V>(key, value), new Nil<Pair<K, V>>());

  Option<V> lookup(K key) =>
      _lookup(key, key.hashCode & 0x3fffffff, 0);

  PersistentMap<K, V> insert(K key, V value, [V combine(V x, V y)]) =>
      _insertWith(_onePair(key, value),
          1,
          (combine != null) ? combine : (V x, V y) => y,
          key.hashCode & 0x3fffffff, 0);

  PersistentMap<K, V> delete(K key) =>
      _delete(key, key.hashCode & 0x3fffffff, 0);

  PersistentMap<K, V> adjust(K key, V update(V)) =>
      _adjust(key, update, key.hashCode & 0x3fffffff, 0);

  PersistentMap<K, V> union(PersistentMap<K, V> other, [V combine(V x, V y)]) =>
    this._unionWith(other, (combine != null) ? combine : (V x, V y) => y, 0);

  PersistentMap<K, V>
      intersection(PersistentMap<K, V> other, [V combine(V left, V right)]) =>
    this._intersectionWith(other,
        (combine != null) ? combine : (V x, V y) => y, 0);

  Pair<K, V> elementAt(int index) {
    if (index < 0 || index >= length) throw new RangeError.value(index);
    return _elementAt(index);
  }

  // toString() => toDebugString();
}

class _EmptyMapIterator<K, V> implements Iterator<Pair<K, V>> {
  const _EmptyMapIterator();
  Pair<K, V> get current => null;
  bool moveNext() => false;
}

class _EmptyMap<K, V> extends _APersistentMap<K, V> {
  _EmptyMap() : super(0, true, false);

  Option<V> _lookup(K key, int hash, int depth) => new Option<V>.none();

  PersistentMap<K, V> _insertWith(
      LinkedList<Pair<K, V>> keyValues, int size, V combine(V x, V y), int hash,
      int depth) {
    assert(size == keyValues.length);
    return new _Leaf<K, V>(hash, keyValues, size);
  }

  PersistentMap<K, V> _intersectWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth) {
    assert(size == keyValues.length);
    return this;
  }

  PersistentMap<K, V> _delete(K key, int hash, int depth) => this;

  PersistentMap<K, V> _adjust(K key, V update(V), int hash, int depth) => this;

  PersistentMap<K, V>
      _unionWith(PersistentMap<K, V> m, V combine(V x, V y), int depth) => m;

  PersistentMap<K, V>
      _unionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y), int depth) {
    throw "should never be called";
  }

  PersistentMap<K, V>
      _unionWithLeaf(_Leaf<K, V> m, V combine(V x, V y), int depth) => m;

  PersistentMap<K, V>
      _unionWithSubMap(_SubMap<K, V> m, V combine(V x, V y), int depth) => m;

  PersistentMap<K, V>
      _intersectionWith(_APersistentMap<K, V> m, V combine(V x, V y),
                        int depth) => this;

  PersistentMap<K, V>
      _intersectionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y),
                                int depth) {
        throw "should never be called";
  }

  PersistentMap<K, V> _intersectionWithLeaf(
      _Leaf<K, V> m, V combine(V x, V y), int depth) => this;

  PersistentMap<K, V> _intersectionWithSubMap(
      _SubMap<K, V> m, V combine(V x, V y), int depth) => this;

  PersistentMap mapValues(f(V)) => this;

  void forEachKeyValue(f(K, V)) {}

  bool operator ==(PersistentMap<K, V> other) => other is _EmptyMap;

  Iterator<Pair<K, V>> get iterator => const _EmptyMapIterator();

  Pair<K, V> _elementAt(int index) {
    throw new RangeError.value(index);
  }

  Pair<K, V> get last {
    throw new StateError("Empty map has no entries");
  }

  toDebugString() => "_EmptyMap()";
}

class _Leaf<K, V> extends _APersistentMap<K, V> {
  int _hash;
  LinkedList<Pair<K, V>> _pairs;

  _Leaf(this._hash, pairs, int size) : super(size, false, true) {
    this._pairs = pairs;
    assert(size == pairs.length);
  }

  PersistentMap<K, V> _insertWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth) {
    assert(size == keyValues.length);
    // newsize is incremented as a side effect of insertPair
    int newsize = length;

    LinkedList<Pair<K, V>> insertPair(Pair<K, V> toInsert,
                                      LinkedList<Pair<K, V>> pairs) {
      LinkedListBuilder<Pair<K, V>> builder =
          new LinkedListBuilder<Pair<K, V>>();
      LinkedList<Pair<K, V>> it = pairs;
      while (it.isCons) {
        Cons<Pair<K, V>> cons = it.asCons;
        Pair<K, V> elem = cons.elem;
        if (elem.fst == toInsert.fst) {
          builder.add(new Pair<K, V>(
              toInsert.fst,
              combine(elem.snd, toInsert.snd)));
          return builder.build(cons.tail);
        }
        builder.add(elem);
        it = cons.tail;
      }
      builder.add(toInsert);
      newsize++;
      return builder.build();
    }

    LinkedList<Pair<K, V>> insertPairs(
        LinkedList<Pair<K, V>> toInsert, LinkedList<Pair<K, V>> pairs) {
      LinkedList<Pair<K, V>> res = pairs;
      LinkedList<Pair<K, V>> it = toInsert;
      while (it.isCons) {
        Cons<Pair<K, V>> cons = it.asCons;
        Pair<K, V> elem = cons.elem;
        res = insertPair(elem, res);
        it = cons.tail;
      }
      assert(newsize == res.length);
      return res;
    }

    if (depth > 5) {
      assert(_hash == hash);
      final LinkedList<Pair<K, V>> newPairs = insertPairs(keyValues, _pairs);
      return new _Leaf<K, V>(hash, newPairs, newsize);
    } else {
      if (hash == _hash) {
        final LinkedList<Pair<K, V>> newPairs = insertPairs(keyValues, _pairs);
        return new _Leaf<K, V>(hash, newPairs, newsize);
      } else {
        int branch = (_hash >> (depth * 5)) & 0x1f;
        List<_APersistentMap<K, V>> array = <_APersistentMap<K, V>>[this];
        return new _SubMap<K, V>(1 << branch, array, length)
            ._insertWith(keyValues, size, combine, hash, depth);
      }
    }
  }

  PersistentMap<K, V> _intersectWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth) {
    assert(size == keyValues.length);
    // TODO(polux): possibly faster implementation
    Map<K, V> map = toMap();
    LinkedListBuilder<Pair<K, V>> builder = new LinkedListBuilder<Pair<K, V>>();
    int newsize = 0;
    keyValues.foreach((Pair<K, V> pair) {
      if (map.containsKey(pair.fst)) {
        builder.add(new Pair<K, V>(pair.fst, combine(map[pair.fst], pair.snd)));
        newsize++;
      }
    });
    return new _Leaf(_hash, builder.build(), newsize);
  }

  PersistentMap<K, V> _delete(K key, int hash, int depth) {
    if (hash != _hash)
      return this;
    bool found = false;
    LinkedList<Pair<K, V>> newPairs = _pairs.strictWhere((p) {
      if (p.fst == key) {
        found = true;
        return false;
      }
      return true;
    });
    return newPairs.isNil
        ? new _EmptyMap<K, V>()
        : new _Leaf<K, V>(_hash, newPairs, found ? length - 1 : length);
  }

  PersistentMap<K, V> _adjust(K key, V update(V), int hash, int depth) {
    LinkedList<Pair<K, V>> adjustPairs() {
      LinkedListBuilder<Pair<K, V>> builder =
          new LinkedListBuilder<Pair<K, V>>();
      LinkedList<Pair<K, V>> it = _pairs;
      while (it.isCons) {
        Cons<Pair<K, V>> cons = it.asCons;
        Pair<K, V> elem = cons.elem;
        if (elem.fst == key) {
          builder.add(new Pair<K, V>(key, update(elem.snd)));
          return builder.build(cons.tail);
        }
        builder.add(elem);
        it = cons.tail;
      }
      return builder.build();
    }

    return (hash != _hash)
        ? this
        : new _Leaf<K, V>(_hash, adjustPairs(), length);
  }

  PersistentMap<K, V>
      _unionWith(_APersistentMap<K, V> m, V combine(V x, V y), int depth) =>
          m._unionWithLeaf(this, combine, depth);

  PersistentMap<K, V>
      _unionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y), int depth) =>
          this;

  PersistentMap<K, V>
      _unionWithLeaf(_Leaf<K, V> m, V combine(V x, V y), int depth) =>
          m._insertWith(_pairs, length, combine, _hash, depth);

  PersistentMap<K, V>
      _unionWithSubMap(_SubMap<K, V> m, V combine(V x, V y), int depth) =>
          m._insertWith(_pairs, length, combine, _hash, depth);

  PersistentMap<K, V> _intersectionWith(_APersistentMap<K, V> m,
                                        V combine(V x, V y), int depth) =>
      m._intersectionWithLeaf(this, combine, depth);

  PersistentMap<K, V> _intersectionWithEmptyMap(_EmptyMap<K, V> m,
                                                V combine(V x, V y),
                                                int depth) =>
      m;

  PersistentMap<K, V> _intersectionWithLeaf(_Leaf<K, V> m, V combine(V x, V y),
                                            int depth) =>
      m._intersectWith(_pairs, length, combine, _hash, depth);

  PersistentMap<K, V> _intersectionWithSubMap(_SubMap<K, V> m,
                                              V combine(V x, V y), int depth) =>
      m._intersectWith(_pairs, length, combine, _hash, depth);

  Option<V> _lookup(K key, int hash, int depth) {
    if (hash != _hash)
      return new Option<V>.none();
    LinkedList<Pair<K, V>> it = _pairs;
    while (it.isCons) {
      Cons<Pair<K, V>> cons = it.asCons;
      Pair<K, V> elem = cons.elem;
      if (elem.fst == key) return new Option<V>.some(elem.snd);
      it = cons.tail;
    }
    return new Option<V>.none();
  }

  PersistentMap mapValues(f(V)) =>
      new _Leaf(_hash,
                _pairs.strictMap((p) => new Pair(p.fst, f(p.snd))), length);

  void forEachKeyValue(f(K, V)) {
    _pairs.foreach((Pair<K, V> pair) => f(pair.fst, pair.snd));
  }

  bool operator ==(PersistentMap<K, V> other) {
    if (identical(this, other)) return true;
    if (other is! _Leaf) return false;
    _Leaf otherLeaf = other;
    if (_hash != otherLeaf._hash) return false;
    if (length != otherLeaf.length) return false;
    Map<K, V> thisAsMap = toMap();
    int counter = 0;
    LinkedList<Pair<K, V>> it = otherLeaf._pairs;
    while (it.isCons) {
      Cons<Pair<K, V>> cons = it.asCons;
      Pair<K, V> elem = cons.elem;
      if (elem.snd == null && !thisAsMap.containsKey(elem.fst))
        return false;
      if (thisAsMap[elem.fst] != elem.snd)
        return false;
      counter++;
      it = cons.tail;
    }
    return thisAsMap.length == counter;
  }

  Iterator<Pair<K, V>> get iterator => _pairs.iterator;

  Pair<K, V> _elementAt(int index) {
    var tail = _pairs;
    for (int i = 0; i < index; i++) {
      tail = tail.asCons.tail;
    }
    return tail.asCons.elem;
  }

  Pair<K, V> get last {
    Cons pairs = _pairs.asCons;
    while (!pairs.tail.isNil) {
      pairs = pairs.tail;
    }
    return pairs.elem;
  }

  toDebugString() => "_Leaf($_hash, $_pairs)";
}

class _SubMapIterator<K, V> implements Iterator<Pair<K, V>> {
  List<_APersistentMap<K, V>> _array;
  int _index = 0;
  // invariant: _currentIterator != null => _currentIterator.current != null
  Iterator<Pair<K, V>> _currentIterator = null;

  _SubMapIterator(this._array);

  Pair<K, V> get current =>
      (_currentIterator != null) ? _currentIterator.current : null;

  bool moveNext() {
    while (_index < _array.length) {
      if (_currentIterator == null) {
        _currentIterator = _array[_index].iterator;
      }
      if (_currentIterator.moveNext()) {
        return true;
      } else {
        _currentIterator = null;
        _index++;
      }
    }
    return false;
  }
}

class _SubMap<K, V> extends _APersistentMap<K, V> {
  int _bitmap;
  List<_APersistentMap<K, V>> _array;

  _SubMap(this._bitmap, this._array, int size) : super(size, false, false);

  static _popcount(int n) {
    n = n - ((n >> 1) & 0x55555555);
    n = (n & 0x33333333) + ((n >> 2) & 0x33333333);
    n = (n + (n >> 4)) & 0x0F0F0F0F;
    n = n + (n >> 8);
    n = n + (n >> 16);
    return n & 0x0000003F;
  }

  Option<V> _lookup(K key, int hash, int depth) {
    int branch = (hash >> (depth * 5)) & 0x1f;
    int mask = 1 << branch;
    if ((_bitmap & mask) != 0) {
      int index = _popcount(_bitmap & (mask - 1));
      _APersistentMap<K, V> map = _array[index];
      return map._lookup(key, hash, depth + 1);
    } else {
      return new Option<V>.none();
    }
  }

  PersistentMap<K, V> _insertWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth) {
    assert(size == keyValues.length);

    int branch = (hash >> (depth * 5)) & 0x1f;
    int mask = 1 << branch;
    int index = _popcount(_bitmap & (mask - 1));

    if ((_bitmap & mask) != 0) {
      List<_APersistentMap<K, V>> newarray =
          new List<_APersistentMap<K, V>>.from(_array, growable: false);
      _APersistentMap<K, V> m = _array[index];
      _APersistentMap<K, V> newM =
          m._insertWith(keyValues, size, combine, hash, depth + 1);
      newarray[index] = newM;
      int delta = newM.length - m.length;
      return new _SubMap<K, V>(_bitmap, newarray, length + delta);
    } else {
      int newlength = _array.length + 1;
      List<_APersistentMap<K, V>> newarray =
          new List<_APersistentMap<K, V>>(newlength);
      // TODO: find out if there's a "copy array" native function somewhere
      for (int i = 0; i < index; i++) { newarray[i] = _array[i]; }
      for (int i = index; i < newlength - 1; i++) { newarray[i+1] = _array[i]; }
      newarray[index] = new _Leaf<K, V>(hash, keyValues, size);
      return new _SubMap<K, V>(_bitmap | mask, newarray, length + size);
    }
  }

  PersistentMap<K, V> _intersectWith(LinkedList<Pair<K, V>> keyValues, int size,
      V combine(V x, V y), int hash, int depth) {
    assert(size == keyValues.length);

    int branch = (hash >> (depth * 5)) & 0x1f;
    int mask = 1 << branch;

    if ((_bitmap & mask) != 0) {
      int index = _popcount(_bitmap & (mask - 1));
      _APersistentMap<K, V> m = _array[index];
      return m._intersectWith(keyValues, size, combine, hash, depth + 1);
    } else {
      return new _EmptyMap();
    }
  }

  PersistentMap<K, V> _delete(K key, int hash, int depth) {
    int branch = (hash >> (depth * 5)) & 0x1f;
    int mask = 1 << branch;

    if ((_bitmap & mask) != 0) {
      int index = _popcount(_bitmap & (mask - 1));
      _APersistentMap<K, V> m = _array[index];
      _APersistentMap<K, V> newm = m._delete(key, hash, depth + 1);
      int delta = newm.length - m.length;
      if (identical(m, newm)) {
        return this;
      }
      if (newm.isEmpty) {
        if (_array.length > 2) {
          int newsize = _array.length - 1;
          List<_APersistentMap<K, V>> newarray =
              new List<_APersistentMap<K, V>>(newsize);
          for (int i = 0; i < index; i++) { newarray[i] = _array[i]; }
          for (int i = index; i < newsize; i++) { newarray[i] = _array[i + 1]; }
          assert(newarray.length >= 2);
          return new _SubMap(_bitmap ^ mask, newarray, length + delta);
        } else {
          assert(_array.length == 2);
          assert(index == 0 || index == 1);
          _APersistentMap<K, V> onlyValueLeft = _array[1 - index];
          return onlyValueLeft._isLeaf
              ? onlyValueLeft
              : new _SubMap(_bitmap ^ mask,
                            <_APersistentMap<K, V>>[onlyValueLeft],
                            length + delta);
        }
      } else if (newm._isLeaf){
        if (_array.length == 1) {
          return newm;
        } else {
          List<_APersistentMap<K, V>> newarray =
              new List<_APersistentMap<K, V>>.from(_array, growable: false);
          newarray[index] = newm;
          return new _SubMap(_bitmap, newarray, length + delta);
        }
      } else {
        List<_APersistentMap<K, V>> newarray =
            new List<_APersistentMap<K, V>>.from(_array, growable: false);
        newarray[index] = newm;
        return new _SubMap(_bitmap, newarray, length + delta);
      }
    } else {
      return this;
    }
  }

  PersistentMap<K, V> _adjust(K key, V update(V), int hash, int depth) {
    int branch = (hash >> (depth * 5)) & 0x1f;
    int mask = 1 << branch;
    if ((_bitmap & mask) != 0) {
      int index = _popcount(_bitmap & (mask - 1));
      _APersistentMap<K, V> m = _array[index];
      _APersistentMap<K, V> newm = m._adjust(key, update, hash, depth + 1);
      if (identical(newm, m)) {
        return this;
      }
      List<_APersistentMap<K, V>> newarray =
          new List<_APersistentMap<K, V>>.from(_array, growable: false);
      newarray[index] = newm;
      return new _SubMap(_bitmap, newarray, length);
    } else {
      return this;
    }
  }

  PersistentMap<K, V>
      _unionWith(_APersistentMap<K, V> m, V combine(V x, V y), int depth) =>
          m._unionWithSubMap(this, combine, depth);

  PersistentMap<K, V>
      _unionWithEmptyMap(_EmptyMap<K, V> m, V combine(V x, V y), int depth) =>
          this;

  PersistentMap<K, V>
      _unionWithLeaf(_Leaf<K, V> m, V combine(V x, V y), int depth) =>
          this._insertWith(m._pairs, m.length, (V v1, V v2) => combine(v2, v1),
              m._hash, depth);

  PersistentMap<K, V>
      _unionWithSubMap(_SubMap<K, V> m, V combine(V x, V y), int depth) {
    int ormap = _bitmap | m._bitmap;
    int andmap = _bitmap & m._bitmap;
    List<_APersistentMap<K, V>> newarray =
        new List<_APersistentMap<K, V>>(_popcount(ormap));
    int mask = 1, i = 0, i1 = 0, i2 = 0;
    int newSize = 0;
    while (mask <= ormap) {
      if ((andmap & mask) != 0) {
        _array[i1];
        m._array[i2];
        _APersistentMap<K, V> newMap =
            m._array[i2]._unionWith(_array[i1], combine, depth + 1);
        newarray[i] = newMap;
        newSize += newMap.length;
        i1++;
        i2++;
        i++;
      } else if ((_bitmap & mask) != 0) {
        _APersistentMap<K, V> newMap = _array[i1];
        newarray[i] = newMap;
        newSize += newMap.length;
        i1++;
        i++;
      } else if ((m._bitmap & mask) != 0) {
        _APersistentMap<K, V> newMap = m._array[i2];
        newarray[i] = newMap;
        newSize += newMap.length;
        i2++;
        i++;
      }
      mask <<= 1;
    }
    return new _SubMap<K, V>(ormap, newarray, newSize);
  }

  PersistentMap<K, V> _intersectionWith(_APersistentMap<K, V> m,
                                        V combine(V x, V y), int depth) =>
      m._intersectionWithSubMap(this, combine, depth);

  PersistentMap<K, V> _intersectionWithEmptyMap(_EmptyMap<K, V> m,
                                                V combine(V x, V y),
                                                int depth) =>
      m;

  PersistentMap<K, V> _intersectionWithLeaf(_Leaf<K, V> m, V combine(V x, V y),
                                            int depth) =>
      _intersectWith(m._pairs,  m.length, (V v1, V v2) => combine(v2, v1),
                     m._hash, depth);

  PersistentMap<K, V> _intersectionWithSubMap(
      _SubMap<K, V> m, V combine(V x, V y), int depth) {
    int andmap = _bitmap & m._bitmap;
    List<_APersistentMap<K, V>> newarray = new List<_APersistentMap<K, V>>();
    int mask = 1, i1 = 0, i2 = 0;
    int newSize = 0;
    int newMask = 0;
    while (mask <= _bitmap) {
      if ((andmap & mask) != 0) {
        _array[i1];
        m._array[i2];
        _APersistentMap<K, V> newMap =
            m._array[i2]._intersectionWith(_array[i1], combine, depth + 1);
        newarray.add(newMap);
        newSize += newMap.length;
        newMask |= mask;
        i1++;
        i2++;
      } else if ((_bitmap & mask) != 0) {
        i1++;
      } else if ((m._bitmap & mask) != 0) {
        i2++;
      }
      mask <<= 1;
    }
    if (newarray.length > 1) {
      return new _SubMap<K, V>(newMask, newarray, newSize);
    } else if (newarray.length == 1) {
      _APersistentMap<K, V> onlyValueLeft = newarray[0];
      return onlyValueLeft._isLeaf
          ? onlyValueLeft
          : new _SubMap<K, V>(newMask, newarray, newSize);
    } else {
      return new _EmptyMap();
    }
  }

  PersistentMap mapValues(f(V)) {
    List<_APersistentMap<K, V>> newarray =
        new List<_APersistentMap<K, V>>.from(_array, growable: false);
    for (int i = 0; i < _array.length; i++) {
      _APersistentMap<K, V> mi = _array[i];
        newarray[i] = mi.mapValues(f);
    }
    return new _SubMap(_bitmap, newarray, length);
  }

  forEachKeyValue(f(K, V)) {
    _array.forEach((mi) => mi.forEachKeyValue(f));
  }

  bool operator ==(PersistentMap<K, V> other) {
    if (identical(this, other)) return true;
    if (other is! _SubMap) return false;
    _SubMap otherSubMap = other;
    if (_bitmap != otherSubMap._bitmap) return false;
    if (length != otherSubMap.length) return false;
    assert(_array.length == otherSubMap._array.length);
    for (int i = 0; i < _array.length; i++) {
      _APersistentMap<K, V> mi = _array[i];
      _APersistentMap<K, V> omi = otherSubMap._array[i];
      if (mi != omi) {
        return false;
      }
    }
    return true;
  }

  Iterator<Pair<K, V>> get iterator => new _SubMapIterator(_array);

  Pair<K, V> get last => _array.last.last;

  Pair<K, V> _elementAt(int index) {
    int newIndex = index;
    for (final subMap in _array) {
      int subLength = subMap.length;
      if (newIndex < subLength) {
        return subMap._elementAt(newIndex);
      }
      newIndex -= subLength;
    }
  }

  toDebugString() => "_SubMap($_array)";
}
