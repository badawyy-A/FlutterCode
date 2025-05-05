import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import to access SystemChrome
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/features/home/ui/widgets/add_tourism_button.dart';
import 'package:morshd/features/home/ui/widgets/categories_views.dart';
import 'package:morshd/features/home/ui/widgets/tourism_view.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import 'package:morshd/features/home/side_bar/emergency_assistance.dart';
import 'package:morshd/features/home/chat_gemini/home_page.dart';
import 'package:morshd/features/home/side_bar/user_profile.dart';
import 'package:morshd/features/home/side_bar/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GlobalKey for Scaffold to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? userId;
  String? userName;

  @override
  void initState() {
    super.initState();
    data();
    // Set the status bar color here
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xffCEA16E), // Set your desired color here
      statusBarIconBrightness:
          Brightness.light, // Optional: set status bar icons color
    ));
  }

  void data() async {
    userId = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId);
    userName =
        await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 200, // Set a custom height for the DrawerHeader
              decoration: BoxDecoration(
                color: const Color(0xff342613),
                image: const DecorationImage(
                  image: AssetImage('assets/images/top_image_home.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'KEMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // Drawer items (Profile, Settings, Emergency Services, Logout)
            ..._buildDrawerItems(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
        backgroundColor: const Color(0xffCEA16E),
        child: FaIcon(
          FontAwesomeIcons.robot,
          color: Colors.white,
          size: 20.w,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffCEA16E),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 250.h,
                  decoration: BoxDecoration(
                    color: const Color(0xffCEA16E),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/top_image_home.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'KEMIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Gap(20.h),
            const CategoriesViews(),
            Gap(20.h),
            const TourismView(),
            Gap(20.h),
            const AddTourismButton(),
          ],
        ),
      ),
    );
  }

  // Method to build the drawer items dynamically
  List<Widget> _buildDrawerItems(BuildContext context) {
    return [
      _buildDrawerItem(
        context,
        icon: Icons.account_circle,
        title: 'Profile',
        route: const UserProfile(),
      ),
      _buildDrawerItem(
        context,
        icon: Icons.settings,
        title: 'Settings',
        route: const SettingsPage(),
      ),
      _buildDrawerItem(
        context,
        icon: Icons.emergency,
        title: 'Emergency Services',
        route: const EmergencyServices(),
      ),
      _buildDrawerItem2(
        context,
        icon: Icons.logout,
        title: 'Logout',
        onTap: () async {
          // Clear stored user data
          await AppSharedPref.sharedPrefRemove(key: AppSharedPrefKey.userId);
          await AppSharedPref.sharedPrefRemove(key: AppSharedPrefKey.userName);

          // Navigate to SignInScreen and remove all previous routes
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (Route<dynamic> route) => false, // Remove all previous routes
          );
        },
      )
    ];
  }

  Widget _buildDrawerItem2(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap, // Allow custom action
    );
  }

  // Helper method to create a drawer item
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String title, required Widget route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
    );
  }
}
