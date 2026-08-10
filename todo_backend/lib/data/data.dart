import 'package:todo_backend/data/todo_entry_model.dart';

List<TodoEntryModel> todo_list = [
  TodoEntryModel(
    id: 1, 
    title: "Creation", 
    content: "Todo Entry Was Created", 
    date: DateTime(2026, 6, 6, 14, 30, 45, 765)
  ),
  TodoEntryModel(
    id: 2,
    title: "Tested",
    content: "Todo Entry Was Tested",
    date: DateTime.now()
  )
];