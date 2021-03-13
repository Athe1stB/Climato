import 'package:climato/WeatherTool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SelectCityPage.dart';
import 'package:climato/utlities/constants.dart';
import 'package:climato/customContainer.dart';
import 'package:intl/intl.dart';

class LocationPage extends StatefulWidget {
  final weatherData;
  LocationPage({this.weatherData});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1);

      return '$firstLetter$remainingLetters';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  String makeDate() {
    String weekDay = DateFormat('EEEE').format(DateTime.now());
    String day = DateFormat('d').format(DateTime.now());
    String month = DateFormat('MMMM').format(DateTime.now());
    String ans = weekDay + ', ' + day + ' ' + month;
    return ans;
  }

  int builderlength;

  String cityName,
      description,
      temperature,
      tfeelsLike,
      pressure,
      country,
      wind,
      humidity,
      date,
      iconURL;

  List dateFromString(String s) {
    //example = "2021-03-10 21:00:00";
    String month = "", day = "", hr = "", mins = "";

    month = s[5] + s[6];
    day = s[8] + s[9];
    hr = s[11] + s[12];
    mins = s[14] + s[15];

    String date = day + '/' + month;
    String time = hr + ':' + mins;
    return [date, time];
  }

  var builderTemp = new List(40);
  var builderDate = new List(40);
  var builderTime = new List(40);
  var builderUrl = new List(40);

  void updateBuilder(dynamic data) {
    setState(() {
      if (data != null) {
        //print(data);
        for (int i = 0; i < 40; i++) {
          builderTemp[i] = data['list'][i]['main']['temp'].round();
          String tempDate = data['list'][i]['dt_txt'];
          List tlist = dateFromString(tempDate);
          builderDate[i] = tlist[0];
          builderTime[i] = tlist[1];
          String code = data['list'][i]['weather'][0]['icon'].toString();
          builderUrl[i] =
              'https://openweathermap.org/img/wn/' + code + '@2x.png';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData[0]);
    updateBuilder(widget.weatherData[1]);
  }

  void updateUI(dynamic data) {
    setState(() {
      double wspeed = data['wind']['speed'] * (18.0 / 5);
      wind = wspeed.toStringAsFixed(2) + ' KM/H';
      country = data['sys']['country'];
      cityName = data['name'].toString();
      temperature = data['main']['temp'].round().toString() + '\u00B0';
      tfeelsLike = data['main']['feels_like'].toString();
      pressure = data['main']['pressure'].toString();
      humidity = data['main']['humidity'].toString();
      String tcode = data['weather'][0]['icon'].toString();
      iconURL =
          'https://openweathermap.org/img/wn/' + tcode.toString() + '@2x.png';
      description = convertToTitleCase(data['weather'][0]['description']);
      date = makeDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () async {
              WeatherTool currentWeather = WeatherTool('none');
              dynamic recData = await currentWeather.getLocation();
              updateUI(recData[0]);
              updateBuilder(recData[1]);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      cityName + ',',
                      style: styleBoldBlack,
                    ),
                    Text(
                      '\t' + country,
                      style: normal,
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xFF417AFD),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(image: NetworkImage(iconURL)),
                    Text(
                      description,
                      style: styleBoldWhite,
                    ),
                    Text(
                      date,
                      style: elementgray,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      temperature,
                      style: styleBoldWhiteLarge,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: newCustomWidget(
                            stringValue: wind,
                            parameter: 'WIND',
                            iconData: CupertinoIcons.wind,
                          ),
                        ),
                        Expanded(
                          child: newCustomWidget(
                            parameter: 'FEELS LIKE',
                            stringValue: tfeelsLike,
                            iconData: Icons.thermostat_outlined,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: newCustomWidget(
                            stringValue: humidity,
                            parameter: 'HUMIDITY',
                            iconData: Icons.waves,
                          ),
                        ),
                        Expanded(
                          child: newCustomWidget(
                            parameter: 'PRESSURE',
                            stringValue: pressure,
                            iconData: CupertinoIcons.waveform_path_ecg,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent',
                    style: styleBoldBlackMedium,
                  ),
                  Text(
                    'Next 5 days >',
                    style: styleBoldGrayMedium,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 40,
                  itemBuilder: (BuildContext context, int pos) {
                    return CustomBuilderCard(
                      tempStatus: builderTemp[pos],
                      time: builderTime[pos],
                      date: builderDate[pos],
                      url: builderUrl[pos],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.purple[900])),
                onPressed: () async {
                  dynamic newData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CityPage()));
                  updateUI(newData[0]);
                  updateBuilder(newData[1]);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.location_city_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  title: Text(
                    'Search a City!',
                    style: styleBoldWhite,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBuilderCard extends StatelessWidget {
  final int tempStatus;
  final String date;
  final String time, url;

  CustomBuilderCard({this.tempStatus, this.date, this.time, this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.lightBlue.shade200,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.purple[900]),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      margin: EdgeInsets.only(right: 16),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(date, style: TextStyle(color: Colors.blue, fontSize: 12)),
            Text(time, style: TextStyle(color: Colors.black38, fontSize: 20)),
            Image(image: NetworkImage(url, scale: 1.3)),
            Text(
              tempStatus.toString() + '\u00B0',
              style: styleDarkGrayBold,
            ),
          ],
        ),
      ),
    );
  }
}
