import 'package:flutter/material.dart';

void main() {
  runApp(const BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BankHomePage());
  }
}

class BankHomePage extends StatefulWidget {
  const BankHomePage({super.key});

  @override
  _BankHomePageState createState() => _BankHomePageState();
}

class _BankHomePageState extends State<BankHomePage> {
  final BankAccount myAccount = BankAccount(1000);

  final TextEditingController _amountController = TextEditingController();
  String _transactionMessage = '';

  void _deposit() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    if (amount > 0) {
      myAccount.deposit(amount);
      setState(() {
        _transactionMessage = "Deposited: \$$amount";
      });
    } else {
      setState(() {
        _transactionMessage = "Invalid deposit amount.";
      });
    }
    _amountController.clear();
  }

  void _withdraw() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    if (amount > 0 && amount <= myAccount.balance) {
      myAccount.withdraw(amount);
      setState(() {
        _transactionMessage = "Withdraw: \$$amount";
      });
    } else {
      setState(() {
        _transactionMessage =
            "Invalid withdrawal amount or insufficient balance.";
      });
    }
    _amountController.clear();
  }

  void _checkBalance() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Current balance: \$${myAccount.balance}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bank Account Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter amount'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _deposit,
                  child: const Text('Deposit'),
                ),
                ElevatedButton(
                  onPressed: _withdraw,
                  child: const Text('Withdraw'),
                ),
                ElevatedButton(
                  onPressed: _checkBalance,
                  child: const Text('Check Balance'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _transactionMessage,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class BankAccount {
  double _balance;

  BankAccount(this._balance);

  // Getter for balance
  double get balance => _balance;

  // Method to deposit money into the account
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  // Method to withdraw money from the account
  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
    }
  }
}
