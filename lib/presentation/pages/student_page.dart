import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/models/student.dart';
import 'package:hive_demo/presentation/screens/student/add_student_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ValueListenableBuilder(
          valueListenable: studentBox.listenable(),
          builder: (context, box, _){
            return ListView.builder(
                itemCount: studentBox.length,
                itemBuilder: (context, index) {
                  final Student student = studentBox.getAt(index) as Student;
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
              MaterialPageRoute(builder: (_) => const AddStudentView()));
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
