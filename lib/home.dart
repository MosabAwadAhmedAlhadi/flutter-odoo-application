import 'package:flutter/material.dart';
import 'package:mass_project/main.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text:"Properity Management"),
                  Tab(text:"Contracts and Payments"),
                ],
              ),
              title: Text("Dashboard"),
            ),
            body: TabBarView(
              children: [
                HomePageContent(),
                ContractsManagement(),

              ],
            ),
          ),
      )
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    // here we will return our home page content later

    return Center(
      child:GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
              Container(
                child: ElevatedButton(
                  child: Text("Properity"),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("Units"),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  }
                  ,
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("Customers"),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  }
                  ,
                ),
              ),
            ],
          )
    );
  }
}

class ContractsManagement extends StatefulWidget {
  @override
  _ContractsManagementState createState() => _ContractsManagementState();
}

class _ContractsManagementState extends State<ContractsManagement> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            Container(
              child: ElevatedButton(
                child: Text("Contracts"),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("Payments"),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                }
                ,
              ),
            ),
          ],
        )
    );
  }
}
