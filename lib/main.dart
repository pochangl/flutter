import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class ExampleModel {
  String name;
  String description;

  ExampleModel(Map<String, dynamic> json) {
    this.name = json['name'];
    this.description = json['description'];
  }
}

Future<Map<String, dynamic>> get (String url) async  {
  final response = await http.get(url);
  return jsonDecode(response.body);
}

Future<List<ExampleModel>> getModels () async {
  final json = await get('https://raw.githubusercontent.com/pochangl/flutter/http/assets/example.json');
  List<dynamic> objects = json['objects'];
  return objects.map((obj) => ExampleModel(obj)).toList();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter HTTP demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: getModels(),
          builder: (BuildContext context, AsyncSnapshot<List<ExampleModel>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.map((ExampleModel model) => Row(
                    children: [
                      Text(model.name),
                      Text(model.description),
                    ]
                )).toList(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Data fetching error');
            }
            return Text('Now loading');
          },
        )
      ),
    );
  }
}
