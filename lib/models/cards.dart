import 'package:allia_health/models/card_item.dart';

class Cards {
  final String label;
  final List<CardItem> items;

  Cards({required this.label, required this.items});

  static Cards fromJson(Map<String, dynamic> json) {
    return Cards(
      label: json['label'],
      items: (json['items'] as List)
          .map((item) => CardItem.fromJson(item))
          .toList(),
    );
  }
}
