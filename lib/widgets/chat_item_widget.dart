import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItemWidget extends StatelessWidget {
  final bool isMe;
  final String textMessage;
  const ChatItemWidget(
      {super.key, required this.isMe, required this.textMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe) ProfileContainer(isMe: isMe),
          if(!isMe) const SizedBox(width: 10,),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70
            ),
            decoration: BoxDecoration(
              color: isMe ? Theme.of(context).colorScheme.primary : Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomRight: Radius.circular(isMe ? 0 : 15),
                bottomLeft: Radius.circular(isMe ? 15 : 0)
              )
            ),
            child: Text(textMessage, style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14
            ),),
          ),
          if(isMe) const SizedBox(width: 10,),
          if(isMe) ProfileContainer(isMe: isMe)
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final bool isMe;
  const ProfileContainer({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isMe ? Theme.of(context).colorScheme.primary : Colors.grey.shade800
      ),
      child: Icon(isMe ? Icons.person : Icons.computer, color: Colors.white,),
    );
  }
}
