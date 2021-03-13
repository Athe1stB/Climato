import 'dart:convert';
import 'Location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const String initial = 'https://api.openweathermap.org/data/2.5/weather';
const String apiKey = 'f25b745350a76e56e8c9257349245223';

class WeatherTool {
  Uri url;

  WeatherTool(String surl) {
    url = Uri.parse(surl);
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getLocation();
    String surl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=f25b745350a76e56e8c9257349245223&units=metric';
    url = Uri.parse(surl);
    dynamic currentData = await getData();

    String builderstrUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=f25b745350a76e56e8c9257349245223&units=metric';

    url = Uri.parse(builderstrUrl);
    dynamic builderData = await getData();
    List weatherData = [currentData, builderData];
    return weatherData;
  }

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      dynamic weatherData = jsonDecode(data);
      return weatherData;
    } else {
      print('Error');
    }
  }
}
