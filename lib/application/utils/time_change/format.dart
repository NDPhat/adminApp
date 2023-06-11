import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatDateView = DateFormat("yyyy-MM-dd");
final formatDateInput = DateFormat("yyyy-MM-dd");
final formatTimeInput = DateFormat('HH:mm ');

double convertTimeDayToDouble(TimeOfDay myTime) =>
    myTime.hour + myTime.minute / 60.0;

TimeOfDay convertToTimeOfDay(String timeDayString) {
  int hour = int.parse(timeDayString.split(":")[0]);
  int minute = int.parse(timeDayString.split(":")[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

String convertToDate(String timeDayString) {
  final f = DateFormat('yyyy-MM-dd');
  return f.format(DateTime.tryParse(timeDayString)!);
}
