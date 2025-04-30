import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspection_app/for_web/widgets/common_toast_message.dart';
import 'login_page.dart';

class SideNavigationBarScreen extends StatefulWidget {
  const SideNavigationBarScreen({super.key, required this.loginPersonName});

  final String loginPersonName;

  @override
  State<SideNavigationBarScreen> createState() =>
      _SideNavigationBarScreenState();
}

class _SideNavigationBarScreenState extends State<SideNavigationBarScreen> {
  int selectedIndex = 0;
  bool isCollapsed = false;

  final List<String> menuItems = ["Home", "Profile", "Settings", "Logout"];
  final List<IconData> menuIcons = [
    Icons.home,
    Icons.person,
    Icons.settings,
    Icons.logout,
  ];

  Widget getSelectedPage() {
    switch (selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ProfilePage();
      case 2:
        return const SettingsPage();
      case 3:
        return const LogoutPage();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  String getPlatformInfo() {
    if (kIsWeb) {
      return 'Running on Web';
    } else if (Platform.isAndroid) {
      return 'Running on Android';
    } else if (Platform.isIOS) {
      return 'Running on iOS';
    } else if (Platform.isWindows) {
      return 'Running on Windows';
    } else if (Platform.isLinux) {
      return 'Running on Linux';
    } else if (Platform.isMacOS) {
      return 'Running on macOS';
    } else {
      return 'Unknown Platform';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isCollapsed ? 75 : 280,
                  decoration:  BoxDecoration(
                    color: Colors.orange.shade50,
                    boxShadow: [
                      BoxShadow(color: Colors.white, blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isCollapsed
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  'assets/images/logo_png.png',
                                ),
                              ),
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsetsDirectional.only(start: 10,end: 10,top: 15,bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assets/images/logo.jpg',
                                    height: 50,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/profile.png',
                                      ),
                                    ),
                                    Text(
                                      widget.loginPersonName,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      getPlatformInfo(),
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      const Divider(color: Colors.black26),

                      Expanded(
                        child: ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (context, index) {
                            bool isSelected = index == selectedIndex;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(

                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? Colors.orange.shade200
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        menuIcons[index],
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (!isCollapsed)
                                      Text(
                                        menuItems[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Collapse/Expand Button
                      Center(
                        child: IconButton(
                          icon: Icon(
                            isCollapsed
                                ? Icons.arrow_forward_ios
                                : Icons.arrow_back_ios,
                            color: Colors.black26,
                          ),
                          onPressed: () {
                            setState(() {
                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Main Content Area
                Expanded(
                  child: Container(
                    color: Colors.grey.shade100,
                    child: getSelectedPage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.grey),
          const Text('Home Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

// Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.supervised_user_circle_rounded,
            size: 100,
            color: Colors.grey,
          ),
          const Text('Profile Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 100, color: Colors.grey),
          const Text('Setting Page', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

// Logout Page
class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          SnackBarUtils.successMessageBar(context, "Logout Successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Logout Page',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
