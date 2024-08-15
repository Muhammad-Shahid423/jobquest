import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../controllers/exports.dart';
import '../common/drawer/drawer_screen.dart';
import '../common/exports.dart';
import 'auth/profile.dart';
import 'bookmarks/bookmarks.dart';
import 'chat/chatpage.dart';
import 'device_mgt/devices_info.dart';
import 'homepage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, value, child) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(
            indexSetter: (index) {
              value.currentIndex = index;
            },
          ),
          mainScreen: currentScreen(),
          borderRadius: 20,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(kLightBlue.value),
        );
      },
    );
  }

  Widget currentScreen() {
    var zoomNotifierValue = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifierValue.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagement();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}