import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SetttinsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SetttinsPageState();
  }
}

class SetttinsPageState extends State<SetttinsPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body:Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Token',
            ),
            onEditingComplete: (){

            },
          ),
        ],
      )
    );
  }
}