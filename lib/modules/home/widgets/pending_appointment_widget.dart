import 'package:allia_health/models/appointment.dart';
import 'package:allia_health/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PendingAppointmentWidget extends StatelessWidget {
  const PendingAppointmentWidget({
    super.key,
    required this.appointment,
  });
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(100)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.outline),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svg/${appointment.icon}'),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(appointment.doctor), Text(appointment.time)],
              ),
              const SizedBox(width: 6),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  appointment.type,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Reject',
                  icon: Icon(Icons.close),
                  textColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  borderColor:
                      Theme.of(context).colorScheme.outline.withAlpha(200),
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  text: 'Accept',
                  icon: Icon(
                    Icons.done,
                    color: Theme.of(context).primaryColor,
                  ),
                  textColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.transparent,
                  borderColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
