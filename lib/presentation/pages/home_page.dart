import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box homeBox;

  @override
  void initState() {
    super.initState();
    homeBox = Hive.box('home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green,),
    );
  }
}
