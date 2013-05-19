import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
void main() {
  addTask('test_dart2js', createDart2JsTask(['test/harness_browser.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('example_serial', createDart2JsTask(['example/serial_example/web/chrome_app_serial_example.dart'],
      allowUnsafeEval: false,
      packageRoot: 'packages/'
  ));

  addTask('analyze_libs', createDartAnalyzerTask(['lib/chrome.dart']));
  addTask('analyze_examples', createDartAnalyzerTask(['example/serial_clock/web/clock.dart',
                                                      'example/serial_example/web/chrome_app_serial_example.dart',
                                                      'example/tcp_echo_server/web/tcp_echo_server_example.dart',
                                                      'example/udp_echo_client/web/udp_echo_client_example.dart'
                                                      ]));

  runHop();
}
