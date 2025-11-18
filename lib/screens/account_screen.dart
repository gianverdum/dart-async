import 'dart:io';

import 'package:assincronismo/models/account.dart';
import 'package:assincronismo/services/account_service.dart';
import 'package:http/http.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((event) {
      print(event);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou C3PO, assistente do Banco d'Ouro");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - 👀Ver todas as suas contas.");
      print("2 - ➕Adicionar nova conta.");
      print("3 - 🚪Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Te vejo na próxima. 👋");
              break;
            }
          default:
            {
              print("Opção inválida. Tente novamente.");
            }
        }
      }
    }
  }

  Future<void> _getAllAccounts() async {
    try {
      List<Account> listAccounts = await _accountService.getAll();
      for (Account account in listAccounts) {
        print(account);
      }
    } on ClientException catch (error, stackTrace) {
      print("Não foi possível alcançar o servidor.");
      print("Tente novamente mais tarde.");
      print("Erro: ${error.message}");
      print("Tipo: ${error.runtimeType}");
      print("stackTrace: $stackTrace");
    } on Exception catch (error, stackTrace) {
      print("Não foi possível recuperar os dados da conta.");
      print("Tente novamente mais tarde.");
      print("Tipo: ${error.runtimeType}");
      print("stackTrace: $stackTrace");
    } finally {
      print("${DateTime.now()} | Ocorreu uma tentativa de consulta.");
    }
  }

  Future<void> _addExampleAccount() async {
    try {
      Account example = Account(
        id: "ID556",
        name: "Ocean",
        lastName: "Digital",
        balance: 255.45,
        accountType: "Brigadeiro",
      );

      await _accountService.addAccount(example);
    } on Exception catch (e) {
      print("Erro ao adicionar $e");
    }
  }
}
