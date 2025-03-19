import '../widgets/action_buttons.dart';

class Message {
  final String text;
  final bool isUser;
  final DateTime? timestamp;
  final List<ActionButton>? actionButtons;
  final bool isTyping;

  const Message({
    required this.text,
    required this.isUser,
    this.timestamp,
    this.actionButtons,
    this.isTyping = false,
  });
}

