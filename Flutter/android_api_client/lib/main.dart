// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as prefix0;
import 'dart:io';
import 'package:android_api_client/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:requests/requests.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Client',
      routes: {
        '/home': (context) => APIs(),
        '/loading': (context) => Loading(),
      },
      theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.grey[850],
      ),  
      home: APIs(),
    );
  }
}

class APIsState extends State<APIs> {
  
  final _biggerFont = const TextStyle(fontSize: 18.0);
  TextEditingController ipController = new TextEditingController();
  String htmlResponse = "Loading data...";

  Widget _buildMenu() {
    return 
    Container(
      color: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(height: 20),
          TextField(
            style: TextStyle(
              color: Colors.white
            ),
            controller: ipController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200])),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[600])),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200])),
              hintText: 'Enter IP or URL of API',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          ),
          SizedBox(height: 40),
          OutlineButton(
            child: Text("Get All", style: TextStyle(color: Colors.white)),
            onPressed: () => _api(ipController.text, "GetAll"),
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
          OutlineButton(
            child: Text("Get One", style: TextStyle(color: Colors.white)),
            onPressed: () => _api(ipController.text, "GetOne"),
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
          OutlineButton(
            child: Text("Add One", style: TextStyle(color: Colors.white)),
            onPressed: () => _api(ipController.text, "AddOne"),
            borderSide: BorderSide(color: Colors.grey[400]),
          )
        ],
      ),
    );
  }

  void _api(String _ip, String _request) {
    getApi(_ip);
  }

  void getApi(String _ip) async{
    if(_ip == "" || _ip == null) {
      Fluttertoast.showToast(msg: "You must provide URL of API!", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.red, textColor: Colors.white);
      return;
    }
    Navigator.pushNamed(context, "/loading", arguments: {});
    
    try{
      var r = await Requests.get(_ip);   
      htmlResponse = r.content();
      var json = r.json();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(   // Add 20 lines from here...
          builder: (BuildContext context) {
            return Scaffold(         // Add 6 lines from here...
              backgroundColor: Colors.grey[900],
              appBar: AppBar(
                title: Text('API result'),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(htmlResponse, style: TextStyle(fontSize: 15, color: Colors.white))
                ),
              ),
            );  
          },
        ),    
      );
    } on SocketException catch(e){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(   // Add 20 lines from here...
          builder: (BuildContext context) {
            return Scaffold(         // Add 6 lines from here...
              backgroundColor: Colors.grey[900],
              appBar: AppBar(
                title: Text('API result'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(htmlResponse, style: TextStyle(fontSize: 15, color: Colors.white))
                ),
              ),
            );  
          },
        ),    
      );
      Fluttertoast.showToast(msg: "URL not found", toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.red, textColor: Colors.white);
    }
    catch(e){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(   // Add 20 lines from here...
          builder: (BuildContext context) {
            return Scaffold(         // Add 6 lines from here...
              backgroundColor: Colors.grey[900],
              appBar: AppBar(
                title: Text('API result'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(htmlResponse, style: TextStyle(fontSize: 15, color: Colors.white))
                ),
              ),
            );  
          },
        ),    
      );
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.red, textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Client'),
        centerTitle: true,
      ),
      body: _buildMenu(),
    );
  }
}

class APIs extends StatefulWidget {
  @override
  APIsState createState() => APIsState();
}

