
library model_json_test;

import 'dart:io';
import 'dart:convert';

import 'package:unittest/unittest.dart';

import '../tool/json_model.dart' as json_model;
import '../tool/json_parser.dart' as json_parser;

void main() {
  group('json_model', () {
    // Define a test for each .json file in idl/
    File testFile = new File('idl/runtime.json');

    // The unittest script likes to be run with the cwd set to the project root.
    if (testFile.existsSync()) {
      Iterable<File> jsonFiles = new Directory('idl')
          .listSync(recursive: true, followLinks: false)
          .where((f) => f.path.endsWith('.json'));

      for (File file in jsonFiles) {
        // skip _api_features.json, _manifest_features.json, _permission_features.json
        if (!file.path.contains('/_') && !file.path.contains('test_presubmit')) {
          test(file.path, () {
            json_model.JsonNamespace namespace = json_parser.parse(file.readAsStringSync());
            expect(namespace.namespace, isNotNull);
          });
        }
      }
    }
  });

  group("json model parameters", () {
    test("parse browser_action.json", () {
      File file = new File('idl/browser_action.json');
      json_model.JsonNamespace namespace =
          json_parser.parse(file.readAsStringSync());
      expect(namespace.namespace, isNotNull);
      expect(namespace.functions.any((e) => e.name == "setTitle"), isTrue);
      json_model.JsonFunction function =
          namespace.functions.singleWhere((e) => e.name == "setTitle");
      expect(function.parameters.length, 1);
      json_model.JsonParamType parameter = function.parameters[0];
      expect(parameter, isNotNull);
      expect(parameter.type, "object");
      expect(parameter.properties.length, 2);
      json_model.JsonProperty titleProperty =
          parameter.properties.singleWhere((e) => e.name == "title");
      expect(titleProperty, isNotNull);
      expect(titleProperty.type.type, equals("string"));
      json_model.JsonProperty tabIdProperty =
          parameter.properties.singleWhere((e) => e.name == "tabId");
      expect(tabIdProperty, isNotNull);
      expect(tabIdProperty.type.type, equals("integer"));
      expect(tabIdProperty.type.optional, true);
    });
  });

  group("individual parsing tests", () {
    test("parameters that have 'choices'", () {
      // TODO: move to file.
      String data = """[{
        "name": "setIcon",
        "type": "function",
        "description": "Sets the icon for the browser action. The icon can be specified either as the path to an image file or as the pixel data from a canvas element, or as dictionary of either one of those. Either the <b>path</b> or the <b>imageData</b> property must be specified.",
        "parameters": [
          {
            "name": "details",
            "type": "object",
            "properties": {
              "imageData": {
                "choices": [
                  { "\$ref": "ImageDataType" },
                  {
                    "type": "object",
                    "properties": {
                      "19": {"\$ref": "ImageDataType", "optional": true},
                      "38": {"\$ref": "ImageDataType", "optional": true}
                     }
                  }
                ],
                "optional": true,
                "description": "Either an ImageData object or a dictionary {size -> ImageData} representing icon to be set. If the icon is specified as a dictionary, the actual image to be used is chosen depending on screen's pixel density. If the number of image pixels that fit into one screen space unit equals <code>scale</code>, then image with size <code>scale</code> * 19 will be selected. Initially only scales 1 and 2 will be supported. At least one image must be specified. Note that 'details.imageData = foo' is equivalent to 'details.imageData = {'19': foo}'"
              },
              "path": {
                "choices": [
                  { "type": "string" },
                  {
                    "type": "object",
                    "properties": {
                      "19": {"type": "string", "optional": true},
                      "38": {"type": "string", "optional": true}
                    }
                  }
                ],
                "optional": true,
                "description": "Either a relative image path or a dictionary {size -> relative image path} pointing to icon to be set. If the icon is specified as a dictionary, the actual image to be used is chosen depending on screen's pixel density. If the number of image pixels that fit into one screen space unit equals <code>scale</code>, then image with size <code>scale</code> * 19 will be selected. Initially only scales 1 and 2 will be supported. At least one image must be specified. Note that 'details.path = foo' is equivalent to 'details.imageData = {'19': foo}'"
              },
              "tabId": {
                "type": "integer",
                "optional": true,
                "description": "Limits the change to when a particular tab is selected. Automatically resets when the tab is closed."
              }
            }
          },
          {
            "type": "function",
            "name": "callback",
            "optional": true,
            "parameters": []
          }
        ]
      }]""";

      List<json_model.JsonFunction> functions =
          json_model.JsonFunction.parse(JSON.decode(data));
      expect(functions, isNotNull);
      expect(functions, hasLength(1));
      json_model.JsonFunction function = functions[0];
      expect(function, isNotNull);
      expect(function.name, equals("setIcon"));
      expect(function.parameters, hasLength(2));
      json_model.JsonParamType objectType = function.parameters[0];
      expect(objectType, isNotNull);
      List<json_model.JsonProperty> properties = objectType.properties;
      expect(properties, isNotNull);
      expect(properties, hasLength(3));
      json_model.JsonProperty imageDataProperty = properties[0];
      expect(imageDataProperty.name, equals("imageData"));
      expect(imageDataProperty.isComplexProperty, isFalse);
      // TODO: unit test the choices once implemented
    });
  });
}
