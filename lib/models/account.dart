import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;
  String? accountType;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
    required this.accountType,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      balance: (map['balance'] as num).toDouble(),
      accountType: (map['accountType'] != null) ? map['accountType'] as String : null,
    );
  }

  factory Account.fromJson(String source) =>
      Account.fromMap(jsonDecode(source));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
      "accountType": accountType,
    };
  }

  String toJson() => jsonEncode(toMap());

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
    String? accountType,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  String toString() {
    return 'Conta $id\n$name $lastName\nSaldo: $balance\n,';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        balance.hashCode ^
        accountType.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance &&
        other.accountType == accountType;
  }
}
