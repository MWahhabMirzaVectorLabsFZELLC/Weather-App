import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("London").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.07,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: MediaQuery.sizeOf(context).width * 1,
      decoration: const BoxDecoration(
        color: Colors.black,
        ),
      child: Text(
        _weather?.areaName ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dateTimeInfo() {

    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:m a").format(now),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 60
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "  ${DateFormat("dd.MM.yyyy").format(now)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.15,
          width: MediaQuery.sizeOf(context).width * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 101, 0, 119),
            image: DecorationImage(
              image: NetworkImage(
                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"
              )
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w900
          ),
        ),
      ],
    );
  }
  
  Widget _currentTemp() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.12,
      width: MediaQuery.sizeOf(context).width * 0.35,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 190, 92, 0),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(
        " ${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 70, 128),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} km/h",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)} °C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)} °C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}