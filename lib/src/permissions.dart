library chrome.permissions;

import "dart:async";

import "package:logging/logging.dart";
import "package:js/js.dart" as js;
import "package:js/js_wrapping.dart" as jsw;

class Permissions {
	List permissions;
	List origins;

	Permissions({this.permissions: null, this.origins: null});

	Permissions.fromJs(js.Proxy prox) {
		if(prox["permissions"] != null) {
			this.permissions = jsw.JsArrayToListAdapter.cast(prox["permissions"]);
		}

		if(prox["origins"] != null) {
			this.origins = jsw.JsArrayToListAdapter.cast(prox["origins"]);
		}
	}

	Map toMap() {
		Map ret = new Map();

		if(this.permissions != null) {
			ret["permissions"] = this.permissions;
		}

		if(this.origins != null) {
			ret["origins"] = this.origins;
		}

		return ret;
	}

	// Methods!
	static Logger logger = new Logger("chrome.permissions");

	// TODO: Events?

	/** Request Permission requests additional permissions
	  * From the Chrome runtime. These additional permissions
	  * must be declared in the extension's manifest.json
	  * under the "optional_permissions" tag.
	  */
	static Future<bool> request(Permissions perms) {
		Completer compl = new Completer<bool>();

		_jsRequest() {
			void requestCallback(var result) {
				compl.complete(result);
			}

			var chrome = js.context.chrome;
			chrome.permissions.request(js.map(perms.toMap()),
				new js.Callback.once(requestCallback));
		}

		js.scoped(_jsRequest);

		return compl.future;
	}


	/** Release releases the previously granted permissions.
	  */
	static Future<bool> release(Permissions perms) {
		Completer compl = new Completer<bool>();

		_jsRelease() {
			void releaseCallback(var result) {
				compl.complete(result);
			}

			var chrome = js.context.chrome;
			chrome.permissions.release(js.map(perms.toMap()),
				new js.Callback.once(releaseCallback));
		}

		js.scoped(_jsRelease);

		return compl.future;
	}

	/** getAll retreives all the permissions currently granted to
	  * your application or extension.
	  */
	static Future<Permissions> getAll() {
		Completer compl =  new Completer<Permissions>();

		_jsGetAll() {
			void getAllCallback(var result) {
				compl.complete(new Permissions.fromJs(result));
			}

			var chrome = js.context.chrome;
			chrome.permissions.getAll(
				new js.Callback.once(getAllCallback));
		}

		js.scoped(_jsGetAll);

		return compl.future;
	}

	/** contains Checks if you currently have the given permissions.
	  */

	static Future<bool> contains(Permissions perms) {
		Completer compl = new Completer<bool>();

		_jsContains() {
			void containsCallback(var result) {
				compl.complete(result == js._true);
			}

			var chrome = js.context.chrome;
			chrome.permissions.contains(
				js.map(perms.toMap()),
				new js.Callback.once(containsCallback));
		}

		js.scoped(_jsContains);

		return compl.future;
	}
}