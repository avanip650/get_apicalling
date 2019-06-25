import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
   //encode the URL
    var response = await http.get(
      Uri.encodeFull(url),
  // only accept json response
      headers: {"Accept":"application/json"}
    );

    print(response.body);

    setState(() {
      var convertDataJson = json.decode(response.body);
      data = convertDataJson['results'];
    });

    return "Success";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GET API Calling'),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context,int index){
        return new Card(
          child: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(data[index]['name'],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                Text(data[index]['skin_color']),
              ],
            ),
            padding: const EdgeInsets.all(20.0),
          ),
        );
      }),
    );
  }
}

