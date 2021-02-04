import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_suncalc/flutter_suncalc.dart';

void main() {

  bool near(val1, val2, [margin = 1E-15]) {
    return ((val1 - val2).abs() < margin);
  }

  var date = new DateTime.utc(2013, 3, 5);
  var lat = 50.5;
  var lng = 30.5;

  var testTimes = {
    'solarNoon': '2013-03-05T10:10:57Z',
    'nadir': '2013-03-04T22:10:57Z',
    'sunrise': '2013-03-05T04:34:56Z',
    'sunset': '2013-03-05T15:46:57Z',
    'sunriseEnd': '2013-03-05T04:38:19Z',
    'sunsetStart': '2013-03-05T15:43:34Z',
    'dawn': '2013-03-05T04:02:17Z',
    'dusk': '2013-03-05T16:19:36Z',
    'nauticalDawn': '2013-03-05T03:24:31Z',
    'nauticalDusk': '2013-03-05T16:57:22Z',
    'nightEnd': '2013-03-05T02:46:17Z',
    'night': '2013-03-05T17:35:36Z',
    'goldenHourEnd': '2013-03-05T05:19:01Z',
    'goldenHour': '2013-03-05T15:02:52Z'
  };


  test('Duration class exposes static const variables', () {
    expect(Duration.millisecondsPerDay, isA<int>());
    expect(Duration.microsecondsPerMillisecond, 1000);
  });

  test('getTimes returns sun phases in summer in Kiev', () {
    var date = new DateTime.utc(2020, 6, 10);
    var times = SunCalc.getTimes(date, lat, lng);
    
    expect(times["sunrise"].toIso8601String().substring(0,19), "2020-06-10T01:47:58");
    expect(times["sunset"].toIso8601String().substring(0,19), "2020-06-10T18:09:48");
  });

  test('getTimes returns sun phases in summer in Stockholm', () {
    DateTime date = new DateTime.utc(2020, 6, 9);
    const sthlm = { "lat": 59.33538407920466, "lng": 18.03007918439074 };
    // https://www.timeanddate.com/sun/sweden/stockholm?month=6&year=2020
    var times = SunCalc.getTimes(date, sthlm["lat"], sthlm["lng"]);
    
    expect(times["sunrise"].toIso8601String().substring(0,19), "2020-06-09T01:35:47");
    expect(times["sunset"].toIso8601String().substring(0,19), "2020-06-09T20:01:23");
  });

  test('getTimes returns sun phases in summer in Kiruna (midnight sun)', () {
    DateTime date = new DateTime.utc(2020, 7, 1);
    const kiruna = { "lat": 67.8537716, "lng": 20.1163502 };
    // https://www.timeanddate.com/sun/sweden/kiruna?month=7&year=2020 
    var times = SunCalc.getTimes(date, kiruna["lat"], kiruna["lng"]);
    
    expect(times["sunrise"], null);
    expect(times["sunset"], null);

  });


  test('getTimes returns sun phases in summer in Kiruna', () {
    DateTime date = new DateTime.utc(2020, 7, 17);
    const kiruna = { "lat": 67.8537716, "lng": 20.1163502 };
    // https://www.timeanddate.com/sun/sweden/kiruna?month=7&year=2020
    var times = SunCalc.getTimes(date, kiruna["lat"], kiruna["lng"]);

    expect(times["sunrise"].toIso8601String().substring(0,19), "2020-07-16T23:17:03");
    expect(times["sunset"].toIso8601String().substring(0,19), "2020-07-17T22:16:31");
  });


  test('getPosition returns azimuth and altitude for the given time and location', () {
    var sunPos = SunCalc.getPosition(date, lat, lng);

    expect(near(sunPos["azimuth"], -2.5003175907168385), true);
    expect(near(sunPos["altitude"], -0.7000406838781611), true);
  });

  test('getTimes returns sun phases for the given date and location', () {
    var times = SunCalc.getTimes(date, lat, lng);

    testTimes.forEach((key,value) {
      expect(times[key].toIso8601String().substring(0,19) + "Z", value);
    });
  });

  test('getMoonPosition returns moon position data given time and location', () {
    var moonPos = SunCalc.getMoonPosition(date, lat, lng);

    expect(near(moonPos["azimuth"], -0.9783999522438226), true);
    expect(near(moonPos["altitude"], 0.014551482243892251), true);
    expect(near(moonPos["distance"], 364121.37256256194), true);
  });

  test('getMoonIllumination returns fraction and angle of moon illuminated limb and phase', () {
    var moonIllum = SunCalc.getMoonIllumination(date);

    expect(near(moonIllum["fraction"], 0.4848068202456373), true);
    expect(near(moonIllum["phase"], 0.7548368838538762), true);
    expect(near(moonIllum["angle"], 1.67329426785783465), true);
  });

  test('getMoonTimes returns moon rise and set times', () {
    var moonTimes = SunCalc.getMoonTimes(new DateTime.utc(2013, 3, 4), lat, lng, true);

    expect(moonTimes["rise"].toIso8601String().substring(0,19), "2013-03-04T23:54:29");
    expect(moonTimes["set"].toIso8601String().substring(0,19), "2013-03-04T07:47:58");
  });
}
