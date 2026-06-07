import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:journal_app/data/data.dart';
import 'package:journal_app/data/journal_entry_model.dart';

class JournalEntryCard extends StatelessWidget{
  final JournalEntryModel entrys;
  const JournalEntryCard({required this.entrys,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[100],
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${entrys.title}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text("${entrys.content}",style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8.0),
            Text("${entrys.date}",style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 8.0),
          ],
        ),
      )
    );
  }
}