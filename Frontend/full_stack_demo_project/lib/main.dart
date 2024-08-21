import 'dart:convert';
import 'dart:developer'; // Use this for logging

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'jokes.model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<JokesModel> _jokes = [];

  void _incrementCounter() async {
    await fetchData();
    setState(() {
      _counter++;
    });

    
  }

  Future<void> fetchData() async {
    try {
      final dio = Dio();
      final response =
          await dio.get('https://full-stack-demo-project.onrender.com/jokes');

      log(response.statusMessage.toString());

      if (response.statusCode == 200) {
        log("data fetched successfully {${response.data..runtimeType}}");
        final List<dynamic> jsonData = jsonDecode(response.data);
        final List<JokesModel> data = jsonData.map((item) => JokesModel.fromJson(item)).toList();
        //_jokes = response.data;
        // String jokes = '';

        // for (var item in data) {
        //   jokes += 'Title: ${item['title']}\nPunchline: ${item['punchline']}\n\n\n\n';
        // }

        setState(() {
         // _jokes = jokes; // Update the state with fetched jokes
         _jokes = data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Failed to fetch data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Ram",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            for(var item in _jokes)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Title: ${item.title}\nPunchline: ${item.punchline}", // Display the fetched jokes here
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
