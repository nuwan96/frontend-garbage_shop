import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../models/customer.dart';
import '../providers/advance_payment_provider.dart';
import '../providers/customer_provider.dart';
import '../widgets/datetime_picker_widget.dart';
import '../widgets/fertilizer_cost_payment_widget.dart';
import '../widgets/search_widget.dart';

// ignore: must_be_immutable
class AddAdvancePayments extends StatefulWidget {
  static const routName = 'advance-payments';
  late List<Customer> listOfCutomer = [];
  AddAdvancePayments({Key? key}) : super(key: key);
  @override
  _AddAdvancePaymentsState createState() => _AddAdvancePaymentsState();
}

class _AddAdvancePaymentsState extends State<AddAdvancePayments> {
  List<Customer> customerList = [];
  String query = '';
  bool isExpand = false;
  bool isCustomerInitilize = false;
  Customer selectedCusomer = Customer(
      name: 'Test',
      id: "Test",
      address: "Test",
      dateOfBirth: "test",
      contact: "test",
      accountNumber: "test",
      email: "test",
      image: File(''));
//form date//////////////////////////////////////////////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  DateTime selecDateTime = DateTime.now();
  void setSelectedDate(DateTime selecDate) {
    selecDateTime = selecDate;
  }

  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AdvancePaymentProvider>(context, listen: false)
          .AddAdvancePayment(selectedCusomer.id, selecDateTime, selecDateTime,
              double.parse(amount.text), description.text);
    } catch (error) {
      var errorMessage = 'Could not save the data.' + error.toString();
      _showErrorDialog(errorMessage);
    }
    _showSaveSuccessDialog(selecDateTime, double.parse(amount.text).toString(),
        selectedCusomer.id);
    _clear();
    setState(() {
      _isLoading = false;
    });
  }

  void _showSaveSuccessDialog(DateTime dateTime, String amount, String cusId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save Successful'),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.buttonColorDarkGreen,
                      ),
                      Text(DateFormat('MM/yyyy/dd HH:mm').format(dateTime),
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("RS :",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.appBarGradientDarkGreen,
                              fontWeight: FontWeight.bold)),
                      Text(amount,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.account_box,
                        color: AppColors.buttonColorDarkGreen,
                      ),
                      Text(cusId,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  void _clear() async {
    amount.clear();
    description.clear();
    setState(() {});
  }

////////////////////////////////////////////////////////////////////////
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
      appBar: AppBar(
        title: const Text('Add Advance Payment '),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Card(
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: !isCustomerInitilize
                            ? Image.asset('assets/images/propic.png').image
                            : FileImage(selectedCusomer.image),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      !isCustomerInitilize
                          ? const Text(
                              'Name of the customer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(selectedCusomer.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                      !isCustomerInitilize
                          ? const Text('ID',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ))
                          : Text(selectedCusomer.id,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isExpand = !isExpand;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Serach Customer'),
                              Icon(Icons.search),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
            isExpand
                ? Card(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 200,
                      child: Column(
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
                    ),
                  )
                : const SizedBox(),
            Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // DatePickerWidget(selecDateTime,title: 'Select date'),
                        DatetimePickerWidget(
                            dateTime: selecDateTime,
                            setSelectedDate: setSelectedDate),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Value';
                            }
                          },
                          onSaved: (value) {},
                          controller: amount,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          keyboardType: TextInputType.multiline,
                          onSaved: (value) {},
                          controller: description,
                        ),
                        const SizedBox(height: 10),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: _submit,
                                      child: const Text(
                                        'SAVE',
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColors.textFieldMain),
                                      onPressed: _clear,
                                      child: const Text(
                                        'CLEAR',
                                      )),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // ignore: prefer_const_constructors
            FertilizerCostPaymentWidget(
              customerId: selectedCusomer.id,
              date: selecDateTime,
              time: selecDateTime,
            )
          ],
        ),
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
        onTap: () {
          setState(() {
            isCustomerInitilize = true;
            selectedCusomer = customer;
            isExpand = false;
          });
        },
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
