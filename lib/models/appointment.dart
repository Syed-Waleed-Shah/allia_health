class Appointment {
  final String doctor;
  final String time;
  final String type;
  final String icon;

  Appointment({
    required this.doctor,
    required this.time,
    required this.type,
    required this.icon,
  });

  static Appointment fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctor: json['doctor'],
      time: json['time'],
      type: json['type'],
      icon: json['icon'],
    );
  }
}
