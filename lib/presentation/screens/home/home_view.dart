import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/presentation/pages/bank_page.dart';
import 'package:hive_demo/presentation/pages/home_page.dart';
import 'package:hive_demo/presentation/pages/student_page.dart';
import 'package:hive_demo/presentation/pages/teacher_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  final pages = [
    const HomePage(),
    const StudentPage(),
    const TeacherPage(),
    const BankPage(),
  ];

  @override
  void dispose() {
    Hive.box('home').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Demo"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueAccent[100],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (int value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Student',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Teacher',),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Bank',),
        ],
      ),
      body: pages[index],
    );
  }
}
