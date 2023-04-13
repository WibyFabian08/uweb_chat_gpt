import 'package:flutter/material.dart';
import 'package:uweb_gpt/widgets/input_text_widget.dart';

class ToggleButtonWidget extends StatefulWidget {
  final InputMode _inputMode;
  final bool _isListening;
  final bool _isReplying;

  // menerima function dari parent
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;

  const ToggleButtonWidget(
      {super.key,
      required InputMode inputMode,
      required bool isListening,
      required bool isReplying,
      required VoidCallback sendTextMessage,
      required VoidCallback sendVoiceMessage})
      : _inputMode = inputMode,
        _isListening = isListening,
        _isReplying = isReplying,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage;

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15)),
      onPressed: widget._isReplying
          ? null
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage
              : widget._sendVoiceMessage,
      child: Icon(
          widget._inputMode == InputMode.text
              ? Icons.send
              : widget._isListening
                  ? Icons.mic_off
                  : Icons.mic,
          color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
