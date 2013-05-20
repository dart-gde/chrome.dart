library chrome;

import 'src/app.dart';
export 'src/app.dart';

import 'src/file_system.dart';
export 'src/file_system.dart';

import 'src/i18n.dart';
export 'src/i18n.dart';

import 'src/runtime.dart';
export 'src/runtime.dart';

import 'src/serial.dart';
export 'src/serial.dart';

import 'src/storage.dart';
export 'src/storage.dart';

final ChromeApp app = new ChromeApp();
final ChromeFileSystem fileSystem  = new ChromeFileSystem();
final ChromeI18n i18n = new ChromeI18n();
//final ChromeRuntime runtime = new ChromeRuntime();
final ChromeStorage storage = new ChromeStorage();

// part 'src/storage.dart';
