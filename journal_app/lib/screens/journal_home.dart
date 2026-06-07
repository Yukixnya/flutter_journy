import 'package:flutter/material.dart';
import 'package:journal_app/data/data.dart';
import 'package:journal_app/widgets/journl_entry_card.dart';
import 'package:journal_app/widgets/add_entry_bottom.dart';

class JournalHome extends StatefulWidget{
  const JournalHome({super.key});

  State<JournalHome> createState() => _JournalHome();
}

class _JournalHome extends State<JournalHome>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal App", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: journal_list.length,
        itemBuilder: (context, index){
          return JournalEntryCard(
            entrys: journal_list[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return AddEntryBottom(onSave: (entry) {
                setState(() {
                  journal_list.add(entry);
                });
              });
            }
          );
        },
        child:Icon(Icons.add,size: 30)),
    );
  }
}







      // body: SingleChildScrollView(
        // child: Column(
        //   children: [
        //     for(int i=0; i<30; i++)
        //       Card(
        //         color: Colors.amber[300],
        //         elevation: 2.0,
        //         margin: EdgeInsets.all(10.0),
        //         child: Padding(
        //           padding: EdgeInsets.all(16.0),
        //           child: Text('Basic Card Content'),
        //         ),
        //       )
        //   ],
        // )
      // ),
      // body: ListView(
      //   children: [
      //     const JournalEntryCard(),
      //     const JournalEntryCard(),
      //     const JournalEntryCard(),
      //   ],
      // ),