import 'package:api_uygulamasi/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Second extends StatefulWidget {
  String state;

  Second({Key? key, required this.state}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  var state;

  var uri;
  Future getWeather(url) async {
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = (results['main']['temp'] - 273).toInt();
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    String urlHead = "https://api.openweathermap.org/data/2.5/weather?q=";
    this.state = widget.state;
    String urlTail = "&appid=0648ff6a7845cc74ac9bca3165d5a0e7";
    String totalUrl = urlHead + state + urlTail;
    print(totalUrl.toString());
    uri = Uri.parse(totalUrl.toString());
    super.initState();
    this.getWeather(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 12,
            backgroundColor: Colors.teal,
            title: const Text("Weather App",
                style: TextStyle(color: Colors.white)),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.teal[300],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text("Currently in ${widget.state} ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600))),
                    Text(
                      temp != null ? temp.toString() + "\u00B0C" : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                            currently != null
                                ? currently.toString()
                                : "Loading",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600))),
                  ])),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u00B0C"
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description != null
                          ? description.toString()
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("TemperalHumidtyTree"),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(
                          windSpeed != null ? windSpeed.toString() : "Loading"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
