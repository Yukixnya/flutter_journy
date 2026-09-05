import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/data/todo_entry_model.dart';
import 'package:todo_backend/providers/entry_service_provider.dart';

class TodoEntryCard extends ConsumerWidget {
  final TodoEntryModel entrys;
  const TodoEntryCard({required this.entrys, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.amber[100],
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entrys.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Text(entrys.content, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text("${entrys.date.day}/${entrys.date.month}/${entrys.date.year}", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            ),
            // The Delete Button
            IconButton(
              icon: Icon(Icons.delete, color: Colors.blueGrey[500]),
              tooltip: 'Delete Entry',
              onPressed: () async {
                try {
                  final service = ref.read(ToDoEntryServiceProvider);
                  await service.deleteEntry(entrys.id);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      )
    );
  }
}