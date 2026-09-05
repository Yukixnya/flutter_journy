import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/data/todo_entry_model.dart';
import 'package:todo_backend/service/entry_service.dart';

// Service provider for EntryService
final ToDoEntryServiceProvider = Provider<EntryService>((ref){
  return EntryService();
});


// Stream provider for ToDoEntries
final ToDoEntriesProvider = StreamProvider<List<TodoEntryModel>>((ref) {
  final entryService = ref.read(ToDoEntryServiceProvider);
  return entryService.getEntries();
});