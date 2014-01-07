/* This file has been generated from tts.json - do not edit */

/**
 * Use the `chrome.tts` API to play synthesized text-to-speech (TTS). See also
 * the related
 * [ttsEngine](http://developer.chrome.com/extensions/ttsEngine.html) API, which
 * allows an extension to implement a speech engine.
 */
library chrome.tts;

import '../src/common.dart';

/**
 * Accessor for the `chrome.tts` namespace.
 */
final ChromeTts tts = new ChromeTts._();

class ChromeTts extends ChromeApi {
  static final JsObject _tts = chrome['tts'];

  ChromeTts._();

  bool get available => _tts != null;

  /**
   * Speaks text using a text-to-speech engine.
   * 
   * [utterance] The text to speak, either plain text or a complete, well-formed
   * SSML document. Speech engines that do not support SSML will strip away the
   * tags and speak the text. The maximum length of the text is 32,768
   * characters.
   * 
   * [options] The speech options.
   */
  Future speak(String utterance, [TtsSpeakParams options]) {
    if (_tts == null) _throwNotAvailable();

    var completer = new ChromeCompleter.noArgs();
    _tts.callMethod('speak', [utterance, jsify(options), completer.callback]);
    return completer.future;
  }

  /**
   * Stops any current speech and flushes the queue of any pending utterances.
   * In addition, if speech was paused, it will now be un-paused for the next
   * call to speak.
   */
  void stop() {
    if (_tts == null) _throwNotAvailable();

    _tts.callMethod('stop');
  }

  /**
   * Pauses speech synthesis, potentially in the middle of an utterance. A call
   * to resume or stop will un-pause speech.
   */
  void pause() {
    if (_tts == null) _throwNotAvailable();

    _tts.callMethod('pause');
  }

  /**
   * If speech was paused, resumes speaking where it left off.
   */
  void resume() {
    if (_tts == null) _throwNotAvailable();

    _tts.callMethod('resume');
  }

  /**
   * Checks whether the engine is currently speaking. On Mac OS X, the result is
   * true whenever the system speech engine is speaking, even if the speech
   * wasn't initiated by Chrome.
   * 
   * Returns:
   * True if speaking, false otherwise.
   */
  Future<bool> isSpeaking() {
    if (_tts == null) _throwNotAvailable();

    var completer = new ChromeCompleter<bool>.oneArg();
    _tts.callMethod('isSpeaking', [completer.callback]);
    return completer.future;
  }

  /**
   * Gets an array of all available voices.
   * 
   * Returns:
   * Array of [TtsVoice] objects representing the available voices for speech
   * synthesis.
   */
  Future<List<TtsVoice>> getVoices() {
    if (_tts == null) _throwNotAvailable();

    var completer = new ChromeCompleter<List<TtsVoice>>.oneArg((e) => listify(e, _createTtsVoice));
    _tts.callMethod('getVoices', [completer.callback]);
    return completer.future;
  }

  /**
   * Used to pass events back to the function calling speak().
   */
  Stream<TtsEvent> get onEvent => _onEvent.stream;

  final ChromeStreamController<TtsEvent> _onEvent =
      new ChromeStreamController<TtsEvent>.oneArg(_tts, 'onEvent', _createTtsEvent);

  void _throwNotAvailable() {
    throw new UnsupportedError("'chrome.tts' is not available");
  }
}

/**
 * An event from the TTS engine to communicate the status of an utterance.
 */
class TtsEvent extends ChromeObject {
  TtsEvent({String type, var charIndex, String errorMessage}) {
    if (type != null) this.type = type;
    if (charIndex != null) this.charIndex = charIndex;
    if (errorMessage != null) this.errorMessage = errorMessage;
  }
  TtsEvent.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The type can be 'start' as soon as speech has started, 'word' when a word
   * boundary is reached, 'sentence' when a sentence boundary is reached,
   * 'marker' when an SSML mark element is reached, 'end' when the end of the
   * utterance is reached, 'interrupted' when the utterance is stopped or
   * interrupted before reaching the end, 'cancelled' when it's removed from the
   * queue before ever being synthesized, or 'error' when any other error
   * occurs. When pausing speech, a 'pause' event is fired if a particular
   * utterance is paused in the middle, and 'resume' if an utterance resumes
   * speech. Note that pause and resume events may not fire if speech is paused
   * in-between utterances.
   * enum of `start`, `end`, `word`, `sentence`, `marker`, `interrupted`,
   * `cancelled`, `error`, `pause`, `resume`
   */
  String get type => jsProxy['type'];
  set type(String value) => jsProxy['type'] = value;

  /**
   * The index of the current character in the utterance.
   */
  dynamic get charIndex => jsProxy['charIndex'];
  set charIndex(var value) => jsProxy['charIndex'] = jsify(value);

  /**
   * The error description, if the event type is 'error'.
   */
  String get errorMessage => jsProxy['errorMessage'];
  set errorMessage(String value) => jsProxy['errorMessage'] = value;
}

/**
 * A description of a voice available for speech synthesis.
 */
class TtsVoice extends ChromeObject {
  TtsVoice({String voiceName, String lang, String gender, String extensionId, List<String> eventTypes}) {
    if (voiceName != null) this.voiceName = voiceName;
    if (lang != null) this.lang = lang;
    if (gender != null) this.gender = gender;
    if (extensionId != null) this.extensionId = extensionId;
    if (eventTypes != null) this.eventTypes = eventTypes;
  }
  TtsVoice.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * The name of the voice.
   */
  String get voiceName => jsProxy['voiceName'];
  set voiceName(String value) => jsProxy['voiceName'] = value;

  /**
   * The language that this voice supports, in the form _language_-_region_.
   * Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
   */
  String get lang => jsProxy['lang'];
  set lang(String value) => jsProxy['lang'] = value;

  /**
   * This voice's gender.
   * enum of `male`, `female`
   */
  String get gender => jsProxy['gender'];
  set gender(String value) => jsProxy['gender'] = value;

  /**
   * The ID of the extension providing this voice.
   */
  String get extensionId => jsProxy['extensionId'];
  set extensionId(String value) => jsProxy['extensionId'] = value;

  /**
   * All of the callback event types that this voice is capable of sending.
   */
  List<String> get eventTypes => listify(jsProxy['eventTypes']);
  set eventTypes(List<String> value) => jsProxy['eventTypes'] = jsify(value);
}

class TtsSpeakParams extends ChromeObject {
  TtsSpeakParams({bool enqueue, String voiceName, String extensionId, String lang, String gender, var rate, var pitch, var volume, List<String> requiredEventTypes, List<String> desiredEventTypes, var onEvent}) {
    if (enqueue != null) this.enqueue = enqueue;
    if (voiceName != null) this.voiceName = voiceName;
    if (extensionId != null) this.extensionId = extensionId;
    if (lang != null) this.lang = lang;
    if (gender != null) this.gender = gender;
    if (rate != null) this.rate = rate;
    if (pitch != null) this.pitch = pitch;
    if (volume != null) this.volume = volume;
    if (requiredEventTypes != null) this.requiredEventTypes = requiredEventTypes;
    if (desiredEventTypes != null) this.desiredEventTypes = desiredEventTypes;
    if (onEvent != null) this.onEvent = onEvent;
  }
  TtsSpeakParams.fromProxy(JsObject jsProxy): super.fromProxy(jsProxy);

  /**
   * If true, enqueues this utterance if TTS is already in progress. If false
   * (the default), interrupts any current speech and flushes the speech queue
   * before speaking this new utterance.
   */
  bool get enqueue => jsProxy['enqueue'];
  set enqueue(bool value) => jsProxy['enqueue'] = value;

  /**
   * The name of the voice to use for synthesis. If empty, uses any available
   * voice.
   */
  String get voiceName => jsProxy['voiceName'];
  set voiceName(String value) => jsProxy['voiceName'] = value;

  /**
   * The extension ID of the speech engine to use, if known.
   */
  String get extensionId => jsProxy['extensionId'];
  set extensionId(String value) => jsProxy['extensionId'] = value;

  /**
   * The language to be used for synthesis, in the form _language_-_region_.
   * Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
   */
  String get lang => jsProxy['lang'];
  set lang(String value) => jsProxy['lang'] = value;

  /**
   * Gender of voice for synthesized speech.
   * enum of `male`, `female`
   */
  String get gender => jsProxy['gender'];
  set gender(String value) => jsProxy['gender'] = value;

  /**
   * Speaking rate relative to the default rate for this voice. 1.0 is the
   * default rate, normally around 180 to 220 words per minute. 2.0 is twice as
   * fast, and 0.5 is half as fast. Values below 0.1 or above 10.0 are strictly
   * disallowed, but many voices will constrain the minimum and maximum rates
   * further-for example a particular voice may not actually speak faster than 3
   * times normal even if you specify a value larger than 3.0.
   */
  dynamic get rate => jsProxy['rate'];
  set rate(var value) => jsProxy['rate'] = jsify(value);

  /**
   * Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
   * highest. 1.0 corresponds to a voice's default pitch.
   */
  dynamic get pitch => jsProxy['pitch'];
  set pitch(var value) => jsProxy['pitch'] = jsify(value);

  /**
   * Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
   * highest, with a default of 1.0.
   */
  dynamic get volume => jsProxy['volume'];
  set volume(var value) => jsProxy['volume'] = jsify(value);

  /**
   * The TTS event types the voice must support.
   */
  List<String> get requiredEventTypes => listify(jsProxy['requiredEventTypes']);
  set requiredEventTypes(List<String> value) => jsProxy['requiredEventTypes'] = jsify(value);

  /**
   * The TTS event types that you are interested in listening to. If missing,
   * all event types may be sent.
   */
  List<String> get desiredEventTypes => listify(jsProxy['desiredEventTypes']);
  set desiredEventTypes(List<String> value) => jsProxy['desiredEventTypes'] = jsify(value);

  /**
   * This function is called with events that occur in the process of speaking
   * the utterance.
   */
  dynamic get onEvent => jsProxy['onEvent'];
  set onEvent(var value) => jsProxy['onEvent'] = jsify(value);
}

TtsVoice _createTtsVoice(JsObject jsProxy) => jsProxy == null ? null : new TtsVoice.fromProxy(jsProxy);
TtsEvent _createTtsEvent(JsObject jsProxy) => jsProxy == null ? null : new TtsEvent.fromProxy(jsProxy);
