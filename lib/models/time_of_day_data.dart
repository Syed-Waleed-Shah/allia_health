import 'package:allia_health/models/appointment.dart';
import 'package:allia_health/models/cards.dart';

class TimeOfDayData {
  final String message;
  final bool showPaymentCard;
  final Cards cards;
  final List<Appointment>? todayAppointments;
  final List<Appointment>? pendingAppointments;
  final int index;
  final String backgroundImage;

  TimeOfDayData({
    required this.message,
    required this.showPaymentCard,
    required this.cards,
    this.todayAppointments,
    this.pendingAppointments,
    required this.index,
    required this.backgroundImage,
  });

  static TimeOfDayData fromJson(Map<String, dynamic> json, int index) {
    return TimeOfDayData(
      index: index,
      message: json['message'],
      showPaymentCard: json['showPaymentCard'] ?? false,
      cards: Cards.fromJson(json['cards']),
      backgroundImage: json['backgroundImage'],
      todayAppointments: json['todayAppointments'] != null
          ? (json['todayAppointments'] as List)
              .map((item) => Appointment.fromJson(item))
              .toList()
          : null,
      pendingAppointments: json['pendingAppointments'] != null
          ? (json['pendingAppointments'] as List)
              .map((item) => Appointment.fromJson(item))
              .toList()
          : null,
    );
  }
}
