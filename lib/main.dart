import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter storage'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  String fieldValue;

  _loadField() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fieldValue = prefs.getString('fieldValue') ?? 'Not available';
    });
  }

  _saveField(String val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('fieldValue', val);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadField();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Saved text: $fieldValue'),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) return 'Please enter some text';
              return null;
            },
            onChanged: (value) {
              this.fieldValue = value;
            },
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saving Data')));
                _saveField(fieldValue);
              }
            },
            child: Text('Submit'),
          )
        ]
      ),
    );
  }
}