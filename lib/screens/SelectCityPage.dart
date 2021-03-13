import 'package:climato/WeatherTool.dart';
import 'package:climato/utlities/constants.dart';
import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  String city;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2152D1),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Climato',
                style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Pacifico',
                    fontSize: 60,
                    letterSpacing: 4),
              ),
              SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.name,
                style: subHead,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_city,
                    size: 40,
                    color: Colors.blue,
                  ),
                  hintText: 'Enter City Name',
                  contentPadding: EdgeInsets.all(4),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  city = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isVisible = true;
                  });
                  String surl =
                      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=f25b745350a76e56e8c9257349245223&units=metric';
                  String builderstrUrl =
                      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=f25b745350a76e56e8c9257349245223&units=metric';

                  WeatherTool w1 = WeatherTool(surl);
                  dynamic currentData = await w1.getData();

                  WeatherTool w2 = WeatherTool(builderstrUrl);
                  dynamic builderData = await w2.getData();

                  List weatherData = [currentData, builderData];
                  Navigator.pop(context, weatherData);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Search',
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                child: Visibility(
                  child: CircularProgressIndicator(),
                  visible: isVisible,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
