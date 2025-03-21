import 'package:flutter/material.dart';
import 'models/message.dart';
import 'widgets/chat_message.dart';
import 'widgets/message_input.dart';
import 'widgets/action_buttons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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



  void _handleUserMessage(String text) async {
    const url = "https://iforce428.app.n8n.cloud/webhook/c8aebe2f-2d73-45af-82b9-947f137e74dd/chat";

    final Map<String, dynamic> body = {
      "chatInput": text,
      "sessionId": "123",
      "action": "sendMessage",
      "user_id": "8e29e45d-7071-4307-9f18-a01db05f0991",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Extracting the nested output object
        final outputData = data["output"];
        if (outputData == null || outputData["output"] == null) {
          _addBotMessage("Invalid response from server.", null);
          return;
        }

        String botReply = outputData["output"];
        List<ActionButton>? actionButtons;

        if (outputData.containsKey("buttons") && outputData["buttons"] is List) {
          actionButtons = (outputData["buttons"] as List).map<ActionButton>((btn) {
            return ActionButton(
              label: btn["label"] ?? "Button",
              onTap: () => _handleActionButtonTap(btn["label"]),
            );
          }).toList();
        }

        _addBotMessage(botReply, actionButtons);
      } else {
        _addBotMessage("Error: Unable to fetch response. Please try again.", null);
      }
    } catch (e) {
      _addBotMessage("Network error: ${e.toString()}", null);
    }
  }

  void _handleActionButtonTap(String action) {
    _addMessage(action, true); // Show user’s choice in chat
    _handleUserMessage(action); // Send button action as new message
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

