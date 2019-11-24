/*
  Project based on youtube tutorial by The Net Ninja
  Tutorial playlist: https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ
*/


import 'package:flutter/material.dart';

import 'package:time_on_world/pages/home.dart';
import 'package:time_on_world/pages/loading.dart';
import 'package:time_on_world/pages/choose_location.dart';

void main() => runApp(MaterialApp(
  title: "Time on world",
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));

