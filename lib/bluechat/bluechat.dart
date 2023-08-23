import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Flutter Example", home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () {
            setState(() {
              _switchValue = !_switchValue;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: _switchValue
                  ? const LinearGradient(
                  colors: [Color(0xffFF5E3A), Color(0xffFF2A68)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)
                  : null,
              color: _switchValue ? null : const Color(0xffF0F2F5),
            ),
            child: Center(
              child: Switch(
                value: _switchValue,
                activeColor: Colors.white,
                inactiveThumbColor: const Color(0xffF0F2F5),
                onChanged: (bool value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ),
          ),
        ));
  }
}
