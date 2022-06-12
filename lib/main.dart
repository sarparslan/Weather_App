import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

import 'secondscreen.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  static var stateValue;

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
  }

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.teal,
            title: Text("Weather App", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SelectState(
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          Container(
            width: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(90.0)),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Second(
                                state: stateValue,
                              )));
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
