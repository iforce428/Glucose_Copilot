import 'package:flutter/material.dart';
import '../models/message.dart';
import 'action_buttons.dart';

class ChatMessage extends StatelessWidget {
  final Message message;

  const ChatMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAvatar(false),
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: message.isUser ? 50.0 : 8.0,
                    right: message.isUser ? 8.0 : 50.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? Colors.grey[300]
                        : message.isTyping
                            ? Colors.grey[200]
                            : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: message.isUser
                        ? null
                        : Border.all(color: Colors.grey[300]!),
                  ),
                  child: message.isTyping
                      ? _buildTypingIndicator()
                      : Text(
                          message.text,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                ),
                if (message.actionButtons != null && !message.isTyping)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: ActionButtonsRow(buttons: message.actionButtons!),
                  ),
              ],
            ),
          ),
          if (message.isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: isUser ? Colors.blue[100] : Colors.green[100],
        child: isUser
            ? const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-sYiAsCAwiWPMZPN9U6ZHGt2U7gkDAh.png',
                ),
              )
            : const Icon(
                Icons.health_and_safety,
                color: Colors.green,
                size: 20,
              ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0),
        _buildDot(1),
        _buildDot(2),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

