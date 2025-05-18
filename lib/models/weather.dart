import 'dart:convert';

// Helper for pretty printing maps in toString (optional)
String prettyPrintMap(Map map) {
  return map.entries.map((e) => '${e.key}: ${e.value}').join(', ');
}

// 1. WeatherForecastResponse (Previously 9th)
class WeatherForecastResponse {
  final String cod;
  final num message; // Can be int or double, num is safer
  final int cnt;
  final List<ForecastListItem> list;
  final City city;

  WeatherForecastResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  WeatherForecastResponse copyWith({
    String? cod,
    num? message,
    int? cnt,
    List<ForecastListItem>? list,
    City? city,
  }) {
    return WeatherForecastResponse(
      cod: cod ?? this.cod,
      message: message ?? this.message,
      cnt: cnt ?? this.cnt,
      list: list ?? this.list,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((x) => x.toMap()).toList(),
      'city': city.toMap(),
    };
  }

  factory WeatherForecastResponse.fromMap(Map<String, dynamic> map) {
    return WeatherForecastResponse(
      cod: map['cod'] as String,
      message: map['message'] as num,
      cnt: map['cnt'] as int,
      list: List<ForecastListItem>.from(
        (map['list'] as List<dynamic>).map<ForecastListItem>(
          (x) => ForecastListItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      city: City.fromMap(map['city'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherForecastResponse.fromJson(String source) =>
      WeatherForecastResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() => 'WeatherForecastResponse(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // For simplicity, not comparing list content deeply here
    return other is WeatherForecastResponse &&
        other.cod == cod &&
        other.message == message &&
        other.cnt == cnt &&
        other.list.length == list.length && // Basic check
        other.city == city;
  }

  @override
  int get hashCode {
    return cod.hashCode ^
        message.hashCode ^
        cnt.hashCode ^
        list.hashCode ^
        city.hashCode;
  }
}

// 2. ForecastListItem (Previously 8th)
class ForecastListItem {
  final DateTime dt;
  final MainInfo main;
  final List<WeatherCondition> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop; // Probability of precipitation
  final SysInfo sys;
  final DateTime dtTxt;

  ForecastListItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  ForecastListItem copyWith({
    DateTime? dt,
    MainInfo? main,
    List<WeatherCondition>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    SysInfo? sys,
    DateTime? dtTxt,
  }) {
    return ForecastListItem(
      dt: dt ?? this.dt,
      main: main ?? this.main,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      wind: wind ?? this.wind,
      visibility: visibility ?? this.visibility,
      pop: pop ?? this.pop,
      sys: sys ?? this.sys,
      dtTxt: dtTxt ?? this.dtTxt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dt': dt.millisecondsSinceEpoch ~/ 1000,
      'main': main.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'clouds': clouds.toMap(),
      'wind': wind.toMap(),
      'visibility': visibility,
      'pop': pop,
      'sys': sys.toMap(),
      'dt_txt':
          "${dtTxt.year}-${dtTxt.month.toString().padLeft(2, '0')}-${dtTxt.day.toString().padLeft(2, '0')} ${dtTxt.hour.toString().padLeft(2, '0')}:${dtTxt.minute.toString().padLeft(2, '0')}:${dtTxt.second.toString().padLeft(2, '0')}",
    };
  }

  factory ForecastListItem.fromMap(Map<String, dynamic> map) {
    return ForecastListItem(
      dt: DateTime.fromMillisecondsSinceEpoch((map['dt'] as int) * 1000),
      main: MainInfo.fromMap(map['main'] as Map<String, dynamic>),
      weather: List<WeatherCondition>.from(
        (map['weather'] as List<dynamic>).map<WeatherCondition>(
          (x) => WeatherCondition.fromMap(x as Map<String, dynamic>),
        ),
      ),
      clouds: Clouds.fromMap(map['clouds'] as Map<String, dynamic>),
      wind: Wind.fromMap(map['wind'] as Map<String, dynamic>),
      visibility: map['visibility'] as int,
      pop: (map['pop'] as num).toDouble(),
      sys: SysInfo.fromMap(map['sys'] as Map<String, dynamic>),
      dtTxt: DateTime.parse(map['dt_txt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastListItem.fromJson(String source) =>
      ForecastListItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForecastListItem(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // For simplicity, not comparing list content deeply here, but you could use ListEquality
    return other is ForecastListItem &&
        other.dt == dt &&
        other.main == main &&
        other.weather.length == weather.length && // Basic check
        other.clouds == clouds &&
        other.wind == wind &&
        other.visibility == visibility &&
        other.pop == pop &&
        other.sys == sys &&
        other.dtTxt == dtTxt;
  }

  @override
  int get hashCode {
    return dt.hashCode ^
        main.hashCode ^
        weather.hashCode ^
        clouds.hashCode ^
        wind.hashCode ^
        visibility.hashCode ^
        pop.hashCode ^
        sys.hashCode ^
        dtTxt.hashCode;
  }
}

// 3. City (Previously 7th)
class City {
  final int id;
  final String name;
  final Coordinates coord;
  final String country;
  final int population;
  final int timezone;
  final DateTime sunrise;
  final DateTime sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  City copyWith({
    int? id,
    String? name,
    Coordinates? coord,
    String? country,
    int? population,
    int? timezone,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      coord: coord ?? this.coord,
      country: country ?? this.country,
      population: population ?? this.population,
      timezone: timezone ?? this.timezone,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toMap(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
      'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as int,
      name: map['name'] as String,
      coord: Coordinates.fromMap(map['coord'] as Map<String, dynamic>),
      country: map['country'] as String,
      population: map['population'] as int,
      timezone: map['timezone'] as int,
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (map['sunrise'] as int) * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        (map['sunset'] as int) * 1000,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City &&
        other.id == id &&
        other.name == name &&
        other.coord == coord &&
        other.country == country &&
        other.population == population &&
        other.timezone == timezone &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        country.hashCode ^
        population.hashCode ^
        timezone.hashCode ^
        sunrise.hashCode ^
        sunset.hashCode;
  }
}

// 4. SysInfo (Previously 6th)
class SysInfo {
  final String pod; // Part of day (d = day, n = night)

  SysInfo({required this.pod});

  SysInfo copyWith({String? pod}) {
    return SysInfo(pod: pod ?? this.pod);
  }

  Map<String, dynamic> toMap() {
    return {'pod': pod};
  }

  factory SysInfo.fromMap(Map<String, dynamic> map) {
    return SysInfo(pod: map['pod'] as String);
  }

  String toJson() => json.encode(toMap());

  factory SysInfo.fromJson(String source) =>
      SysInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SysInfo(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SysInfo && other.pod == pod;
  }

  @override
  int get hashCode => pod.hashCode;
}

// 5. Wind (Previously 5th)
class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  Wind copyWith({double? speed, int? deg, double? gust}) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  Map<String, dynamic> toMap() {
    return {'speed': speed, 'deg': deg, 'gust': gust};
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: (map['speed'] as num).toDouble(),
      deg: map['deg'] as int,
      gust: (map['gust'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wind.fromJson(String source) =>
      Wind.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Wind(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wind &&
        other.speed == speed &&
        other.deg == deg &&
        other.gust == gust;
  }

  @override
  int get hashCode => speed.hashCode ^ deg.hashCode ^ gust.hashCode;
}

// 6. Clouds (Previously 4th)
class Clouds {
  final int all;

  Clouds({required this.all});

  Clouds copyWith({int? all}) {
    return Clouds(all: all ?? this.all);
  }

  Map<String, dynamic> toMap() {
    return {'all': all};
  }

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(all: map['all'] as int);
  }

  String toJson() => json.encode(toMap());

  factory Clouds.fromJson(String source) =>
      Clouds.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Clouds(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Clouds && other.all == all;
  }

  @override
  int get hashCode => all.hashCode;
}

// 7. WeatherCondition (Previously 3rd)
class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  WeatherCondition copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherCondition(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'main': main, 'description': description, 'icon': icon};
  }

  factory WeatherCondition.fromMap(Map<String, dynamic> map) {
    return WeatherCondition(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherCondition.fromJson(String source) =>
      WeatherCondition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherCondition(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherCondition &&
        other.id == id &&
        other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode;
  }
}

// 8. MainInfo (Previously 2nd)
class MainInfo {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainInfo({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  MainInfo copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) {
    return MainInfo(
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      seaLevel: seaLevel ?? this.seaLevel,
      grndLevel: grndLevel ?? this.grndLevel,
      humidity: humidity ?? this.humidity,
      tempKf: tempKf ?? this.tempKf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }

  factory MainInfo.fromMap(Map<String, dynamic> map) {
    return MainInfo(
      temp: (map['temp'] as num).toDouble(),
      feelsLike: (map['feels_like'] as num).toDouble(),
      tempMin: (map['temp_min'] as num).toDouble(),
      tempMax: (map['temp_max'] as num).toDouble(),
      pressure: map['pressure'] as int,
      seaLevel: map['sea_level'] as int,
      grndLevel: map['grnd_level'] as int,
      humidity: map['humidity'] as int,
      tempKf: (map['temp_kf'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MainInfo.fromJson(String source) =>
      MainInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MainInfo(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainInfo &&
        other.temp == temp &&
        other.feelsLike == feelsLike &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.pressure == pressure &&
        other.seaLevel == seaLevel &&
        other.grndLevel == grndLevel &&
        other.humidity == humidity &&
        other.tempKf == tempKf;
  }

  @override
  int get hashCode {
    return temp.hashCode ^
        feelsLike.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        pressure.hashCode ^
        seaLevel.hashCode ^
        grndLevel.hashCode ^
        humidity.hashCode ^
        tempKf.hashCode;
  }
}

// 9. Coordinates (Previously 1st)
class Coordinates {
  final double lat;
  final double lon;

  Coordinates({required this.lat, required this.lon});

  Coordinates copyWith({double? lat, double? lon}) {
    return Coordinates(lat: lat ?? this.lat, lon: lon ?? this.lon);
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lon': lon};
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinates.fromJson(String source) =>
      Coordinates.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Coordinates(${prettyPrintMap(toMap())})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinates && other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
