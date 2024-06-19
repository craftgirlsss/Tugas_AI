import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uas_ai/main.dart';

class GenerateController extends GetxController {
  var isLoading = false.obs;
  var returnMessage = ''.obs;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
  );

  Future<String> postPromptGemini(List<Content> content) async {
    isLoading(true);
    await model.generateContent(content).then(
      (value) {
        isLoading(false);
        returnMessage.value = value.text!;
      }
    );
    return returnMessage.value;
  }
}