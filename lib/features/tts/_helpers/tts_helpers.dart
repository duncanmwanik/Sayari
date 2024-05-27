import 'tts_service.dart';

Future<List> getAvailableVoices() async {
  try {
    List voices = await ttsService.flutterTts.getVoices;
    return voices;
  } catch (e) {
    return [];
  }
}

Future<Map> getDefaultVoice() async {
  try {
    Map voice = await ttsService.flutterTts.getDefaultVoice;
    return voice;
  } catch (e) {
    return {};
  }
}
