import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/teacher.dart';
import '../screens/teacher/add_teacher_view.dart';
import '../screens/teacher/edit_teacher_page.dart';

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
          builder: (context, box, _) {
            return ListView.builder(
                itemCount: teacherBox.length,
                itemBuilder: (context, int index) {
                  final Teacher teacher = teacherBox.getAt(index) as Teacher;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditTeacherView(
                                  index: index,
                                )),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(teacher.id.toString()),
                            Text(teacher.name),
                            Text(teacher.age.toString()),
                            Text(teacher.subject),
                          ],
                        ),
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
