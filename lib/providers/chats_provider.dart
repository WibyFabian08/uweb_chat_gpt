import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:uweb_gpt/models/chat_model.dart";

class ChatNotifier extends StateNotifier<List<ChatModel>> {
  // state nya
  ChatNotifier() : super([]);

  // function
  void add(ChatModel chat) {
    state = [...state, chat];
    // state = state..add(chat);
  }

  void removeTyping(String id) {
    state = state..removeWhere((element) => element.id == id);
  }

}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatModel>>(
    (ref) => ChatNotifier());
