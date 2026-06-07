import 'package:journal_app/data/journal_entry_model.dart';

List<JournalEntryModel> journal_list = [
  JournalEntryModel(
    id: 1, 
    title: "Creation", 
    content: "Journal Entry Was Created", 
    date: DateTime(2026, 6, 6, 14, 30, 45, 765)
  ),
  JournalEntryModel(
    id: 2,
    title: "Tested",
    content: "Journal Entry Was Tested",
    date: DateTime.now()
  )
];