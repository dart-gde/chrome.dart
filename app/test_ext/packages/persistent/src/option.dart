// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

part of persistent;

class Option<T> {
  static final _none = new Option._internal(false, null);

  final T _value;
  final bool isDefined;

  Option._internal(this.isDefined, this._value);

  factory Option.none() => _none;

  factory Option.some(T value) => new Option._internal(true, value);

  factory Option.fromNullable(T nullableValue) =>
      nullableValue == null ? _none : new Option.some(nullableValue);

  T get value {
    if (isDefined) return _value;
    throw new StateError('Option.none() has no value');
  }

  T get asNullable => isDefined ? _value : null;

  T orElse(T defaultValue) => isDefined ? _value : defaultValue;

  T orElseCompute(T defaultValue()) => isDefined ? _value : defaultValue();

  /// [:forall U, Option<U> map(U f(T value)):]
  Option map(f(T value)) =>
      isDefined ? new Option.some(f(_value)) : this;

  /// [:forall U, Option<U> map(Option<U> f(T value)):]
  Option expand(Option f(T value)) =>
      isDefined ? f(_value) : this;

  /// Precondition: [:this is Option<Option>:]
  Option get flattened {
    assert(isDefined ? _value is Option : true);
    return orElse(_none);
  }

  bool operator ==(Option<T> other) =>
      (isDefined && other.isDefined && _value == other._value)
   || (!isDefined && !other.isDefined);

  int get hashCode => asNullable.hashCode;

  String toString() =>
      isDefined ? "Option.some($_value)" : "Option.none()";
}
