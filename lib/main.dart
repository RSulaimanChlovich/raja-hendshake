import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Activity',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? activity;
  double? price;

  Future<void> _fetchActivity() async {
    final response = await http.get(Uri.parse("https://bored.api.lewagon.com/api/activity"));
    final data = json.decode(response.body);

    setState(() {
      activity = data['activity'];
      price = (data['price'] as num).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Activity')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (activity != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        activity!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text("RM ${price!.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchActivity,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}