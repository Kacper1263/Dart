import 'package:flutter/material.dart';
import 'package:time_on_world/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  bool isLoopRunning = false;

  // update time every 5 seconds
  void updateTime() async{
    if(isLoopRunning) return;
    isLoopRunning = true;
    Future.delayed(Duration(seconds: 5),()async{
      WorldTime worldTime = data['instance'];
      await worldTime.getTime();
      setState(() {
        data = {
          'time': worldTime.time,
          'location': worldTime.location,
          'isDaytime': worldTime.isDaytime,
          'flag': worldTime.flag,
          'instance': worldTime
        };
        isLoopRunning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // recived arguments from loading route
    print(data);

    // set backgrount
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    updateTime();
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,120,0,0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async{
                  // Open locations route. If user select location, it will be returned
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag'],
                      'instance': result['instance']
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300],
                ),
                label: Text(
                  "Edit location",
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: Colors.white
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ) 
    );
  }
}