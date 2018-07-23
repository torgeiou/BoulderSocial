import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangtimer/LoginPage.dart';
import 'package:hangtimer/Wall.dart';
import 'package:hangtimer/WallFlipper.dart';
import 'package:hangtimer/wall_data.dart';

void main() {
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.light,
      ),
      home: new WallSelectorPage(title: 'Flutter Demo Home Page'),
      initialRoute: '/login',
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
      },
      
    );
  }
}

class WallSelectorPage extends StatefulWidget {
  WallSelectorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WallSelectorPageState createState() => new _WallSelectorPageState();
}

class _WallSelectorPageState extends State<WallSelectorPage> {
  double scrollPercent = 0.0;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(

      backgroundColor: Colors.black,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // room for status bar
          new Container(
            width: double.infinity,
            height: 20.0,
          ),

          // Walls
          new Expanded(
            child: new WallFlipper(
              walls: demoWalls,
              onScroll: (double  scrollPercent){
                setState(() {
                  this.scrollPercent = scrollPercent;
                });
              }
            ),
          ),

          // Bottom bar
          new BottomBar(
            wallCount: demoWalls.length,
            scrollPercent: scrollPercent,
          )
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final wallCount;
  final scrollPercent;

  BottomBar({
    this.wallCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Center(
              child: new Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 5.0,
              child: new ScrollIndicator(
                wallCount: wallCount,
                scrollPercent: scrollPercent,
              ),
            ),
          ),
          Expanded(
            child: new Center(
              child: new IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  // TODO: add page for adding wall
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  final int wallCount;
  final double scrollPercent;

  ScrollIndicator({
    this.scrollPercent,
    this.wallCount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: new ScrollIndicatorPainter(
        wallCount: wallCount,
        scrollPercent: scrollPercent,
      ),
      child: new Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int wallCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.scrollPercent,
    this.wallCount,
  })  : trackPaint = new Paint()
          ..color = const Color(0xFF444444)
          ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // draw track for the scroll bar
    canvas.drawRRect(
        new RRect.fromRectAndCorners(
          new Rect.fromLTWH(
            0.0,
            0.0,
            size.width,
            size.height,
          ),
          topLeft: new Radius.circular(3.0),
          topRight: new Radius.circular(3.0),
          bottomLeft: new Radius.circular(3.0),
          bottomRight: new Radius.circular(3.0),
        ),
        trackPaint);

    // draw thumb
    final thumbWidth = size.width / wallCount;
    final thumbLeft = scrollPercent * size.width;

    canvas.drawRRect(
        new RRect.fromRectAndCorners(
          new Rect.fromLTWH(
            thumbLeft,
            0.0,
            thumbWidth,
            size.height,
          ),
          topLeft: new Radius.circular(3.0),
          topRight: new Radius.circular(3.0),
          bottomLeft: new Radius.circular(3.0),
          bottomRight: new Radius.circular(3.0),
        ),
        thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
