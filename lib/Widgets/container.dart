import 'dart:ui';

import 'package:flutter/material.dart';

class ContPage extends StatefulWidget {
  const ContPage({super.key});

  @override
  State<ContPage> createState() => _ContPageState();
}

class _ContPageState extends State<ContPage> {

  EdgeInsets initialpadding=const EdgeInsets.all(10);
  EdgeInsets finalpadding=const EdgeInsets.all(30);

  BoxBorder initialborder =const Border.symmetric();
  BoxBorder finalborder =const Border.symmetric();

  ViewPadding viewPadding= ViewPadding.zero;

  Alignment initialalignment=Alignment.centerLeft;
  Alignment finalalignment=Alignment.centerLeft;

  Offset a=const Offset(0.5, 0.5);
  Offset b=const Offset(1.5, 1.5);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("app"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.lerp(initialpadding, finalpadding, 0.5),
              alignment: Alignment.lerp(initialalignment, finalalignment, 0.5),
              foregroundDecoration: BoxDecoration(
                color: Colors.indigoAccent
              ),
              child: const Text("hello"),
            ),

            Container(
              height: 50,
              width: 50,
              color: Colors.indigo[40],
              margin: EdgeInsetsGeometry.lerp(initialpadding, finalpadding, 1.0),
            ),


            Container(
              height: 50,
              width: 50,
              color: Colors.indigo,
              transform: Matrix4.rotationX(0.5),
              
              transformAlignment: AlignmentGeometry.lerp(initialalignment, finalalignment, 1.5),
              child: Text("hello"),
            ),

        Container(
          child: Text("print"),
          clipBehavior: Clip.none,
        ),

            Container(
              margin: EdgeInsets.fromViewPadding(viewPadding, 30),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(
                minWidth :1.0,
                 maxWidth : double.infinity,
                minHeight : 2.0,
                maxHeight :double.infinity,


              ),
              child: const Text("hello"),
            ),
        
            Container(
              height: 50,
              width: 50,
              child: const Text("hello"),

                decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/img.png")),
                border: Border.all(width: 50,),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                 BoxShadow(
                 color: Colors.black,
                 offset: Offset.lerp(a, b, 1.5)!
               )],
                color: Colors.blue,
              ),
            ),
            ClipOval(
              clipBehavior: Clip.none,
              child: Container(
                child: Text("Data"),
              ),
            )

          ],
        ),
      ),

    );
  }
}
