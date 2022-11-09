import 'package:flutter/material.dart';
import 'package:zweather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bkgrd.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
            child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: TextStyle(color: black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white,
                  icon: const Icon(
                    Icons.location_city,
                    color: white,
                  ),
                  hintText: 'Enter City Name',
                  hintStyle: TextStyle(
                    color: grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  city = value;
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    city,
                  );
                },
                child: const Text(
                  'Get Weather',
                  style: kGetWaetherTextStyle,
                )),
          ],
        )),
      ),
    );
  }
}
