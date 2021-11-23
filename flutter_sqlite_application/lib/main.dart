// main.dart
import 'package:flutter/material.dart';

import 'sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Demo Data',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All movies
  List<Map<String, dynamic>> _movies = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshMovies() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _movies = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshMovies(); // Loading movies when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Data'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_movies[index]['title']),
                    subtitle: Text(_movies[index]['description']),
                    ),
              ),
            )
    );
  }
}
