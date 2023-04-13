import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uweb_gpt/providers/chats_provider.dart';
import 'package:uweb_gpt/widgets/app_bar_widget.dart';
import 'package:uweb_gpt/widgets/chat_item_widget.dart';
import 'package:uweb_gpt/widgets/input_text_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(),
        body: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final chats = ref.watch(chatProvider).reversed.toList();

                  return ListView.builder(
                    itemCount: chats.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ChatItemWidget(
                        isMe: chats[index].isMe,
                        textMessage: chats[index].textMessage,
                      );
                    },
                  );
                },
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(20), child: InputTextWidget()),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
