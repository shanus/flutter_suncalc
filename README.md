# flutter_suncalc

A port of the suncalc library from https://github.com/mourner/suncalc

This code is based on the original Javascript suncalc by Vladimir Agafonkin ("mourner").

## Usage Example

```dart
import 'package:flutter_suncalc/flutter_suncalc.dart';

var date = new DateTime();

// get today's sunlight times for London
var times = SunCalc.getTimes(date, 51.5, -0.1);

// format sunrise time from the Date object
var sunriseStr = times["sunrise"].toLocal();

// get position of the sun (azimuth and altitude) at today's sunrise
var sunrisePos = SunCalc.getPosition(times["sunrise"], 51.5, -0.1);

// get sunrise azimuth in degrees
var sunriseAzimuth = sunrisePos["azimuth"] * 180 / PI;
```
