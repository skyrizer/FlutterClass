import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hello Flutter"), backgroundColor: Colors.brown,),
        body: Center(child: Text("Hello World"))
    );
  }
}