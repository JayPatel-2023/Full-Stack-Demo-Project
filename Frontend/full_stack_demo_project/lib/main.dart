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
  late Future<List<JokesModel>> _jokesFuture;

  @override
  void initState() {
    super.initState();
    _jokesFuture = fetchData();
  }

  Future<List<JokesModel>> fetchData() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://full-stack-demo-project.onrender.com/api/v1/jokes');

      log(response.statusMessage.toString());

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        final List<JokesModel> data = jsonData.map((item) => JokesModel.fromJson(item)).toList();

        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Failed to fetch data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<JokesModel>>(
        future: _jokesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message if fetching fails
          } else if (snapshot.hasData) {
            final jokes = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Ram"),
                  Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
                  for (var item in jokes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Title: ${item.title}\nPunchline: ${item.punchline}",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available')); // Show if no data is returned
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
