import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/student.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({Key? key}) : super(key: key);

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  late Box<Student> studentBox;
  final _formKey = GlobalKey<FormState>();
  int? id;
  String? name;
  int? age;
  String? subject;

  void saveStudent() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    studentBox.add(Student(
      id: id ?? 0,
      name: name ?? "",
      age: age ?? 0,
      subject: subject ?? "",
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
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
                      labelText: 'Age',
                      helperText: "Enter your age",
                    ),
                    onSaved: (value) {
                      age = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      helperText: "Enter your subject",
                    ),
                    onSaved: (value) {
                      subject = value;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: saveStudent,
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
