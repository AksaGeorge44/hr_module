// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
//
// // app starting point
//
// // homepage class
// class HttpEg1 extends StatefulWidget {
//   const HttpEg1({super.key});
//
//   @override
//   State<HttpEg1> createState() => _HttpEg1State();
// }
//
// // homepage state
// class _HttpEg1State extends State<HttpEg1> {
//
//   Future<List<Post>> postsFuture = getPosts();
//
//
//
//
//   static Future<List<Post>> getPosts() async {
//     var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
//     final response = await http.get(url, headers: {"Content-Type": "application/json"});
//     final List body = json.decode(response.body);
//     return body.map((e) => Post.fromJson(e)).toList();
//   }
//
//   // build function
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         // FutureBuilder
//         child: FutureBuilder<List<Post>>(
//           future: postsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // until data is fetched, show loader
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               // once data is fetched, display it on screen (call buildPosts())
//               final posts = snapshot.data!;
//               return buildPosts(posts);
//             } else {
//               // if no data, show simple Text
//               return const Text("No data available");
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   // function to display fetched data on screen
//   Widget buildPosts(List<Post> posts) {
//     // ListView Builder to show data in a list
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts[index];
//         return Container(
//           color: Colors.grey.shade300,
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           height: 100,
//          width: double.maxFinite,
//           child: Row(
//             children: [
//               Expanded(flex: 1, child: Image.network(post.url.toString())),
//               SizedBox(width: 10),
//               Expanded(flex: 3, child: Text(post.title!)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
// class Post {
//   int? albumId;
//   int? id;
//   String? title;
//   Uri? url;
//   String? thumbnailUrl;
//
//   Post({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});
//
//   Post.fromJson(Map<String, dynamic> json) {
//     albumId = json['albumId'];
//     id = json['id'];
//     title = json['title'];
//     url = Uri.parse(json['url']);
//     thumbnailUrl = json['thumbnailUrl'];
//   }
// }