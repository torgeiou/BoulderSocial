import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {


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

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Username',
                  ),
                ),

                // spacing
                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Password',
                  ),
                  obscureText: true,
                )

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
