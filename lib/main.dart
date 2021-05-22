import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mass_project/home.dart';
void main() => runApp(MyApp());

class FormData{
  var email;
  var password;
  FormData({this.email,this.password});
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FormData formData = FormData();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
      ),
      body: Center(
        child:Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus:  true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Your email address',
                  labelText: 'Email',
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    print("value is $value");
                    return 'please fill the user name field';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  formData.email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value){
                  if (value == null || value.isEmpty){
                    print("value is $value");
                    return 'please fill the password field';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  formData.password = value;
                },
              ),
              TextButton(
                child: Text('Sign in'),
                onPressed: () async {
                  if (_formKey.currentState.validate() == false) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    print("here in this shit ");
                    print(_formKey.currentState.validate());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                  else {
                    print("here before the request");
                    final response = await http.post(
                      Uri.parse(
                          'http://192.168.100.250:8069/web/session/authenticate'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        "db": "test1",
                        "login": formData.email,
                        "password": formData.password
                      }),
                    );
                    print("here after the request");
                    if (response.statusCode == 200) {
                      print(response);
                    } else {
                      throw Exception('Failed to load album');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
