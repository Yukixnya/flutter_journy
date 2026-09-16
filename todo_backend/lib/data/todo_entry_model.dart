import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntryModel {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final DateTime? reminderDateTime;

  TodoEntryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.reminderDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'reminderDateTime': reminderDateTime,
    };
  }

  factory TodoEntryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoEntryModel(
      id: doc.id, 
      title: data['title'], 
      content: data['content'], 
      date: (data['date'] as Timestamp).toDate(),
      reminderDateTime: data['reminderDateTime'] != null 
          ? (data['reminderDateTime'] as Timestamp).toDate() 
          : null,
    );
  }
}