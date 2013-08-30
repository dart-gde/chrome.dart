library chrome.media_galleries;

import 'dart:async';
import 'package:js/js.dart' as js;
import 'package:js/js_wrapping.dart' as js_wrapping;
import 'common.dart';

/**
 * Description:  Use the chrome.mediaGalleries API to access media files
 * (images, video, audio) from the user's local disks (with the user's consent).
 *
 * Availability:  Stable since Chrome 22.
 *
 * Permissions:   {"mediaGalleries": ["read"]}
 * {"mediaGalleries": ["read", "allAutoDetected"]}
 *
 * See Manifest below for more information.
 */
const ChromeMediaGalleries chromeMediaGalleries = const ChromeMediaGalleries._();

class ChromeMediaGalleriesInteractiveEnum {
  static const NO = const ChromeMediaGalleriesInteractiveEnum._("no");
  static const YES = const ChromeMediaGalleriesInteractiveEnum._("yes");
  static const IF_NEEDED = const ChromeMediaGalleriesInteractiveEnum._("if_needed");

  static get values => [NO, YES, IF_NEEDED];

  final String value;

  const ChromeMediaGalleriesInteractiveEnum._(this.value);
}

/**
 * name ( string ) The name of the file system.
 *
 * galleryId ( string ) A unique and persistent id for the media gallery.
 *
 * deviceId ( optional string ) If the media gallery is on a removable device,
 * a unique id for the device.
 *
 * isRemovable ( boolean ) True if the media gallery is on a removable device.
 *
 * isMediaDevice ( boolean ) True if the device the media gallery is on was
 * detected as a media device. i.e. a PTP or MTP device, or a DCIM directory
 * is present.
 */
class MediaFileSystemMetadata {
  String name;
  String galleryId;
  String deviceId;
  bool isRemovable;
  bool isMediaDevice;
  MediaFileSystemMetadata(this.name, this.galleryId, this.isRemovable, this.isMediaDevice, [this.deviceId]);
}

/**
 * Usage
 *
 * Using the API, you can prompt the user for permission to access the media
 * galleries. The permission dialog will contain common media locations for the
 * platform and will allow the user to add additional locations. From those
 * locations, only media files will be present in the file system objects.
 *
 * Manifest
 *
 * The media galleries API has two axes of permission parameters; the locations
 * that can be accessed, and the type of access (read-only, read-write, add-files).
 *
 * On the location axis, specifying no location-type permission parameters means
 * that no media galleries are accessible until the user grants permission to
 * specific media galleries at runtime using the media gallery configuration
 * dialog. This dialog can be programmatically triggered. Alternatively,
 * specifying the "allAutoDetected" permission parameter grants access to all
 * auto-detected media galleries on the user's computer. However, this
 * permission displays an install time prompt indicating that the app will have
 * access to all of the user's media files.
 *
 * On the access type axis, the "read" permission parameter grants the app the
 * right to read files. This permission does not trigger an install time
 * permission prompt because the user must still grant access to particular
 * galleries, either with the "allAutoDetected" permission parameter or at
 * runtime by using the media gallery management dialog. For example:
 *
 * {
 *  "name": "My app",
 *   ...
 *   "permissions": [
 *   { "mediaGalleries": ["read", "allAutoDetected"] }
 *   ],
 *   ...
 * }
 *
 * This permission will trigger an install time permission prompt and let the
 * app read from all auto-detected media galleries on the user's computer. The
 * user may add or remove galleries using the media gallery management dialog,
 * after which the app will be able to read all the media files from galleries
 * that the user has selected.
 *
 * Currently "read" is the only access type supported by this API. Read-write
 * and add-file access with be implemented soon.
 */
class ChromeMediaGalleries {
  const ChromeMediaGalleries._();

  /**
   * Get the media galleries configured in this user agent. If none are
   * configured or available, the callback will receive an empty array.
   *
   * [interactive] ( optional enum of "no", "yes", or "if_needed" )
   * Whether to prompt the user for permission to additional media galleries
   * before returning the permitted set. Default is silent. If the value 'yes'
   * is passed, or if the application has not been granted access to any media
   * galleries and the value 'if_needed' is passed, then the media gallery
   * configuration dialog will be displayed.
   *
   * The future parameter should specify a function that looks like this:
   * function(array of domfilesystem mediaFileSystems) {...};
   * mediaFileSystems ( optional array of domfilesystem )
   */
  Future<List> getMediaFileSystems({ChromeMediaGalleriesInteractiveEnum interactive: ChromeMediaGalleriesInteractiveEnum.NO}) {
    List transform(arg) {
      List l = new js_wrapping.JsArrayToListAdapter.fromProxy(arg).toList();
      l.forEach((e) => js.retain(e));
      return l;
    };

    ChromeCompleter completer = new ChromeCompleter.oneArg(transform);

    js.scoped(() {
      chromeProxy.mediaGalleries
      .getMediaFileSystems(js.map({'interactive': interactive.value}), completer.callback);
    });

    return completer.future;
  }

  /**
   * Get metadata about a specific media file system.
   *
   * Parameters
   * mediaFileSystem ( domfilesystem )
   *
   * return type MediaFileSystemMetadata
   */
  MediaFileSystemMetadata getMediaFileSystemMetadata(mediaFileSystem) {
    return js.scoped(() {
      var jsMetadataResult = chromeProxy.mediaGalleries
      .getMediaFileSystemMetadata(mediaFileSystem);
      MediaFileSystemMetadata mediaFileSystemMetadata =
          new MediaFileSystemMetadata(jsMetadataResult['name'],
          jsMetadataResult['galleryId'],
          jsMetadataResult['isRemovable'],
          jsMetadataResult['isMediaDevice'],
          jsMetadataResult['deviceId']);
      return mediaFileSystemMetadata;
    });
  }
}