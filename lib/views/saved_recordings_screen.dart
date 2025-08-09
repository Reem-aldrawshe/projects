import 'package:flutter/material.dart';

class SavedRecordingsScreen extends StatelessWidget {
  final List<String> recordings;

  const SavedRecordingsScreen({Key? key, required this.recordings})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("التسجيلات المحفوظة")),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recordings[index]),
            leading: Icon(Icons.play_arrow),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
