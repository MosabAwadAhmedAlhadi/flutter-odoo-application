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
          body:CustomersList()
        ),
      ),
    );
  }
}
class CustomersList extends StatefulWidget {
  @override
  _CustomersListState createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
      ),
    );
  }
}

