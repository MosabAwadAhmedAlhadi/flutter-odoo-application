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
                  // set value for email
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
                  // validate Password, note that here just checked for empty
                  // you should check for the patterns like not letting the password pass if it less
                  // than 8 chars and don't contain a special chars.
                  if (value == null || value.isEmpty){
                    print("value is $value");
                    return 'please fill the password field';
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  // set value for the password
                  formData.password = value;
                },
              ),
              TextButton(
                child: Text('Sign in'),
                onPressed: () async {
                  // first validate the input before data sent to server
                  if (_formKey.currentState.validate() == false) {
                    print(_formKey.currentState.validate());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                  // if pass the validation now send data to server and validate
                  else {
                    // the body of the post request
                    final dataSent = {
                      "jsonrpc":2.0,
                      "params":{
                        "db": "latebackup",
                        "login": formData.email,
                        "password": formData.password
                      }
                    };
                    // a post request to an Odoo server running in my local network,
                    // if you running in your localhost you can use the android localhost ip instead :)
                    final response = await http.post(
                      // parse the url from a string to Uri in case it contains special chars
                      Uri.parse(
                          'http://192.168.100.151:8069/web/session/authenticate'),
                      // request header
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(dataSent),
                    );
                    // convert data to json so it can be easier on reading
                    final responseData = jsonDecode(response.body);
                    // if the request went and came back successfully from the server
                    // note if you're not familiar with responses status code please check the simplest documentation on it :)
                    if (response.statusCode == 200) {
                      // check for errors in the response body
                      if (response.body.contains("error")){
                        // check if it access denial error
                        // note: this might not be the best way to check for errors but this is the one
                        // we will be using for this project and i hope we will get better by time
                        if (responseData['error']['data']['name'] == 'odoo.exceptions.AccessDenied'){
                          // show a tip that the password or the user name might be wrong
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              SnackBar(content: Text('Wrong Username or Password')));
                        }
                        // if it's another error please check the server
                        else{
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              SnackBar(content: Text('Check for server Errors')));
                        }
                      }
                      // if no errors and the login is successful go to the second page
                      else{
                        // Navigator is the stack class that control the navigation between screens.
                        // not the best practice but it work for now :)
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      }

                    }
                    else {
                      throw Exception('Failed to load from server');
                    }
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
