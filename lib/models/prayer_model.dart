class PrayerModel {
  final String name;
  final String time;
  final DateTime dateTime;

  PrayerModel({
    required this.name,
    required this.time,
    required this.dateTime,
  });

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel(
      name: json['name'],
      time: json['time'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
