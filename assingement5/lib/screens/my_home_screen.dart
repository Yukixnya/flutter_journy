import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 208, 208),
      appBar: AppBar(
        title: const Text('Who I Am', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 243, 191, 33),
      ),
      body: Center(
        child: Column(
          children: [
              const SizedBox(height: 10),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 4),
                  image: const DecorationImage(
                    image: AssetImage('assets/Perfect.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Yuki',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 243, 128, 33)),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(195, 243, 128, 33),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                  "\nSkilled in Python, Java, and bit in C++, with solid foundations in data structures, algorithms, and OOPs.\n\nI’m very much interested in becoming a Data Scientist.\n\nExperienced in building projects involving AI/ML, data automation, and scripting.\n\nFamiliar with Flask and frontend tech like JavaScript, React.\n\nActively solving problems on platforms like SmartInterviews, HackerRank, CodeChef, Leetcode and eager to explore data-driven solutions.\n",
                    // textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(223, 243, 82, 33),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "\nI am curently learnig Flutter Development to showcase my skills as a peoduct.\n",
                    // textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 80,
                child: Image(
                  image: AssetImage('assets/xiaoyan.png'),
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ), 
      )
    );
  }
}