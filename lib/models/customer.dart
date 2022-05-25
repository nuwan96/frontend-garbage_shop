import 'dart:io';

class Customer {
  final String name;
  final String id;
  final String address;
  final String dateOfBirth;
  final String contact;
  final String accountNumber;
  final String email;
  final File image;
  Customer({
    required this.name,
    required this.id,
    required this.address,
    required this.dateOfBirth,
    required this.contact,
    required this.accountNumber,
    required this.email,
    required this.image,
  });
}
