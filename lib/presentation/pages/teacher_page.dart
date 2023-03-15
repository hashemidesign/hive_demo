import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/teacher.dart';
import '../screens/teacher/add_teacher_view.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  late Box<Teacher> teacherBox;

  @override
  void initState() {
    super.initState();
    teacherBox = Hive.box('teachers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ValueListenableBuilder(
          valueListenable: teacherBox.listenable(),
          builder: (context, box, _){
            return ListView.builder(
                itemCount: teacherBox.length,
                itemBuilder: (context, index) {
                  final Teacher student = teacherBox.getAt(index) as Teacher;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.id.toString()),
                          Text(student.name),
                          Text(student.age.toString()),
                          Text(student.subject),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddTeacherView()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
