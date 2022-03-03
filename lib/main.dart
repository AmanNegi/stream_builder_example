import 'package:flutter/material.dart';
import 'package:stream_builder_example/stream_builder_example.dart';
import 'package:stream_builder_example/traditional_stream_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TraditionalStreamExample(),
    );
  }
}
