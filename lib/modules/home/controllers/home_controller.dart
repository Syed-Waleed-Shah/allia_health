import 'dart:convert';

import 'package:allia_health/models/appointment.dart';
import 'package:allia_health/models/data.dart';
import 'package:allia_health/models/time_of_day_data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rxn<Data> data = Rxn();
  Rxn<TimeOfDayData> current = Rxn();
  Rx<DateTime> selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadDayData();
  }

  Future<void> loadDayData() async {
    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    data.value = Data.fromJson(jsonMap);
    current.value = data.value?.morning;
  }

  void swithToNextTimeOfDay() {
    int index = current.value!.index == 2 ? 0 : current.value!.index + 1;
    if (index == 0) {
      current.value = data.value?.morning;
    }
    if (index == 1) {
      current.value = data.value?.noon;
    }
    if (index == 2) {
      current.value = data.value?.night;
    }
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
    DateTime now = DateTime.now();
    if (now.day == day.day) {
      loadDayData();
    }
    if (now.day + 1 == day.day) {
      current.value!.showPaymentCard = false;
      current.value!.todayAppointments = [
        Appointment(
          doctor: 'Dr Isabella Thompson',
          time: '5:30 PM - 6:00 PM',
          type: 'telehealth',
          icon: 'phone.svg',
        ),
      ];
    }
    if (day.day > now.day + 1) {
      current.value!.showPaymentCard = false;
      current.value!.todayAppointments = null;
      current.value!.pendingAppointments = null;
    }
    current.refresh();
  }
}
