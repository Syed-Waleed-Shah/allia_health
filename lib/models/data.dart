import 'package:allia_health/models/time_of_day_data.dart';

class Data {
  final TimeOfDayData morning;
  final TimeOfDayData noon;
  final TimeOfDayData night;

  Data({
    required this.morning,
    required this.noon,
    required this.night,
  });

  static Data fromJson(Map<String, dynamic> json) {
    return Data(
      morning: TimeOfDayData.fromJson(json['morning'], 0),
      noon: TimeOfDayData.fromJson(json['noon'], 1),
      night: TimeOfDayData.fromJson(json['night'], 2),
    );
  }
}
