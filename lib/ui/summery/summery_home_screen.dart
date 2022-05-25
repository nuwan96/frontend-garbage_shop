import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/advance_payment.dart';
import '../../models/customer.dart';
import '../../models/purches_fertilizer_cost.dart';
import '../../models/suppli_tea.dart';
import '../../providers/advance_payment_provider.dart';
import '../../providers/purches_fertilizer_cost_provider.dart';
import '../../providers/selected_customer_provider.dart';
import '../../providers/supply_killo_provider.dart';
import '../../ui/summery/advance_payment_tab.dart';
import '../../ui/summery/fertilizer_payment_tab.dart';
import '../../ui/summery/supplied_kilos_tab.dart';
import '../../widgets/customer_selection_widget.dart';
import '../../widgets/navigation_darawer.dart';

class SummeryHomeScreen extends StatefulWidget {
  static const routeName = '/summery-home-screen';
  const SummeryHomeScreen({Key? key}) : super(key: key);

  @override
  _SummeryHomeScreenState createState() => _SummeryHomeScreenState();
}

class _SummeryHomeScreenState extends State<SummeryHomeScreen> {
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    Customer selectedCustomer =
        Provider.of<SelectedCustomerProvider>(context).selectedCustomerGetter;
    Provider.of<AdvancePaymentProvider>(context)
        .fetchAdvancePaymentForPaticulaerCuetomer(selectedCustomer.id);
    Provider.of<PurchesFertilzerCostProvider>(context)
        .fetchPurchedFertilizerCostForSpecificCustomer(selectedCustomer.id);
    Provider.of<SuppliKilloProvider>(context)
        .fetchSupplyKiloForSpecificCustomer(selectedCustomer.id);
    List<AdvancePayment> list = Provider.of<AdvancePaymentProvider>(context)
        .advancePaymentListForPartiluclarCustomer;
    List<PurchedFertilizerCost> list2 =
        Provider.of<PurchesFertilzerCostProvider>(context)
            .purchedFertilizerCostForSelectedCustomer;
    List<SuppliTea> list3 = Provider.of<SuppliKilloProvider>(context)
        .suppliKiloListForSepcificCustomer;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Summery',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 15,
          backgroundColor: AppColors.buttonColorDarkGreen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: SizedBox(height: 125, child: CustomerSelectionWidget()),
          ),
        ),
        drawer: const NavigationDrawer(),
        body: _tabScreenWidget(list, list2, list3));
  }

  Widget _tabScreenWidget(List<AdvancePayment> list,
      List<PurchedFertilizerCost> list2, List<SuppliTea> list3) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            child: TabBar(
              onTap: (value) => {FocusScope.of(context).unfocus()},
              isScrollable: true,
              labelColor: AppColors.primaryButtonColor,
              unselectedLabelColor: Colors.black,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 3.0, color: AppColors.primaryButtonColor),
                  insets: EdgeInsets.symmetric(horizontal: 15.0)),
              labelStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: "Supplied Kilos"),
                Tab(text: "Fertilizer Purchesed"),
                Tab(text: "Advance Payments"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: TabBarView(
                children: [
                  SuppliedKilosTab(suppledKilos: list3),
                  FertilizerPaymentTab(purchesfertilizercost: list2),
                  AdvancePaymentTab(advancepaymentList: list),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
