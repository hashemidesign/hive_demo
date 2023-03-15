import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/models/bank.dart';

class AddBankView extends StatefulWidget {
  const AddBankView({Key? key}) : super(key: key);

  @override
  State<AddBankView> createState() => _AddBankViewState();
}

class _AddBankViewState extends State<AddBankView> {
  late Box<Bank> bankBox;
  final _formKey = GlobalKey<FormState>();
  int? id;
  String? name;
  int? accountNumber;
  double? amount;

  void saveBank() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    bankBox.add(Bank(
      id: id ?? 0,
      name: name ?? "",
      accountNumber: accountNumber ?? 0,
      amount: amount ?? 0.0,
    ));
  }

  @override
  void initState() {
    super.initState();
    bankBox = Hive.box('banks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bank Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Id',
                      helperText: "Enter your id",
                    ),
                    onSaved: (value) {
                      id = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      helperText: "Enter your name",
                    ),
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Account Number',
                      helperText: "Enter account number",
                    ),
                    onSaved: (value) {
                      accountNumber = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      helperText: "Enter the amount",
                    ),
                    onSaved: (value) {
                      amount = double.parse(value.toString());
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: saveBank,
                    child: const Text("Save"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
