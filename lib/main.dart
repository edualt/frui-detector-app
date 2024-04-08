import 'package:face_detector_firebase/widgets/home_bottom_bar_widget.dart';
import 'package:face_detector_firebase/views/image_classification_view.dart';
import 'package:face_detector_firebase/views/info_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit Detector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/home': (context) => const ImageClassificationPage(),
        '/info' : (context) => const InfoView(),
        '/': (context) => const HomeBottomBar(),
      },
    );
  }
}