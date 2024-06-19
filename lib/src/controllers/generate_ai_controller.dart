import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uas_ai/main.dart';

class GenerateController extends GetxController {
  SpeechToText speechToText = SpeechToText();
  var speechEnabled = false.obs;
  var lastWords = ''.obs;
  var isLoading = false.obs;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
  );

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  postPromptGemini(List<Content> content) async {
    isLoading(true);
    final response = await model.generateContent(content).then((value) => isLoading(false));
    print(response);
  }

  void _initSpeech() async {
    speechEnabled.value = await speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
      lastWords.value = result.recognizedWords;
  }
}