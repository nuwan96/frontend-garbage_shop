import 'dart:io';

class Fertilizer {
  final String name;
  final String type;
  final double unitPrice;
  final double storeAmount;
  final File image;
  Fertilizer({
    required this.name,
    required this.type,
    required this.unitPrice,
    required this.storeAmount,
    required this.image,
  });
}
