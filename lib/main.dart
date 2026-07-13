import 'package:api_492/comments_api.dart';
import 'package:api_492/home_page.dart';
import 'package:api_492/post_api.dart';
import 'package:api_492/product_api.dart';
import 'package:api_492/todo_api.dart';
import 'package:flutter/material.dart';

import 'news_api.dart';

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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: NewsApi(),
    );
  }
}

