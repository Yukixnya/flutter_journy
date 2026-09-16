import 'package:flutter/material.dart';
import 'package:todo_backend/data/todo_entry_model.dart';
import 'package:todo_backend/service/notification_service.dart';

class AddEntryBottom extends StatefulWidget{
  final Function(TodoEntryModel) onSave;
  const AddEntryBottom({required this.onSave,super.key});

  State<AddEntryBottom> createState() => _AddEntryBottom();
}

class _AddEntryBottom extends State<AddEntryBottom>{

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();
  DateTime? _selectedReminderDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null && mounted) {
        setState(() {
          _selectedReminderDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 8.0,
            right: 8.0,
            top: 8.0),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
  
              TextField(
                controller: _titleEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                ),
              ),
  
              SizedBox(height: 20),
  
              TextField(
                minLines: 2,
                maxLines: null,
                controller: _contentEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Content"
                ),
              ),
  
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.alarm, color: _selectedReminderDateTime != null ? Colors.blue : Colors.grey),
                    onPressed: () => _pickDateTime(context),
                  ),
                  Text(_selectedReminderDateTime != null 
                    ? "${_selectedReminderDateTime!.month}/${_selectedReminderDateTime!.day} at ${_selectedReminderDateTime!.hour}:${_selectedReminderDateTime!.minute.toString().padLeft(2, '0')}"
                    : "No reminder set"
                  ),
                  if (_selectedReminderDateTime != null)
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red, size: 20),
                      onPressed: () => setState(() => _selectedReminderDateTime = null),
                    )
                ],
              ),
              SizedBox(height: 10),
  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",style: TextStyle(color: Colors.red))
                  ),
                  ElevatedButton(
                    onPressed: (){
                      TodoEntryModel entry = TodoEntryModel(
                        id: '',
                        title: _titleEditingController.text, 
                        content: _contentEditingController.text, 
                        date: DateTime.now(),
                        reminderDateTime: _selectedReminderDateTime,
                      );
  
                      // Schedule notification if reminder is set
                      if (_selectedReminderDateTime != null && _selectedReminderDateTime!.isAfter(DateTime.now())) {
                         // Use a random or timestamp based ID for local notification
                         int notifId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
                         NotificationService().scheduleNotification(
                           id: notifId,
                           title: "Reminder: ${_titleEditingController.text}",
                           body: _contentEditingController.text,
                           scheduledTime: _selectedReminderDateTime!
                         );
                      }
  
                      widget.onSave(entry);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[400]),
                    child: Text("Submit",style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}