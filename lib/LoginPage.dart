import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {


  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: new ListView(
          padding: new EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(
                height: 80.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  'BS',
                  style: new TextStyle(
                    fontFamily: 'petita',
                    fontSize: 100.0,
                    color: Colors.black,
                    letterSpacing: 10.0,
                  ),
                ),
                SizedBox(height: 16.0),

                // username textfield
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Username',
                  ),
                ),

                // spacing
                SizedBox(height: 10.0),

                // password textfield
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Password',
                  ),
                  obscureText: true,
                )

              ],
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: (){
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                RaisedButton(
                  child: Text('Next'),
                  onPressed: (){
                    Navigator.pop(context);
                    //Navigator.of(context).pushNamed('/');
                  },
                ),
              ],
            )

          ],
        )
      ),

    );
  }



  Widget _createTextBox(){
    return new Container();

  }

}
