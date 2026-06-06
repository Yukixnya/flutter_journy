import 'package:flutter/material.dart';
import 'package:dice_app/models/dice_data.dart';

class DiceRollHomepage extends StatefulWidget{
  const DiceRollHomepage({super.key});

  @override
  State<DiceRollHomepage> createState() => _DiceRollHomepage();
}

class _DiceRollHomepage extends State<DiceRollHomepage>{
  var dice = dice_roll_data[0];
  getDice(){
    setState(() {
      dice_roll_data.shuffle();
      dice = dice_roll_data.first;
    });
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Dice Roll",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rolled ${dice.keys.first} !",style: TextStyle(fontSize: 40),),
            SizedBox(height: 50,),
            Image.asset(dice.values.first,height: 200,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: getDice, child: Text("Roll"))
          ],
        ),
      ),
    );
  }
}
