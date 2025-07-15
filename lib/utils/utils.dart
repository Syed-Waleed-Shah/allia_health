import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color getAppointmentTypeColor(String appointmentType) {
  int alpha = 100;
  switch (appointmentType) {
    case 'Telehealth':
      return Colors.greenAccent.withAlpha(alpha);
    case 'Onsite':
      return Theme.of(Get.context!).primaryColor.withAlpha(alpha);
    default:
      return Theme.of(Get.context!).primaryColor.withAlpha(alpha);
  }
}
