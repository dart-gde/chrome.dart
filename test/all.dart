
library all_test;

import 'model_json_test.dart' as model_json_test;
import 'src_gen_test.dart' as src_gen_test;
import 'utils_test.dart' as utils_test;
import 'chrome_idl_test.dart' as test_chrome_idl;
import 'chrome_idl_files_test.dart' as test_chrome_idl_files;
import 'transformer_test.dart' as transformer_test;

void main() {
  model_json_test.main();
  src_gen_test.main();
  utils_test.main();
  test_chrome_idl.main();
  test_chrome_idl_files.main();
  transformer_test.defineTests();
}
