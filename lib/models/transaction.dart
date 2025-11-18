import 'dart:convert';

class Transaction {
  String id;
  String senderAccountId;
  String receiverAccountId;
  DateTime date;
  double amount;
  double taxes;

  Transaction({
    required this.id,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.date,
    required this.amount,
    required this.taxes,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      senderAccountId: map['senderAccountId'] as String,
      receiverAccountId: map['receiverAccountId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as double,
      taxes: map['taxes'] as double,
    );
  }

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "senderAccountId": senderAccountId,
      "receiverAccountId": receiverAccountId,
      "date": date,
      "amount": amount,
      "taxes": taxes,
    };
  }

  String toJson() => jsonEncode(toMap());

  Transaction copyWith({
    String? id,
    String? senderAccountId,
    String? receiverAccountId,
    DateTime? date,
    double? amount,
    double? taxes,
  }) {
    return Transaction(
      id: id ?? this.id,
      senderAccountId: senderAccountId ?? this.senderAccountId,
      receiverAccountId: receiverAccountId ?? this.receiverAccountId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      taxes: taxes ?? this.taxes,
    );
  }

  @override
  String toString() {
    return 'Transação $id\nRemetente $senderAccountId\nDestinatário $receiverAccountId\nData $date\nValor $amount\nTaxa $taxes';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderAccountId.hashCode ^
        receiverAccountId.hashCode ^
        date.hashCode ^
        amount.hashCode ^
        taxes.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.senderAccountId == senderAccountId &&
        other.receiverAccountId == receiverAccountId &&
        other.date == date &&
        other.amount == amount &&
        other.taxes == taxes;
  }
}
