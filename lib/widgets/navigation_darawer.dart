import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../ui/add_advance_payment.dart';
import '../ui/add_customer.dart';
import '../ui/add_fertilizer.dart';
import '../ui/dashboard/home_screen.dart';
import '../ui/fertilizer_over_view.dart';
import '../ui/summery/summery_home_screen.dart';
import '../ui/supplied_killo.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: SizedBox(
                    child: Image.asset(
                      "assets/images/killos.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomeScreen.routName, (r) => false)
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            singelListTile(HomeScreen.routName, 'Home', Icons.home_outlined),
            singelListTile(AddCustomers.routName, 'AddCustomer',
                Icons.person_add_alt_1_outlined),
            singelListTile(FertilizerOverView.routName, 'Fertilizer List',
                Icons.local_florist_rounded),
            singelListTile(AddFertilizer.routName, 'Add Fertilizer',
                Icons.post_add_rounded),
            singelListTile(SuppliedKillos.routName, 'Supplied Kilos',
                Icons.av_timer_outlined),
            singelListTile(AddAdvancePayments.routName, 'Add Advance Payment',
                Icons.payments_outlined),
            singelListTile(SummeryHomeScreen.routeName, 'Summery',
                Icons.summarize_rounded),
          ],
        ),
      ),
    );
  }

  Widget singelListTile(String routName, String text, IconData iconData) {
    return ListTile(
      leading: Icon(
        iconData,
        color: AppColors.black,
        size: 28,
      ),
      title: Text(text),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(routName);
      },
    );
  }
}
