import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimensions = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final padding = MediaQuery.of(context).padding;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MediaQuery Example'),
        ),
        body: Column(
          children: [
            Text('Screen Height: ${dimensions.height}'),
            Text('Screen Width: ${dimensions.width}'),
            Text('Screen Orientation: ${orientation.name}'),
            Text('Top Padding: ${padding.top}'),
            Text('Bottom Padding: ${padding.bottom}'),

            Container(
              height: orientation == Orientation.portrait ? dimensions.height * 0.2 : dimensions.height * 0.4,
              width: dimensions.width * 0.8,
              color: Colors.blue,
            )



          ],
        ),
      ),
    );
  }
}
