import 'package:allia_health/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    super.key,
    required this.appointment,
  });
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.outline),
        ],
      ),
      child: Row(
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
    
    
    );
  }
}
