import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

// Taking BuildContext to show SnackBar
Stream getDataStream(BuildContext context) async* {
  int i = 1;
  while (i <= 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Getting new Image $i"),
        duration: const Duration(seconds: 1),
      ),
    );
    http.Response response =
        await http.get(Uri.parse("https://api.catboys.com/img"));

    Map<String, dynamic> map = json.decode(response.body);

    // Return the value received using yield keyword
    yield map['url'] as String;

    // Delay the next yield by 5 seconds
    await Future.delayed(const Duration(seconds: 5));
    i++;
  }
}

Column getImageView(String data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.network(
        data,
        height: 200,
        width: 200,
      ),
      const SizedBox(height: 20),
      Center(child: Text(data)),
    ],
  );
}
