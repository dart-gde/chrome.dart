part of parsers;

class ParserAccumulator2 {
  final Parser p1, p2;
  ParserAccumulator2(this.p1, this.p2);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator3 operator +(Parser p) =>
    new ParserAccumulator3(p1, p2, p);

  /// Action application
  Parser operator ^(Object f(x1, x2)) =>
      success((x1) => (x2) => f(x1, x2)) * p1 * p2;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => [x1, x2]) * p1 * p2;
}

class ParserAccumulator3 {
  final Parser p1, p2, p3;
  ParserAccumulator3(this.p1, this.p2, this.p3);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator4 operator +(Parser p) =>
    new ParserAccumulator4(p1, p2, p3, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3)) =>
      success((x1) => (x2) => (x3) => f(x1, x2, x3)) * p1 * p2 * p3;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => [x1, x2, x3]) * p1 * p2 * p3;
}

class ParserAccumulator4 {
  final Parser p1, p2, p3, p4;
  ParserAccumulator4(this.p1, this.p2, this.p3, this.p4);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator5 operator +(Parser p) =>
    new ParserAccumulator5(p1, p2, p3, p4, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4)) =>
      success((x1) => (x2) => (x3) => (x4) => f(x1, x2, x3, x4)) * p1 * p2 * p3 * p4;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => [x1, x2, x3, x4]) * p1 * p2 * p3 * p4;
}

class ParserAccumulator5 {
  final Parser p1, p2, p3, p4, p5;
  ParserAccumulator5(this.p1, this.p2, this.p3, this.p4, this.p5);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator6 operator +(Parser p) =>
    new ParserAccumulator6(p1, p2, p3, p4, p5, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => f(x1, x2, x3, x4, x5)) * p1 * p2 * p3 * p4 * p5;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => [x1, x2, x3, x4, x5]) * p1 * p2 * p3 * p4 * p5;
}

class ParserAccumulator6 {
  final Parser p1, p2, p3, p4, p5, p6;
  ParserAccumulator6(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator7 operator +(Parser p) =>
    new ParserAccumulator7(p1, p2, p3, p4, p5, p6, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => f(x1, x2, x3, x4, x5, x6)) * p1 * p2 * p3 * p4 * p5 * p6;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => [x1, x2, x3, x4, x5, x6]) * p1 * p2 * p3 * p4 * p5 * p6;
}

class ParserAccumulator7 {
  final Parser p1, p2, p3, p4, p5, p6, p7;
  ParserAccumulator7(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator8 operator +(Parser p) =>
    new ParserAccumulator8(p1, p2, p3, p4, p5, p6, p7, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => f(x1, x2, x3, x4, x5, x6, x7)) * p1 * p2 * p3 * p4 * p5 * p6 * p7;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => [x1, x2, x3, x4, x5, x6, x7]) * p1 * p2 * p3 * p4 * p5 * p6 * p7;
}

class ParserAccumulator8 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8;
  ParserAccumulator8(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator9 operator +(Parser p) =>
    new ParserAccumulator9(p1, p2, p3, p4, p5, p6, p7, p8, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => f(x1, x2, x3, x4, x5, x6, x7, x8)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => [x1, x2, x3, x4, x5, x6, x7, x8]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8;
}

class ParserAccumulator9 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9;
  ParserAccumulator9(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator10 operator +(Parser p) =>
    new ParserAccumulator10(p1, p2, p3, p4, p5, p6, p7, p8, p9, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => [x1, x2, x3, x4, x5, x6, x7, x8, x9]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9;
}

class ParserAccumulator10 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
  ParserAccumulator10(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator11 operator +(Parser p) =>
    new ParserAccumulator11(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10;
}

class ParserAccumulator11 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11;
  ParserAccumulator11(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator12 operator +(Parser p) =>
    new ParserAccumulator12(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11;
}

class ParserAccumulator12 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12;
  ParserAccumulator12(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator13 operator +(Parser p) =>
    new ParserAccumulator13(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12;
}

class ParserAccumulator13 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13;
  ParserAccumulator13(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator14 operator +(Parser p) =>
    new ParserAccumulator14(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13;
}

class ParserAccumulator14 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14;
  ParserAccumulator14(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator15 operator +(Parser p) =>
    new ParserAccumulator15(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14;
}

class ParserAccumulator15 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;
  ParserAccumulator15(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator16 operator +(Parser p) =>
    new ParserAccumulator16(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15;
}

class ParserAccumulator16 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16;
  ParserAccumulator16(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15, this.p16);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator17 operator +(Parser p) =>
    new ParserAccumulator17(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16;
}

class ParserAccumulator17 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17;
  ParserAccumulator17(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15, this.p16, this.p17);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator18 operator +(Parser p) =>
    new ParserAccumulator18(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17;
}

class ParserAccumulator18 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18;
  ParserAccumulator18(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15, this.p16, this.p17, this.p18);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator19 operator +(Parser p) =>
    new ParserAccumulator19(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18;
}

class ParserAccumulator19 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19;
  ParserAccumulator19(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15, this.p16, this.p17, this.p18, this.p19);

  /// Parser sequencing: creates a parser accumulator
  ParserAccumulator20 operator +(Parser p) =>
    new ParserAccumulator20(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => (x19) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18 * p19;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => (x19) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18 * p19;
}

class ParserAccumulator20 {
  final Parser p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20;
  ParserAccumulator20(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7, this.p8, this.p9, this.p10, this.p11, this.p12, this.p13, this.p14, this.p15, this.p16, this.p17, this.p18, this.p19, this.p20);

  /// Action application
  Parser operator ^(Object f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20)) =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => (x19) => (x20) => f(x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20)) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18 * p19 * p20;

  /// Creates a [:Parser<List>:] from [this].
  Parser<List> get list =>
      success((x1) => (x2) => (x3) => (x4) => (x5) => (x6) => (x7) => (x8) => (x9) => (x10) => (x11) => (x12) => (x13) => (x14) => (x15) => (x16) => (x17) => (x18) => (x19) => (x20) => [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20]) * p1 * p2 * p3 * p4 * p5 * p6 * p7 * p8 * p9 * p10 * p11 * p12 * p13 * p14 * p15 * p16 * p17 * p18 * p19 * p20;
}

