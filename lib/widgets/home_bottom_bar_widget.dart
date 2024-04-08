import 'package:face_detector_firebase/views/image_classification_view.dart';
import 'package:face_detector_firebase/views/info_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _currentTabIndex = 0;

  late List<Widget> screens;
  late ImageClassificationPage classificationView;
  late InfoView infoView;

  @override
  void initState() {
    classificationView = const ImageClassificationPage();
    infoView = const InfoView();
    screens = [classificationView, infoView];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        selectedItemColor: Colors.green,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Poppins',
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info")
        ],
      ),
      body: screens[_currentTabIndex],
    );
  }
}
