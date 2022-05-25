import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/customer.dart';
import '../../providers/customer_provider.dart';
import '../../ui/add_customer.dart';
import '../../widgets/search_widget.dart';

class CustomerListTab extends StatefulWidget {
  const CustomerListTab({Key? key}) : super(key: key);
  @override
  _CustomerListTabState createState() => _CustomerListTabState();
}

class _CustomerListTabState extends State<CustomerListTab> {
  List<Customer> customerList = [];
  String query = '';
  @override
  void initState() {
    loadcutomerrlistforserac();
    super.initState();
  }

  Future loadcutomerrlistforserac() async {
    final customerList =
        await Provider.of<CustomerProvider>(context, listen: false)
            .fetchCustomerListFormDatabase();
    setState(() {
      this.customerList = customerList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: customerList.length,
              itemBuilder: (context, index) {
                final customer = customerList[index];
                return buildCustomer(customer);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddCustomers.routName);
        },
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Customer Id or Customer Name',
        onChanged: searchCustomer,
      );
  Widget buildCustomer(Customer customer) => ListTile(
        leading: CircleAvatar(backgroundImage: FileImage(customer.image)),
        title: Text(customer.name),
        subtitle: Text(customer.id),
        onTap: () {},
      );
  Future searchCustomer(String query) async {
    final customerList2 =
        await Provider.of<CustomerProvider>(context, listen: false)
            .fetchCustomerListFormDatabase();
    if (!mounted) return;

    final customerList = customerList2.where((customer) {
      final nameLower = customer.name.toLowerCase();
      final idLower = customer.id.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) || idLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.customerList = customerList;
    });
  }
}
