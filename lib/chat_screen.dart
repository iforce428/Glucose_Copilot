import 'package:flutter/material.dart';
import 'models/message.dart';
import 'widgets/chat_message.dart';
import 'widgets/message_input.dart';
import 'widgets/action_buttons.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  
  @override
  void initState() {
    super.initState();
    // Add initial greeting message
    _addBotMessage(
      "Hi Husna, how can I help?",
      null, // No action buttons for greeting
    );
  }

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: isUser,
        timestamp: DateTime.now(),
      ));
    });
    
    _scrollToBottom();
    
    if (isUser) {
      // Simulate bot typing
      setState(() {
        _isTyping = true;
      });
      
      // Simulate bot response after delay
      Future.delayed(const Duration(seconds: 1), () {
        _handleUserMessage(text);
      });
    }
  }
  
  void _addBotMessage(String text, List<ActionButton>? actionButtons) {
    setState(() {
      _isTyping = false;
      _messages.add(Message(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
        actionButtons: actionButtons,
      ));
    });
    
    _scrollToBottom();
  }
  
  void _handleUserMessage(String text) {
    // Simple pattern matching for demo purposes
    if (text.toLowerCase().contains('blood glucose') || 
        text.toLowerCase().contains('sugar level')) {
      _addBotMessage(
        "Hi Husna. Your blood glucose level today is 7.8 mmol/L, which is slightly above the target range. Consider a balanced meal and some light activity to help regulate it today.",
        [
          ActionButton(
            label: "Recommended Meal",
            onTap: () => _handleActionButtonTap("Recommended Meal"),
          ),
          ActionButton(
            label: "Schedule Workout",
            onTap: () => _handleActionButtonTap("Schedule Workout"),
          ),
          ActionButton(
            label: "Check Medication",
            onTap: () => _handleActionButtonTap("Check Medication"),
          ),
        ],
      );
    } else if (text.toLowerCase().contains('medication') || 
              text.toLowerCase().contains('medicine')) {
      _addBotMessage(
        "Your current medication schedule includes Metformin 500mg twice daily. Your next dose is due at 8:00 PM.",
        [
          ActionButton(
            label: "Medication Details",
            onTap: () => _handleActionButtonTap("Medication Details"),
          ),
          ActionButton(
            label: "Set Reminder",
            onTap: () => _handleActionButtonTap("Set Reminder"),
          ),
        ],
      );
    } else if (text.toLowerCase().contains('exercise') || 
              text.toLowerCase().contains('workout')) {
      _addBotMessage(
        "Based on your glucose levels, I recommend 30 minutes of moderate walking today. This can help lower your blood glucose and improve insulin sensitivity.",
        [
          ActionButton(
            label: "View Exercise Plan",
            onTap: () => _handleActionButtonTap("View Exercise Plan"),
          ),
          ActionButton(
            label: "Log Activity",
            onTap: () => _handleActionButtonTap("Log Activity"),
          ),
        ],
      );
    } else {
      _addBotMessage(
        "I'm here to help with your health management. You can ask about your blood glucose levels, medication schedule, or exercise recommendations.",
        null,
      );
    }
  }
  
  void _handleActionButtonTap(String action) {
    switch (action) {
      case "Recommended Meal":
        _addBotMessage(
          "Here's a balanced meal plan for today:\n\n"
          "Breakfast: Greek yogurt with berries and nuts\n"
          "Lunch: Grilled chicken salad with olive oil dressing\n"
          "Dinner: Baked salmon with roasted vegetables\n"
          "Snacks: Apple slices with almond butter",
          [
            ActionButton(
              label: "Save Meal Plan",
              onTap: () => _handleActionButtonTap("Save Meal Plan"),
            ),
            ActionButton(
              label: "Adjust Portions",
              onTap: () => _handleActionButtonTap("Adjust Portions"),
            ),
          ],
        );
        break;
      case "Schedule Workout":
        _addBotMessage(
          "I've created a workout schedule for you:\n\n"
          "Today: 30 min walking\n"
          "Tomorrow: 20 min strength training\n"
          "Day after: 30 min swimming or cycling",
          [
            ActionButton(
              label: "Add to Calendar",
              onTap: () => _handleActionButtonTap("Add to Calendar"),
            ),
            ActionButton(
              label: "Modify Workout",
              onTap: () => _handleActionButtonTap("Modify Workout"),
            ),
          ],
        );
        break;
      case "Check Medication":
        _addBotMessage(
          "Your current medication:\n\n"
          "Metformin 500mg - Take twice daily with meals\n"
          "Next dose: Today at 8:00 PM\n"
          "Refill needed in: 7 days",
          [
            ActionButton(
              label: "Set Reminder",
              onTap: () => _handleActionButtonTap("Set Reminder"),
            ),
            ActionButton(
              label: "Request Refill",
              onTap: () => _handleActionButtonTap("Request Refill"),
            ),
          ],
        );
        break;
      default:
        _addBotMessage(
          "I've processed your request for: $action. This feature would be fully implemented in the complete app.",
          null,
        );
    }
  }
  
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {
              // Handle menu button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    // Show typing indicator
                    return const ChatMessage(
                      message: Message(
                        text: "typing...",
                        isUser: false,
                        timestamp: null,
                        isTyping: true,
                      ),
                    );
                  }
                  return ChatMessage(message: _messages[index]);
                },
              ),
            ),
          ),
          MessageInput(
            onSendMessage: (text) => _addMessage(text, true),
          ),
        ],
      ),
    );
  }
}

