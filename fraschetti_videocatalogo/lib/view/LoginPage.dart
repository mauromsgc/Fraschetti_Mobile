
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title = 'Login'}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: new EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 2,
            ),
          ),
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                //width: 200.0,
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    icon: Icon(
                      Icons.account_box,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    icon: Icon(
                      Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {},
                  child: Text('Login'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {},
                  child: Text('Test comunicazione'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {},
                  child: Text('Parametri'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
