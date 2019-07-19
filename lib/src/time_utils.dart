import './constants.dart';
import 'dart:math' as math;

num julianCycle(d, lw) {
  return (d - J0 - lw / (2 * PI)).round();
}

num approxTransit(ht, lw, n) {
  return J0 + (ht + lw) / (2 * PI) + n;
}

num solarTransitJ(ds, M, L) {
  return J2000 + ds + 0.0053 * math.sin(M) - 0.0069 * math.sin(2 * L);
}

num hourAngle(h, phi, d) {
  return math.acos((math.sin(h) - math.sin(phi) * math.sin(d)) / (math.cos(phi) * math.cos(d)));
}

num getSetJ(h, lw, phi, dec, n, M, L) {
  var w = hourAngle(h, phi, dec);
  var a = approxTransit(w, lw, n);

  return solarTransitJ(a, M, L);
}