import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApp extends StatefulWidget {
  const RestApp({super.key});

  @override
  _RestAppState createState() => _RestAppState();
}

class _RestAppState extends State<RestApp> {

  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST API',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter REST API Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, abc) {
              if (abc.hasData) {
                return Text(abc.data?.title ?? 'No title');
              } else if (abc.hasError) {
                return Text("${abc.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {

    return Post.fromJson(json.decode(response.body));
  } else {

    throw Exception('Failed to load post');
  }
}


class Post {
  final int? userId;
  final int? id;
  final String? title;
  final String? description;

  Post({this.userId, this.id, this.title, this.description});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
