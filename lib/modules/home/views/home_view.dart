import 'package:allia_health/models/appointment.dart';
import 'package:allia_health/models/card_item.dart';
import 'package:allia_health/models/time_of_day_data.dart';
import 'package:allia_health/modules/home/controllers/home_controller.dart';
import 'package:allia_health/modules/home/widgets/action_card.dart';
import 'package:allia_health/modules/home/widgets/animated_background_image.dart';
import 'package:allia_health/modules/home/widgets/appointment_widget.dart';
import 'package:allia_health/modules/home/widgets/card_widget.dart';
import 'package:allia_health/modules/home/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:allia_health/modules/home/widgets/pending_appointment_widget.dart';
import 'package:allia_health/themes/custom_font_text_theme.dart';
import 'package:allia_health/widgets/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Obx(() {
      if (controller.data.value == null) {
        return Scaffold(
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      TimeOfDayData current = controller.current.value!;
      Color currentTextColor = current.index == 2 ? Colors.white : Colors.black;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              current.index == 2 ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedBackgroundImage(
                  current: current,
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TableCalendar(
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: controller.selectedDay.value,
                              currentDay: controller.selectedDay.value,
                              calendarFormat: CalendarFormat.week,
                              headerVisible: false,
                              rowHeight: 60,
                              onDaySelected: (selectedDay, focusedDay) {
                                controller.selectDay(selectedDay);
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  DateTime now = DateTime.now();
                                  return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          now.day == day.day
                                              ? DottedBorder(
                                                  padding: EdgeInsets.zero,
                                                  borderType: BorderType.Circle,
                                                  dashPattern: [4, 4],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Container(
                                                    height: 36,
                                                    width: 36,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        day.day.toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 36,
                                                  width: 36,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor
                                                        .withAlpha(100),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      day.day.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      if (day.day == now.day ||
                                          day.day == now.day + 1)
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                    ],
                                  );
                                },
                                todayBuilder: (context, day, focusedDay) {
                                  DateTime now = DateTime.now();
                                  return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            child: Center(
                                              child: Text(
                                                day.day.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (day.day == now.day ||
                                          day.day == now.day + 1)
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                    ],
                                  );
                                },
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: currentTextColor,
                                    ),
                                weekendStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: currentTextColor,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (current.todayAppointments != null) ...[
                            SizedBox(
                              height: 70,
                              child: ListView.separated(
                                itemCount: current.todayAppointments!.length,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                itemBuilder: (_, index) {
                                  return AppointmentWidget(
                                    appointment:
                                        current.todayAppointments![index],
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return const SizedBox(width: 10);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                          Text(
                            current.message,
                            style: Theme.of(context)
                                .textTheme
                                .lato
                                .bodyMedium
                                ?.copyWith(
                                  color: currentTextColor,
                                ),
                          )..animate().slide(),
                          const SizedBox(height: 10),
                          Text(
                            'How are you feeling today?',
                            style: Theme.of(context)
                                .textTheme
                                .gelica
                                .titleLarge
                                ?.copyWith(color: currentTextColor),
                          )..animate().slide(),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 300,
                            child: CustomButton(
                              text: 'Take a Self-Check in',
                              onTap: controller.swithToNextTimeOfDay,
                            )..animate().slide(),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            key: UniqueKey(),
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(36),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                  color: current.index == 2
                                      ? Colors.black26
                                      : Colors.grey.shade300,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (current.showPaymentCard) ...[
                                  ActionCard(
                                    title: 'Payment Information',
                                    subtitle:
                                        'This will help us with claim processing',
                                    actionLabel: 'Add Details',
                                    iconPath: 'assets/svg/payment.svg',
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                Text(
                                  current.cards.label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .gelica
                                      .titleLarge,
                                ).animate().slide(),
                                const SizedBox(height: 10),
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 10,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  children: List.generate(
                                      current.cards.items.length, (index) {
                                    CardItem card = current.cards.items[index];
                                    return CardWidget(card: card);
                                  }),
                                ),
                                if (current.pendingAppointments != null &&
                                    current
                                        .pendingAppointments!.isNotEmpty) ...[
                                  const SizedBox(height: 20),
                                  Text(
                                    'Pending Appointments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .gelica
                                        .titleLarge,
                                  ).animate().slide(),
                                  const SizedBox(height: 10),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 10,
                                    children: List.generate(
                                      current.pendingAppointments!.length,
                                      (index) {
                                        Appointment appointment =
                                            current.pendingAppointments![index];
                                        return PendingAppointmentWidget(
                                          appointment: appointment,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 20),
                                Text(
                                  'Pending Forms',
                                  style: Theme.of(context)
                                      .textTheme
                                      .gelica
                                      .titleLarge,
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: [
                                    ActionCard(
                                      title: 'Record Form',
                                      subtitle: 'This will help us lorem ipsum',
                                      actionLabel: 'Fill Now',
                                      actionLabelColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    ActionCard(
                                      title: 'Personal Information',
                                      subtitle: 'This will help us lorem ipsum',
                                      actionLabel: 'Fill Now',
                                      actionLabelColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ).animate().moveY(
                              curve: Curves.easeInCirc,
                              delay: Duration(milliseconds: 500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBottomNavigationBarItem(
                  asset: 'assets/svg/home.svg',
                  label: 'Home',
                  isActive: true,
                ),
                CustomBottomNavigationBarItem(
                  asset: 'assets/svg/chat.svg',
                  label: 'Chat',
                ),
                CustomBottomNavigationBarItem(
                  asset: 'assets/svg/track.svg',
                  label: 'Track',
                ),
                CustomBottomNavigationBarItem(
                  asset: 'assets/svg/profile.svg',
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
