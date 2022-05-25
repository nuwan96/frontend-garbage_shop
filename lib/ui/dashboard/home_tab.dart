import 'package:flutter/material.dart';
import '../../ui/add_advance_payment.dart';
import '../../ui/add_customer.dart';
import '../../ui/fertilizer_over_view.dart';
import '../../ui/summery/summery_home_screen.dart';
import '../../ui/supplied_killo.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: GridView(
        padding: const EdgeInsets.all(10),
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => const AddCustomers()));
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/addcustomere.png',
                    height: 165,
                    width: 120,
                  ),
                  const Text("Add A Customer",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => AddAdvancePayments()));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/advance.png',
                    height: 165,
                    width: 120,
                  ),
                  const Text("Advance Payments",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(FertilizerOverView.routName);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fertilizer.png',
                    height: 165,
                    width: 120,
                  ),
                  const Text(
                    "Fertilizer Detail",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SuppliedKillos.routName);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/killos.png',
                    height: 165,
                    width: 120,
                  ),
                  const Text(
                    "Supplied Kilos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(SummeryHomeScreen.routeName);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/summary_report.png',
                    height: 165,
                    width: 120,
                  ),
                  const Text(
                    "Summery",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ],
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),
      ),
    );
  }
}
