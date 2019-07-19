import './constants.dart';

num toJulian(DateTime date) {
  return date.millisecondsSinceEpoch / dayMs - 0.5 + J1970;
}

DateTime fromJulian(num j) {
  return new DateTime.fromMillisecondsSinceEpoch(((j + 0.5 - 1970) * dayMs).round());
}

num toDays(DateTime date) {
  return toJulian(date) - J2000;
}