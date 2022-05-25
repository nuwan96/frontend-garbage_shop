class PurchedFertilizerCost {
  final String id;
  final String customerId;
  final DateTime date;
  final DateTime time;
  final String ferilizerType;
  final double amount;
  final double price;
  PurchedFertilizerCost(
      {required this.id,
      required this.customerId,
      required this.date,
      required this.time,
      required this.ferilizerType,
      required this.amount,
      required this.price});
}
