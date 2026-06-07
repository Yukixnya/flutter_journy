import 'package:flutter/material.dart';
import 'package:journal_app/data/data.dart';
import 'package:journal_app/data/journal_entry_model.dart';

class AddEntryBottom extends StatefulWidget{
  final Function(JournalEntryModel) onSave;
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
                    JournalEntryModel entry = JournalEntryModel(
                      id: journal_list.length + 1, 
                      title: _titleEditingController.text, 
                      content: _contentEditingController.text, 
                      date: DateTime.now()
                    );

                    // setState(() {
                    //   journal_list.add(entry);
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