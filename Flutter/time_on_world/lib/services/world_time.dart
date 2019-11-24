import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // Location for UI
  String time;  // Time on UI
  String flag; // Url to an asset flag icon
  String url; // Location url for AIP endpoint
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{
    try{
      //make request
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3); // take only 2 numbers. Eg +01:00 -> 01

      // create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time
      isDaytime = now.hour >= 6 && now.hour < 20 ? true : false;
      time = DateFormat.Hm().format(now); // convert time to more user friendly time
    }
    catch(e){
      time = "error while gettig time";
      isDaytime = false;
    }    
  }
}