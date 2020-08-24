import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Data {
  final String name;
  final String next;
  final String data;

  Data({ this.name, this.next, this.data });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Page(routeData: Data(name: 'Home Page', next: '/second', data: 'from home')),
        '/second': (context) => Page(routeData: Data(name: 'Second page', next: '/', data: 'from second')),
      }
    );
  }
}

class Page extends StatelessWidget {
  Page({Key key, @required this.routeData}) : super(key: key);

  final Data routeData;

  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(routeData.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text('I am ${routeData.name} page'),
            Text('I got $data from previous page'),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, routeData.next, arguments: routeData.data);
              },
              child: Text('Click to go to ${routeData.next}')
            )
          ],
        ),
      ),
    );
  }
}
