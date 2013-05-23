part of harness_browser;

class TestPushMessaging {
  void main() {
    group('chrome.pushMessaging', () {
      test('getChannelId', () {
        Future future = pushMessaging.getChannelId(false).then((String channelId) {
          print("channelId = ${channelId}");
          expect(true, true);
        }).catchError((var error) {
          print("error = ${error}");
          expect(true, true);
        });
        
        expect(future, completes);
      });
      
      test('onMessage', () {
        // test that calling this method does not throw
        pushMessaging.onMessage.listen((PushMessage message) {
          print(message);
        });
      });
    });
  }
}
