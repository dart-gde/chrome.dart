
library invocation_maker;

import 'dart:mirrors';

abstract class InvocationMaker {

  final Symbol _member;

  InvocationMaker._(this._member);

  factory InvocationMaker.getter(Symbol fieldName) =
      _GetterInvocationMaker;
  factory InvocationMaker.setter(Symbol fieldName, value) =
      _SetterInvocationMaker;
  factory InvocationMaker.method(
      Symbol methodName,
      List positionalArguments,
      Map<Symbol, dynamic> namedArguments) = _MethodInvocationMaker;

  Invocation get invocation {
    var passThrough = new _InvocationPassThrough();
    var passThroughMirror = reflect(passThrough);

    var invocationMirror = _passThrough(passThroughMirror);

    return invocationMirror.reflectee;
  }

  _passThrough(passThroughMirror);
}

class _GetterInvocationMaker extends InvocationMaker {

  _GetterInvocationMaker(Symbol fieldName) : super._(fieldName);

  _passThrough(InstanceMirror passThroughMirror) =>
      passThroughMirror.getField(_member);
}

class _SetterInvocationMaker extends InvocationMaker {

  final _value;

  _SetterInvocationMaker(Symbol fieldName, this._value) : super._(fieldName);

  _passThrough(InstanceMirror passThroughMirror) {
    passThroughMirror.setField(_member, _value);
    return reflect(passThroughMirror.reflectee.lastInvocation);
  }
}

class _MethodInvocationMaker extends InvocationMaker {

  final List _positionalArguments;
  final Map<Symbol, dynamic> _namedArguments;

  _MethodInvocationMaker(
      Symbol fieldName,
      this._positionalArguments,
      this._namedArguments)
      : super._(fieldName);

  _passThrough(InstanceMirror passThroughMirror) =>
      passThroughMirror.invoke(_member, _positionalArguments, _namedArguments);
}

class _InvocationPassThrough {

  Invocation lastInvocation;

  noSuchMethod(Invocation invocation) => lastInvocation = invocation;
}
