import 'package:flutter/material.dart';
import './chat_screen.dart';

class FriendSelectionScreen extends StatelessWidget {
  final List<String> friends = ['Alice', 'Bob', 'Charlie', 'Dave'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Friend')),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(friends[index]),
            onTap: () {
              // Navigate to ChatScreen with the selected friend's name
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatScreen(friendName: friends[index]),
              ));
            },
          );
        },
      ),
    );
  }
}
