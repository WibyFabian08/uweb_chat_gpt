import 'package:flutter/material.dart';
import 'package:uweb_gpt/models/chat_model.dart';
import 'package:uweb_gpt/providers/chats_provider.dart';
import 'package:uweb_gpt/services/ai_handler.dart';
import 'package:uweb_gpt/services/voice_handler.dart';
import 'package:uweb_gpt/widgets/toggle_button_widget.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

enum InputMode { voice, text }

class InputTextWidget extends ConsumerStatefulWidget {
  const InputTextWidget({super.key});

  @override
  ConsumerState<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends ConsumerState<InputTextWidget> {
  bool _isListening = false;
  bool _isReplying = false;
  InputMode _inputMode = InputMode.voice;
  final messageController = TextEditingController();

  final AIHandler _openAI = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();

  @override
  void initState() {
    voiceHandler.intiSpeech();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    _openAI.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: messageController,
            onChanged: (value) {
              value.isNotEmpty
                  ? setInputNode(InputMode.text)
                  : setInputNode(InputMode.voice);
            },
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary)),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ToggleButtonWidget(
          inputMode: _inputMode,
          isListening: _isListening,
          isReplying: _isReplying,
          sendTextMessage: () {
            final message = messageController.text;
            messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        )
      ],
    );
  }

  void setInputNode(InputMode mode) {
    setState(() {
      _inputMode = mode;
    });
  }

  void setIsReplying(bool reply) {
    setState(() {
      _isReplying = reply;
    });
  }

  void setIsListening(bool listen) {
    setState(() {
      _isListening = listen; 
    });
  }

  void addNewChat(String id, String message, bool isMe) {
    final chats = ref.read(chatProvider.notifier);

    chats.add(ChatModel(id: id, textMessage: message, isMe: isMe));
  }

  void removeTyping() {
    final chats = ref.read(chatProvider.notifier);

    chats.removeTyping("typing");
  }

  void sendTextMessage(String message) async {
    setIsReplying(true);
    addNewChat(DateTime.now().toString(), message, true);
    addNewChat("typing", "Typing...", false);
    setInputNode(InputMode.voice);

    final response = await _openAI.getResponse(message);
    removeTyping();
    addNewChat(DateTime.now().toString(), response, false);
    setIsReplying(false);
  }

  void sendVoiceMessage() async {
    if(!voiceHandler.isEnabled) {
      print("Not Supported");
      return;
    }

    if(voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setIsListening(false);
    } else {
      setIsListening(true);
      final result = await voiceHandler.startListening();
      setIsListening(false);
      sendTextMessage(result);
    }
  }
}
