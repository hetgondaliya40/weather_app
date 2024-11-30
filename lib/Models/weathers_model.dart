class Weather {
  Location location;
  Current current;
  Forecast forecast;

  Weather({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory Weather.formMap({required Map<String, dynamic> data}) {
    return Weather(
        location: Location.formMap(
          data: data['location'],
        ),
        current: Current.formMap(
          data: data['current'],
        ),
        forecast: Forecast.formMap(
          data: data['forecast'],
        ));
  }
}

class Location {
  String name;
  String region;
  String country;
  String tzId;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.tzId,
    required this.localtime,
  });

  factory Location.formMap({required Map<String, dynamic> data}) {
    return Location(
      name: data['name'],
      region: data['region'],
      country: data['country'],
      tzId: data['tz_id'],
      localtime: data['localtime'],
    );
  }
}

class Current {
  double tempC;
  Condition condition;
  double wind_mph;
  num pressure_mb;
  num vis_km;
  int humidity;
  int cloud;
  double feelslike_c;
  double uv;

  Current({
    required this.tempC,
    required this.condition,
    required this.humidity,
    required this.pressure_mb,
    required this.vis_km,
    required this.wind_mph,
    required this.cloud,
    required this.feelslike_c,
    required this.uv,
  });

  factory Current.formMap({required Map<String, dynamic> data}) {
    return Current(
      tempC: data['temp_c'],
      condition: Condition.formMap(
        data: data['condition'],
      ),
      humidity: data['humidity'],
      cloud: data['cloud'],
      pressure_mb: data['pressure_mb'],
      vis_km: data['vis_km'],
      wind_mph: data['wind_mph'],
      feelslike_c: data['feelslike_c'],
      uv: data['uv'],
    );
  }
}

class Condition {
  String text;
  String icon;

  Condition({
    required this.text,
    required this.icon,
  });

  factory Condition.formMap({required Map<String, dynamic> data}) {
    return Condition(
      text: data['text'],
      icon: data['icon'],
    );
  }
}

class HourCondition {
  String text;
  String icon;

  HourCondition({
    required this.text,
    required this.icon,
  });

  factory HourCondition.formMap({required Map<String, dynamic> data}) {
    return HourCondition(
      text: data['text'],
      icon: data['icon'],
    );
  }
}

class Forecast {
  List<ForecastDay> forecastday;

  Forecast({
    required this.forecastday,
  });

  factory Forecast.formMap({required Map<String, dynamic> data}) {
    return Forecast(
      forecastday: List<ForecastDay>.from(
        data['forecastday'].map(
          (e) => ForecastDay.formMap(data: e),
        ),
      ),
    );
  }
}

class ForecastDay {
  Astro astro;
  List<Hour> hour;

  ForecastDay({
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.formMap({required Map<String, dynamic> data}) {
    return ForecastDay(
      astro: Astro.formMap(data: data['astro']),
      hour: List<Hour>.from(
        data['hour'].map(
          (e) => Hour.formMap(data: e),
        ),
      ),
    );
  }
}

class Astro {
  String sunrise;
  String sunset;
  String moon_phase;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moon_phase,
  });

  factory Astro.formMap({required Map<String, dynamic> data}) {
    return Astro(
      sunrise: data['sunrise'],
      sunset: data['sunset'],
      moon_phase: data['moon_phase'],
    );
  }
}

class Hour {
  String time;
  double tempC;
  HourCondition condition;

  Hour({
    required this.time,
    required this.tempC,
    required this.condition,
  });

  factory Hour.formMap({required Map<String, dynamic> data}) {
    return Hour(
      time: data['time'],
      tempC: data['temp_c'],
      condition: HourCondition.formMap(data: data['condition']),
    );
  }
}
