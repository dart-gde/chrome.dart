
import 'dart:html';
import 'dart:async';

import 'package:chrome/app.dart' as chrome;

void main() {
  Element buttonArea = query('#summary');

  ButtonElement b = new ButtonElement();
  b.text = 'Choose File...';
  b.onClick.listen((_) => runTests(chooseFile));
  buttonArea.children.add(b);

  b = new ButtonElement();
  b.text = 'Save File...';
  b.onClick.listen((_) => runTests(saveFile));
  buttonArea.children.add(b);

  b = new ButtonElement();
  b.text = 'Package dir tests';
  b.onClick.listen((_) => runTests(testPackageDir));
  buttonArea.children.add(b);

  b = new ButtonElement();
  b.text = 'Choose Directory...';
  b.onClick.listen((_) => runTests(chooseDirectory));
  buttonArea.children.add(b);

  b = new ButtonElement();
  b.text = 'Open syncFS';
  b.onClick.listen((_) => runTests(openSyncFileSystem));
  buttonArea.children.add(b);

  chrome.syncFileSystem.onServiceStatusChanged.listen((chrome.ServiceStatusEvent event) {
    log(event.toString());
  });

  chrome.syncFileSystem.onFileStatusChanged.listen((chrome.FileStatusEvent event) {
    log(event.toString());
  });
}

Future<DirectoryEntry> testPackageDir() {
  return chrome.runtime.getPackageDirectoryEntry().then((chrome.DirectoryEntry dir) {
    log("package dir is ${dir.name}");

    dir.release();
  });
}

Future<FileEntry> chooseFile() {
  return chrome.fileSystem.chooseEntry().then((chrome.FileEntry file) {
    log("You choose ${file.name}, ${file.fullPath}!");

    return file.readText();
  }).then((String contents) {
    log("got file contents. length = ${contents.length}");
  });
}

Future<FileEntry> saveFile() {
  return chrome.fileSystem.chooseEntry(type: 'saveFile').then((chrome.FileEntry file) {
    log("Save to ${file.name}, ${file.fullPath}...");

    return file.writeText("foo bar baz");
  }).then((chrome.FileEntry entry) {
    log("file save successful.");
  });
}

Future<FileEntry> chooseDirectory() {
  return chrome.fileSystem.chooseEntryDirectory().then((chrome.DirectoryEntry dir) {
    log("You choose ${dir.name}, ${dir.fullPath}!");
  });
}

Future<FileEntry> openSyncFileSystem() {
  return chrome.syncFileSystem.requestFileSystem().then((chrome.FileSystem fs) {
    log("You choose ${fs.name}");
    log("root dir = ${fs.root.name}");
  });
}

void runTests(Function test) {
  Element statusText = query('#notes');
  Element outputText = query('#output-text');

  statusText.text = "Running tests...";
  Future future = test();

  future.then((_) {
    statusText.text = "Tests finished.";
  }).catchError((var e) {
    statusText.text = "Tests errored.";
    log("oops: ${e}");
  });
}

void log(String text) {
  Element outputText = query('#output-text');

  outputText.text += "${text}\n";

  outputText.scrollByPages(1);
}
