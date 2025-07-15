import 'package:allia_health/models/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.card,
  });
  final CardItem card;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(card.title),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/guide.svg'),
                    const SizedBox(width: 4),
                    Text(
                      card.type.name.capitalize!,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/${card.image}',
            width: 70,
          ),
        ],
      ),
    );
  }
}
