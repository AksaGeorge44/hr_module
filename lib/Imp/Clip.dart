// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// // class CustomClip extends CustomClipper<RRect> {
// //   @override
// //   RRect getClip(Size size) {
// //     // Define the rounded rectangle for clipping
// //     return RRect.fromLTRBR(
// //       10.0,
// //       10.0,
// //       size.width - 10.0,
// //       size.height - 10.0,
// //       Radius.circular(20.0),
// //     );
// //   }
// //
// //   @override
// //   bool shouldReclip(CustomClipper<RRect> oldClipper) {
// //     return false;
// //   }
// // }
// class CustomClip extends CustomClipper<RRect>{
//   @override
//   RRect getClip(Size size)
//   {
//     return RRect.fromLTRBR(left, top, right, bottom, radius)
//   }
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('ClipRRect with Custom Clipper Example'),
//         ),
//         body: Center(
//           child: ClipRRect(
//             clipper: CustomClip(),
//             child: Image.network(
//               'https://example.com/your_image_url.jpg',
//               width: 200.0,
//               height: 200.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
