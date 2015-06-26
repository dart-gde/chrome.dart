library download_idls;

import 'dart:async';
import 'dart:io';

import 'src/googlesource.dart';
import 'src/omaha.dart';

main() => new IdlDownloader().downloadIdls();

class IdlDownloader {
  static final _chromiumBaseUrl = 'https://chromium.googlesource.com';
  static final _chromiumVersionPrefix = '/chromium/src/+/';
  static final _idlDirs =
      ['chrome/common/extensions/api', 'extensions/common/api'];

  OmahaVersionExtractor _omahaVersionExtractor;
  GoogleSourceCrawler _googleSourceCrawler;
  String _version;

  /// Finds the latest version of the Chrome IDL spec and downloads the files
  /// to the appropriate local directories.
  ///
  /// The process is as follows: using the current version of Chrome, as
  /// provided by the [OmahaVersionExtractor], we determine the path to the
  /// source. Then, we crawl the source, with a [GoogleSourceCrawler], starting
  /// in the directories we expect to find IDL and JSON files. Any files we
  /// find, we download.
  Future downloadIdls() async {
    _omahaVersionExtractor = new OmahaVersionExtractor();
    _version = await _omahaVersionExtractor.stableVersion;
    print('Downloading IDL and JSON for APIs at Chrome $_version');
    _googleSourceCrawler = new GoogleSourceCrawler(_chromiumBaseUrl);
    for (var dir in _idlDirs) {
      var relativePath = '$_chromiumVersionPrefix$_version/$dir';
      _googleSourceCrawler
          .findAllMatchingFiles(relativePath).listen(_downloadFile);
    }
  }

  Future _downloadFile(GoogleSourceFile file) async {
    var filePath = file.url.replaceFirst('/', '');
    var localFile = new File(_resolvePath(filePath));
    await localFile.create(recursive: true);
    await localFile.writeAsString(file.fileContents);
  }

  String _resolvePath(String rawPath) {
    var path = rawPath.replaceFirst(new RegExp('^.*[0-9]/'), '');
    var prefix = path.split('/')[0];
    return path.replaceFirst(new RegExp('.*/api'), 'idl/$prefix');
  }
}