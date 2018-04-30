/* This file has been generated from tts_engine.json - do not edit */

/**
 * Use the `chrome.ttsEngine` API to implement a text-to-speech(TTS) engine
 * using an extension. If your extension registers using this API, it will
 * receive events containing an utterance to be spoken and other parameters when
 * any extension or Chrome App uses the [tts](tts) API to generate speech. Your
 * extension can then use any available web technology to synthesize and output
 * the speech, and send events back to the calling function to report the
 * status.
 */
library chrome.ttsEngine;

import 'tts.dart';
import '../src/common.dart';

/**
 * Accessor for the `chrome.ttsEngine` namespace.
 */
final ChromeTtsEngine ttsEngine = new ChromeTtsEngine._();

class ChromeTtsEngine extends ChromeApi {
  JsObject get _ttsEngine => chrome['ttsEngine'];

  /**
   * Called when the user makes a call to tts.speak() and one of the voices from
   * this extension's manifest is the first to match the options object.
   */
  Stream<OnSpeakEvent> get onSpeak => _onSpeak.stream;
  ChromeStreamController<OnSpeakEvent> _onSpeak;

  /**
   * Fired when a call is made to tts.stop and this extension may be in the
   * middle of speaking. If an extension receives a call to onStop and speech is
   * already stopped, it should do nothing (not raise an error). If speech is in
   * the paused state, this should cancel the paused state.
   */
  Stream get onStop => _onStop.stream;
  ChromeStreamController _onStop;

  /**
   * Optional: if an engine supports the pause event, it should pause the
   * current utterance being spoken, if any, until it receives a resume event or
   * stop event. Note that a stop event should also clear the paused state.
   */
  Stream get onPause => _onPause.stream;
  ChromeStreamController _onPause;

  /**
   * Optional: if an engine supports the pause event, it should also support the
   * resume event, to continue speaking the current utterance, if any. Note that
   * a stop event should also clear the paused state.
   */
  Stream get onResume => _onResume.stream;
  ChromeStreamController _onResume;

  ChromeTtsEngine._() {
    var getApi = () => _ttsEngine;
    _onSpeak = new ChromeStreamController<OnSpeakEvent>.threeArgs(getApi, 'onSpeak', _createOnSpeakEvent);
    _onStop = new ChromeStreamController.noArgs(getApi, 'onStop');
    _onPause = new ChromeStreamController.noArgs(getApi, 'onPause');
    _onResume = new ChromeStreamController.noArgs(getApi, 'onResume');
  }

  bool get available => _ttsEngine != null;

  /**
   * Called by an engine to update its list of voices. This list overrides any
   * voices declared in this extension's manifest.
   * 
   * [voices] Array of [tts.TtsVoice] objects representing the available voices
   * for speech synthesis.
   */
  void updateVoices(List<TtsVoice> voices) {
    if (_ttsEngine == null) _throwNotAvailable();

    _ttsEngine.callMethod('updateVoices', [jsify(voices)]);
  }

  /**
   * Routes a TTS event from a speech engine to a client.
   * 
   * [event] The update event from the text-to-speech engine indicating the
   * status of this utterance.
   */
  void sendTtsEvent(int requestId, TtsEvent event) {
    if (_ttsEngine == null) _throwNotAvailable();

    _ttsEngine.callMethod('sendTtsEvent', [requestId, jsify(event)]);
  }

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.ttsEngine' is not available");
  }
}

/**
 * Called when the user makes a call to tts.speak() and one of the voices from
 * this extension's manifest is the first to match the options object.
 */
class OnSpeakEvent {
  /**
   * The text to speak, specified as either plain text or an SSML document. If
   * your engine does not support SSML, you should strip out all XML markup and
   * synthesize only the underlying text content. The value of this parameter is
   * guaranteed to be no more than 32,768 characters. If this engine does not
   * support speaking that many characters at a time, the utterance should be
   * split into smaller chunks and queued internally without returning an error.
   */
  final String utterance;

  /**
   * Options specified to the tts.speak() method.
   */
  final Map options;

  /**
   * Call this function with events that occur in the process of speaking the
   * utterance.
   */
  final dynamic sendTtsEvent;

  OnSpeakEvent(this.utterance, this.options, this.sendTtsEvent);
}

class VoiceGender extends ChromeEnum {
  static const VoiceGender MALE = const VoiceGender._('male');
  static const VoiceGender FEMALE = const VoiceGender._('female');

  static const List<VoiceGender> VALUES = const[MALE, FEMALE];

  const VoiceGender._(String str): super(str);
}

OnSpeakEvent _createOnSpeakEvent(String utterance, JsObject options, JsObject sendTtsEvent) =>
    new OnSpeakEvent(utterance, mapify(options), sendTtsEvent);
