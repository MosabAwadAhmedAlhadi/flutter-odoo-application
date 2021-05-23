import 'package:flutter/material.dart';

class Customers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            centerTitle:true,
            title: Text("Customers"),
          ),
          body:Center(
            child: Text("Customers"),
          )
        ),
      ),
    );
  }
}
