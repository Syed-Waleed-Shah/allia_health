import 'package:allia_health/enums/enums.dart';
import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String image;
  final CardType type;
  final Color color;

  CardItem({
    required this.title,
    required this.image,
    required this.type,
    required this.color,
  });

  static CardItem fromJson(Map<String, dynamic> json) {
    return CardItem(
      title: json['title'],
      image: json['image'],
      type: CardType.values.firstWhere((item) => item.name == json['type']),
      color: Color(int.parse(json['color'].replaceFirst('0x', ''), radix: 16)),
    );
  }
}
