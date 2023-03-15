import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/models/bank.dart';
import 'package:hive_demo/presentation/screens/bank/add_bank_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BankPage extends StatefulWidget {
  const BankPage({Key? key}) : super(key: key);

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late Box<Bank> bankBox;

  @override
  void initState() {
    super.initState();
    bankBox = Hive.box('banks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ValueListenableBuilder(
          valueListenable: bankBox.listenable(),
          builder: (context, box, _) {
            return ListView.builder(
                itemCount: bankBox.length,
                itemBuilder: (context, index) {
                  final Bank bank = bankBox.getAt(index) as Bank;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bank.id.toString()),
                          Text(bank.name),
                          Text(bank.accountNumber.toString()),
                          Text(bank.amount.toString()),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddBankView()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
