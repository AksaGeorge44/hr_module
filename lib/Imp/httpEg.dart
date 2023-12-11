import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpEgApp extends StatefulWidget {
  const HttpEgApp({Key? key}) : super(key: key);

  @override
  _HttpEgAppState createState() => _HttpEgAppState();
}

class _HttpEgAppState extends State<HttpEgApp> {

  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];

      List<Post> posts = data.map((item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Post>>(
                  future: posts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Post post = snapshot.data![index];

                          return ListTile(
                            title: Text(post.email),
                            subtitle: Text('${post.firstName} ${post.lastName}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(post.avatar),
                            ),
                            // Add more information as needed
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final updatedPost = Post(
                      lastName: 'george',
                      id: 7,
                      avatar: 'https://example.com/updated-avatar.jpg',
                      firstName: 'aksa',
                      email: 'aksa@example.com',
                    );

                    await updatePost(1, updatedPost);

                    setState(() {
                      posts = fetchPosts();
                    });
                  } catch (e) {
                    print('Error updating post: $e');
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  Post({
    required this.lastName,
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.email,
  });

  String lastName;
  int id;
  String avatar;
  String firstName;
  String email;

  factory Post.fromJson(Map<dynamic, dynamic> json) => Post(
    lastName: json["last_name"],
    id: json["id"],
    avatar: json["avatar"],
    firstName: json["first_name"],
    email: json["email"],
  );

  Map<dynamic, dynamic> toJson() => {
    "last_name": lastName,
    "id": id,
    "avatar": avatar,
    "first_name": firstName,
    "email": email,
  };
}

Future<void> updatePost(int postId, Post updatedPost) async {
  final response = await http.put(
    Uri.parse('https://reqres.in/api/users/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedPost.toJson()),
  );

  if (response.statusCode == 200) {
    print('Post updated successfully');
  } else {
    throw Exception('Failed to update post');
  }
}


Future<void> createPost(Post newPost) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(newPost.toJson()),
  );

  if (response.statusCode == 201) {
    print('Post created successfully');
  } else {
    throw Exception('Failed to create post');
  }
}

Future<void> deletePost(int postId) async {
  final response = await http.delete(
    Uri.parse('https://reqres.in/api/users/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 204) {
    print('Post deleted successfully');
  } else {
    throw Exception('Failed to delete post');
  }
}
