
import 'dart:html';
import 'dart:async';

import 'package:chrome/app.dart' as chrome;
import 'package:js/js.dart' as js;

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
  return chrome.runtime.getPackageDirectoryEntry().then((js.Proxy proxy) {
    chrome.DirectoryEntry dir = new chrome.DirectoryEntry(proxy);

    log("package dir is ${dir.name}");

    dir.release();
  });
}

Future<FileEntry> chooseFile() {
  return chrome.fileSystem.chooseEntry().then((js.Proxy file) {
    chrome.FileEntry entry = new chrome.FileEntry(file);

    log("You choose ${entry.name}, ${entry.fullPath}!");

    return entry.readText();
  }).then((String contents) {
    log("got file contents. length = ${contents.length}");
  });
}

Future<FileEntry> saveFile() {
  return chrome.fileSystem.chooseEntry(type: 'saveFile').then((js.Proxy file) {
    chrome.FileEntry entry = new chrome.FileEntry(file);

    log("Save to ${entry.name}, ${entry.fullPath}...");

    return entry.writeText("foo bar baz");
  }).then((chrome.FileEntry entry) {
    log("file save successful.");
  });
}

Future<FileEntry> chooseDirectory() {
  return chrome.fileSystem.chooseEntryDirectory().then((js.Proxy dir) {
    chrome.DirectoryEntry entry = new chrome.DirectoryEntry(dir);

    log("You choose ${entry.name}, ${entry.fullPath}!");
  });
}

Future<FileEntry> openSyncFileSystem() {
  return chrome.syncFileSystem.requestFileSystem().then((js.Proxy proxy) {
    chrome.FileSystem fs = new chrome.FileSystem(proxy);

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
