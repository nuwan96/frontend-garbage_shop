import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../ui/dashboard/customer_list_tab.dart';
import '../../ui/dashboard/home_tab.dart';
import '../../ui/dashboard/today_tab.dart';
import '../../widgets/navigation_darawer.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 1;
  late ToDayTab toDayTab;
  late CustomerListTab customerListTab;
  late HomeTab homeTab;
  List<Widget> pages = [];
  late Widget currentPage;
  @override
  void initState() {
    customerListTab = const CustomerListTab();
    toDayTab = const ToDayTab();
    homeTab = const HomeTab();
    pages = [toDayTab, homeTab, customerListTab];
    currentPage = homeTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('TEA BUYER',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 15,
        backgroundColor: AppColors.buttonColorDarkGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(1000),
          ),
        ),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(25), child: SizedBox()),
      ),
      drawer: const NavigationDrawer(),
      body: currentPage,
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 30,
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.buttonColorDarkGreen,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize),
            label: 'To Day',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Customer',
          ),
        ]);
  }
}
