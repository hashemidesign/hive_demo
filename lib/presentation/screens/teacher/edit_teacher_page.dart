import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/teacher.dart';

class EditTeacherView extends StatefulWidget {
  final int index;

  const EditTeacherView({Key? key, required this.index}) : super(key: key);

  @override
  State<EditTeacherView> createState() => _EditTeacherViewState();
}

class _EditTeacherViewState extends State<EditTeacherView> {
  late Box<Teacher> teacherBox;
  final _formKey = GlobalKey<FormState>();
  int? id;
  String? name;
  int? age;
  String? subject;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _subjectController;
  late Teacher? teacher;

  void saveTeacher() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    teacherBox.putAt(
        widget.index,
        Teacher(
          id: id ?? 0,
          name: name ?? "",
          age: age ?? 0,
          subject: subject ?? "",
        ));
  }

  void deleteTeacher() {
    teacherBox.deleteAt(widget.index);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    teacherBox = Hive.box('teachers');
    teacher = teacherBox.getAt(widget.index);

    _idController = TextEditingController(text: teacher!.id.toString());
    _nameController = TextEditingController(text: teacher!.name);
    _ageController = TextEditingController(text: teacher!.age.toString());
    _subjectController = TextEditingController(text: teacher!.subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Teacher"),
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
                    controller: _idController,
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
                    controller: _nameController,
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
                    controller: _ageController,
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
                    controller: _subjectController,
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: saveTeacher,
                        child: const Text("Edit"),
                      ),
                      ElevatedButton(
                        onPressed: deleteTeacher,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Delete"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
