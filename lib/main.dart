import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_demo/models/bank.dart';
import 'package:hive_demo/models/student.dart';
import 'package:hive_demo/models/teacher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'presentation/screens/home/home_view.dart';

const secureStorage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final encryptionKey = await secureStorage.read(key: "hiveKey");
  if(encryptionKey == null){
    final key = Hive.generateSecureKey();
    await secureStorage.write(key: "hiveKey", value: base64Url.encode(key));
  }
  final key = base64Url.decode(encryptionKey.toString());

  final dir = await path.getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path).then((_) async {
      await Hive.openBox('home');


      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter<Student>(StudentAdapter());
        await Hive.openBox<Student>('students');
      }

      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter<Teacher>(TeacherAdapter());
        await Hive.openBox<Teacher>('teachers');
      }

      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter<Bank>(BankAdapter());
        await Hive.openBox<Bank>('banks', encryptionCipher: HiveAesCipher(key));
      }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
