import 'package:climato/WeatherTool.dart';
import 'package:climato/screens/location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climato/Location.dart';

const String initial = 'https://api.openweathermap.org/data/2.5/weather';
const String apiKey = 'f25b745350a76e56e8c9257349245223';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getData(Location location) async {
    String surl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=f25b745350a76e56e8c9257349245223&units=metric';

    String builderstrUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=f25b745350a76e56e8c9257349245223&units=metric';

    print(builderstrUrl);
    WeatherTool w1 = WeatherTool(surl);
    dynamic currentData = await w1.getData();

    WeatherTool w2 = WeatherTool(builderstrUrl);
    dynamic builderData = await w2.getData();

    List weatherData = [currentData, builderData];
    //print(location.latitude);
    print(weatherData[0]);

    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LocationPage(
        weatherData: weatherData,
      );
    }));

    SystemNavigator.pop();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    getData(location);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitWave(
          color: Colors.indigo[900],
          size: 100.0,
        ),
        Text(
          'Climato',
          style: TextStyle(
              color: Colors.indigo,
              fontFamily: 'Pacifico',
              fontSize: 60,
              letterSpacing: 4),
        )
      ],
    ));
  }
}
