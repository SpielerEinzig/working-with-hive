import 'package:hive/hive.dart';

part "bank_account.g.dart";

@HiveType(typeId: 1)
class BankAccount {
  @HiveField(0)
  String label;

  @HiveField(1)
  String address;

  @HiveField(2)
  String qrCode;

  BankAccount(
      {required this.label, required this.address, required this.qrCode});
}
