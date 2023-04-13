import 'package:flutter/material.dart';

@immutable
class ChatModel {
  final bool isMe;
  final String textMessage;
  final String id;

  const ChatModel({
    required this.isMe,
    required this.textMessage,
    required this.id,
  });
}
