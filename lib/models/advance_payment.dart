class AdvancePayment {
  final String id;
  final String customerId;
  final DateTime date;
  final DateTime time;
  final double amount;
  final String description;
  AdvancePayment(
      {required this.id,
      required this.customerId,
      required this.date,
      required this.time,
      required this.amount,
      required this.description});
}
