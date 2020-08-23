import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App state demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: ChangeNotifierProvider(
            create: (context) => CountModel(),
            child: Column(
              children: [
                countButton(),
                countText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget countButton() {
  return Consumer<CountModel> (
    builder: (context, cart, child) {
      return IconButton(
        onPressed: () => cart.increment(),
        icon: Icon(Icons.add)
      );
    }
  );
}

Widget countText () {
  return Consumer<CountModel> (
    builder: (context, cart, child) {
      return Column(
        children: [
          Text('You have clicked ${cart.count} times'),
        ],
      );
    },
  );
}

class CountModel extends ChangeNotifier {
  int count = 1;

  void increment() {
    this.count ++;
    notifyListeners();
  }
}
