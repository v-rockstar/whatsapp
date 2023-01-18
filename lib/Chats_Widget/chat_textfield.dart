import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Chats_Widget/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  final String receiverId;
  const ChatTextField({required this.receiverId, super.key});

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  bool showSendButton = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendTextMessage() {
    if (showSendButton == true) {
      ref
          .read(chatControllerProvider)
          .sendTextMessage(context, _controller.text.trim(), widget.receiverId);
      setState(() {
        _controller.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: _controller,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  showSendButton = false;
                } else {
                  showSendButton = true;
                }
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.grey[700],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
              prefixIcon:
                  const Icon(Icons.emoji_emotions, color: Colors.white70),
              hintText: 'Message',
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file,
                            color: Colors.white70)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt,
                            color: Colors.white70)),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(Icons.currency_rupee,
                    //         color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: sendTextMessage,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 25,
              child: showSendButton
                  ? const Icon(Icons.send, color: Colors.white)
                  : const Icon(Icons.mic, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
