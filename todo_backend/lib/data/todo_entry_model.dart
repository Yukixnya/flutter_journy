import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntryModel {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  TodoEntryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory TodoEntryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoEntryModel(id: doc.id, title: data['title'], content: data['content'], date: (data['date'] as Timestamp).toDate());
  }
}