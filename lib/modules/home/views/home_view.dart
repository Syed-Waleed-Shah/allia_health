import 'package:allia_health/models/appointment.dart';
import 'package:allia_health/models/card_item.dart';
import 'package:allia_health/models/time_of_day_data.dart';
import 'package:allia_health/modules/home/controllers/home_controller.dart';
import 'package:allia_health/modules/home/widgets/action_card.dart';
import 'package:allia_health/modules/home/widgets/appointment_widget.dart';
import 'package:allia_health/modules/home/widgets/card_widget.dart';
import 'package:allia_health/modules/home/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:allia_health/modules/home/widgets/pending_appointment_widget.dart';
import 'package:allia_health/themes/custom_font_text_theme.dart';
import 'package:allia_health/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Obx(
        () {
          if (controller.data.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          TimeOfDayData current = controller.current.value!;
          Color currentTextColor =
              current.index == 2 ? Colors.white : Colors.black;

          return SingleChildScrollView(
            child: Column(
              children: [
                AnimatedBackgroundImage(
                  current: current,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TableCalendar(
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              calendarFormat: CalendarFormat.week,
                              headerVisible: false,
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
                              calendarStyle: CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                ),
                                markerDecoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                ),
                                defaultDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withAlpha(100),
                                ),
                                weekendDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withAlpha(100),
                                ),
                                todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                ),
                                todayTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                defaultTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: currentTextColor),
                                weekendTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: currentTextColor),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (current.todayAppointments != null) ...[
                              SizedBox(
                                height: 70,
                                child: ListView.separated(
                                  itemCount: current.todayAppointments!.length,
                                  scrollDirection: Axis.horizontal,
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
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'How are you feeling today?',
                              style: Theme.of(context)
                                  .textTheme
                                  .gelica
                                  .titleLarge
                                  ?.copyWith(color: currentTextColor),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 300,
                              child: CustomButton(
                                text: 'Take a Self-Check in',
                                onTap: controller.swithToNextTimeOfDay,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36),
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 10,
                        blurRadius: 20,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (current.showPaymentCard) ...[
                        ActionCard(
                          title: 'Payment Information',
                          subtitle: 'This will help us with claim processing',
                          actionLabel: 'Add Details',
                          iconPath: 'assets/svg/payment.svg',
                        ),
                      ],
                      const SizedBox(height: 20),
                      Text(
                        current.cards.label,
                        style: Theme.of(context).textTheme.gelica.titleLarge,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 16 / 9,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children:
                            List.generate(current.cards.items.length, (index) {
                          CardItem card = current.cards.items[index];
                          return CardWidget(card: card);
                        }),
                      ),
                      if (current.pendingAppointments != null &&
                          current.pendingAppointments!.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Pending Appointments',
                          style: Theme.of(context).textTheme.gelica.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Column(
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
                        style: Theme.of(context).textTheme.gelica.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        spacing: 10,
                        children: [
                          ActionCard(
                            title: 'Record Form',
                            subtitle: 'This will help us lorem ipsum',
                            actionLabel: 'Fill Now',
                            actionLabelColor: Theme.of(context).primaryColor,
                          ),
                          ActionCard(
                            title: 'Personal Information',
                            subtitle: 'This will help us lorem ipsum',
                            actionLabel: 'Fill Now',
                            actionLabelColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    );
  }
}

class AnimatedBackgroundImage extends StatefulWidget {
  const AnimatedBackgroundImage({
    super.key,
    required this.current,
    this.children = const [],
  });

  final TimeOfDayData current;
  final List<Widget> children;

  @override
  State<AnimatedBackgroundImage> createState() =>
      _AnimatedBackgroundImageState();
}

class _AnimatedBackgroundImageState extends State<AnimatedBackgroundImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationTopCloud;
  late Animation<double> _animationCenterCloud;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    )..repeat();

    _animationTopCloud =
        Tween<double>(begin: -220, end: 600).animate(_controller);
    _animationCenterCloud =
        Tween<double>(begin: -220, end: 600).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.asset('assets/images/${widget.current.backgroundImage}'),
        if (widget.current.index != 2)
          AnimatedBuilder(
            animation: _animationTopCloud,
            builder: (context, child) {
              return Positioned(
                top: 0,
                left: _animationTopCloud.value,
                child: Image.asset(
                  'assets/images/cloud1.png',
                  width: 180,
                ),
              );
            },
          ),
        if (widget.current.index != 2)
          AnimatedBuilder(
            animation: _animationCenterCloud,
            builder: (context, child) {
              return Positioned(
                top: 250,
                left: _animationCenterCloud.value,
                child: Image.asset(
                  'assets/images/cloud2.png',
                  width: 200,
                ),
              );
            },
          ),
        if (widget.current.index == 2)
          Lottie.asset(
            'assets/lottie/stars.json',
            height: MediaQuery.sizeOf(context).height / 2,
            width: MediaQuery.sizeOf(context).width,
          ),
        ...widget.children,
      ],
    );
  }
}
