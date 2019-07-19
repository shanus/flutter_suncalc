import './constants.dart';
import './position_utils.dart';
import 'dart:math' as math;

num solarMeanAnomaly(num d) {
  return RAD * (357.5291 + 0.98560028 * d);
}

num equationOfCenter(num M) {
  var firstFactor = 1.9148 * math.sin(M);
  var secondFactor = 0.02 * math.sin(2 * M);
  var thirdFactor = 0.0003 * math.sin(3 * M);

  return RAD * (firstFactor + secondFactor + thirdFactor);
}

num eclipticLongitude(num M) {
  var C = equationOfCenter(M);
  var P = RAD * 102.9372; // perihelion of the Earth

  return M + C + P + PI;
}

Map<String,num> sunCoords(num d) {
  var M = solarMeanAnomaly(d);
  var L = eclipticLongitude(M);

  return {
    "dec": declination(L, 0),
    "ra": rightAscension(L, 0)
  };
}