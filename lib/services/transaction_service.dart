import 'package:assincronismo/helpers/helper_taxes.dart';
import 'package:assincronismo/models/account.dart';
import 'package:assincronismo/services/account_service.dart';

class TransactionService {
  final AccountService _accountService = AccountService();
  void makeTrransaction({
    required String idSender,
    required String idReceiver,
    required double amount,
  }) async {
    List<Account> listAccounts = await _accountService.getAll();

    if (listAccounts.where((acc) => acc.id == idSender).isEmpty) {
      throw Exception("O remetente não existe.");
    }

    Account senderAccount = listAccounts.firstWhere(
      (acc) => acc.id == idSender,
    );

    if (listAccounts.where((acc) => acc.id == idReceiver).isEmpty) {
      throw Exception("O destinarário não existe.");
    }

    Account receiverAccount = listAccounts.firstWhere(
      (acc) => acc.id == idReceiver,
    );

    double taxes = calculateTaxesByAccount(
      sender: senderAccount,
      amount: amount,
    );

    if (senderAccount.balance < amount + taxes) {
      throw Exception("Saldo insuficiente.");
    }

    senderAccount.balance -= (amount + taxes);
    receiverAccount.balance += amount;

    listAccounts[listAccounts.indexWhere((acc) => acc.id == senderAccount.id)] =
        senderAccount;
  }
}
