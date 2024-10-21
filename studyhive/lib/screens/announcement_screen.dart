import 'dart:ui'; // Required for the Frosted Glass effect
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/announcement_provider.dart';
import '../models/announcement.dart';
import '../models/user.dart';

class AnnouncementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Announcements')),
      body: Container(
        color: const Color(0xFFFFD8B2), // Set background color to #FFB668
        child: Column(
          children: [
            Expanded(
              child: Consumer<AnnouncementProvider>(
                builder: (ctx, announcementProvider, _) => ListView.builder(
                  itemCount: announcementProvider.announcements.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(announcementProvider.announcements[i].subject),
                    subtitle:
                        Text(announcementProvider.announcements[i].details),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        // Implement chat initiation
                      },
                    ),
                  ),
                ),
              ),
            ),
            AnnouncementInputForm(),
          ],
        ),
      ),
    );
  }
}

class AnnouncementInputForm extends StatefulWidget {
  @override
  _AnnouncementInputFormState createState() => _AnnouncementInputFormState();
}

class _AnnouncementInputFormState extends State<AnnouncementInputForm> {
  final _subjectController = TextEditingController();
  final _detailsController = TextEditingController();

  void _submitData() {
    if (_subjectController.text.isEmpty || _detailsController.text.isEmpty)
      return;

    Provider.of<AnnouncementProvider>(context, listen: false).addAnnouncement(
      Announcement(
        id: DateTime.now().toString(),
        subject: _subjectController.text,
        details: _detailsController.text,
        time: DateTime.now(),
        creator: User(id: '1', name: 'Alice'), // Hardcoded for now
      ),
    );

    _subjectController.clear();
    _detailsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Frosted Glass effect
          child: Container(
            decoration: BoxDecoration(
              color:
                  Colors.white.withOpacity(0.5), // Semi-transparent background
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(
                        color: Colors.black), // White text for dark theme
                  ),
                  controller: _subjectController,
                  style: TextStyle(
                      color: Colors.black), // White text for user input
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Details',
                    labelStyle: TextStyle(
                        color: Colors.black), // White text for dark theme
                  ),
                  controller: _detailsController,
                  style: TextStyle(
                      color: Colors.white), // White text for user input
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Add Announcement'),
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFF8D01), // Button text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
