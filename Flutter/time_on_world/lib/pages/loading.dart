import 'package:flutter/material.dart';
import 'package:time_on_world/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {  

  void setupWorldTime() async{
    WorldTime instance = WorldTime(location: "Berlin", flag: "berlin.png", url: "Europe/Berlin");
    await instance.getTime();
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDaytime": instance.isDaytime,
      "instance": instance
    });  //Push and replace
  }

  @override
  void initState() {
    super.initState(); //Run original initState()
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80,
        ),
      )
    );
  }
}