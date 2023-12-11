import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class HttpExample extends StatefulWidget {
  @override
  _HttpExampleState createState() => _HttpExampleState();
}

class _HttpExampleState extends State<HttpExample> {

     late List listresponse;
     late String  strresponse;
     late Map mapresponse;
     late Map dataresponse;


  @override
  void initState() {
    apicall();
    super.initState();
  }


Future apicall() async {
  http.Response response;
   response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

  if (response.statusCode == 200) {
   setState(() {
    // strresponse=response.body;
     mapresponse=json.decode(response.body);
     listresponse=mapresponse['data'];
   });
  } else {
    throw Exception('Failed to load data');
  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body:ListView.builder(
          itemCount: listresponse.length,
          itemBuilder: (context,index)
      {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(listresponse[index]['avatar']),
            ),
            Text("ID: ${listresponse[index]['id']}"),
            Text("Email: ${listresponse[index]['email'].toString()}"),
            Text("FirstName: ${listresponse[index]['first_name'].toString()}"),
            Text("SecondName: ${listresponse[index]['last_name'].toString()}"),
          ],
        );
      }
      )
    );
  }
}
