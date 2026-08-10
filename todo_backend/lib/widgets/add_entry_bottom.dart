import 'package:flutter/material.dart';
import 'package:todo_backend/data/data.dart';
import 'package:todo_backend/data/todo_entry_model.dart';

class AddEntryBottom extends StatefulWidget{
  final Function(TodoEntryModel) onSave;
  const AddEntryBottom({required this.onSave,super.key});

  State<AddEntryBottom> createState() => _AddEntryBottom();
}

class _AddEntryBottom extends State<AddEntryBottom>{

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

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

            // ElevatedButton(onPressed: data, child: Text("print content")),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancle",style: TextStyle(color: Colors.red))
                ),
                ElevatedButton(
                  onPressed: (){
                    TodoEntryModel entry = TodoEntryModel(
                      id: todo_list.length + 1, 
                      title: _titleEditingController.text, 
                      content: _contentEditingController.text, 
                      date: DateTime.now()
                    );

                    // setState(() {
                    //   todo_list.add(entry);
                    // });

                    widget.onSave(entry);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[400]),
                  child: Text("Submit",style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}