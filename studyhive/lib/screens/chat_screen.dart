import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String friendName;

  ChatScreen({required this.friendName}); // Constructor to accept friend's name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Chat with $friendName')), // Display friend's name
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                MessageBubble(message: 'Hello', isMe: true),
                MessageBubble(message: 'Hi $friendName!', isMe: false),
              ],
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

// MessageBubble and ChatInputField remain unchanged
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    // Add message sending logic here
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
