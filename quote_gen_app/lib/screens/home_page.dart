import 'package:flutter/material.dart';
import 'package:quote_gen_app/models/quote_list.dart';

class QuoteGenHomePage extends StatefulWidget{
  const QuoteGenHomePage({super.key});

  @override
  State<QuoteGenHomePage> createState() => _QuoteGenHomePageState();
}

class _QuoteGenHomePageState extends State<QuoteGenHomePage>{
  String quote = quotes.first;
  void generateQuote(){
    setState(() {
      quotes.shuffle();
      quote = quotes.first;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote Generator"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.grey[600],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("''$quote''",style: TextStyle(fontSize: 25, color: Colors.white,fontStyle: FontStyle.italic),textAlign: TextAlign.center),
          ElevatedButton(
            onPressed: generateQuote,
            child: Text("Generate Quote"),
          ),
        ],
      ),
    );
  }
  
}