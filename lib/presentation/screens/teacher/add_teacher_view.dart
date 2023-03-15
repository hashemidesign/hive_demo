import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/models/teacher.dart';

class AddTeacherView extends StatefulWidget {
  const AddTeacherView({Key? key}) : super(key: key);

  @override
  State<AddTeacherView> createState() => _AddTeacherViewState();
}

class _AddTeacherViewState extends State<AddTeacherView> {
  late Box<Teacher> teacherBox;
  final _formKey = GlobalKey<FormState>();
  int? id;
  String? name;
  int? age;
  String? subject;

  void saveTeacher() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    teacherBox.add(Teacher(
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
    teacherBox = Hive.box('teachers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teacher"),
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
                    onPressed: saveTeacher,
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
