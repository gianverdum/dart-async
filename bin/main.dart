import 'package:assincronismo/screens/account_screen.dart';
import 'package:assincronismo/services/transaction_service.dart';

void main() {
  // AccountScreen accountScreen = AccountScreen();
  // accountScreen.initializeStream();
  // accountScreen.runChatBot();

  TransactionService().makeTrransaction(
    idSender: "ID001",
    idReceiver: "ID002",
    amount: 5001,
  );
}
