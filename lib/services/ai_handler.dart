import "package:chat_gpt_sdk/chat_gpt_sdk.dart";

class AIHandler {
  final _openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: 20000));

  Future<String> getResponse(String message) async {
    try {
      final request = CompleteText(prompt: message, model: kTranslateModelV3);

      final response = await _openAI.onCompleteText(request: request);

      if (response != null) {
        return response.choices[0].text.trim();
      }

      return "Something went wrong on the server";
    } catch (error) {
      return "Bad Request";
    }
  }

  void dispose() {
    _openAI.close();
  }
}
