import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('Hello World' , style: TextStyle(fontSize: 30)),
      appBar: AppBar(
        title: Text('Hello World App'),
        backgroundColor: Colors.amber,
      ),
      // body: Center(
      //   child: Container(
      //     height: 40,
      //     width: 300,
      //     color: Colors.amber,
      //     child: Center(
      //         child: Text('Hello World',
      //             style: TextStyle(
      //               fontSize: 30,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.blue,
      //             )
      //         ),
      //     ),
      //   ),
      // ),
      body: Center( // horizontal center
        child: Column( // Same goes for Row also
          mainAxisAlignment: MainAxisAlignment.center, // vertical center
          crossAxisAlignment: CrossAxisAlignment.stretch, // matters only cause container width is 300
          children: [
            SizedBox(height: 20),
            Container(
              height: 40,
              width: 300,
              color: Colors.amber,
              child: Center(
                child: Text('Hello World',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              width: 300,
              color: Colors.amber,
              child: Center(
                child: Text('Hello World',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}