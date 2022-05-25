import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import '../providers/supply_killo_provider.dart';
import '../widgets/datetime_picker_widget.dart';
import '../widgets/search_widget.dart';

// ignore: must_be_immutable
class SuppliedKillos extends StatefulWidget {
  static const routName = 'supplied-killos';
  late List<Customer> listOfCutomer = [];
  SuppliedKillos({Key? key}) : super(key: key);
  @override
  _SuppliedKillosState createState() => _SuppliedKillosState();
}

class _SuppliedKillosState extends State<SuppliedKillos> {
  List<Customer> customerList = [];
  String query = '';
  bool isExpand = false;
  bool isCustomerInitilize = false;
  Customer? selectedCusomer;
//form date//////////////////////////////////////////////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  DateTime? selecDateTime;
  void setSelectedDate(DateTime selectedDate) {
    selecDateTime = selectedDate;
  }

  TextEditingController anmountOfKilos = TextEditingController();
  TextEditingController numberOfBages = TextEditingController();
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

  void _showSaveSuccessDialog(DateTime dateTime, String amount, String bag) {
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
                      Text(dateTime.toIso8601String(),
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
                      const Text("KG :",
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
                      const Text("#Of Bages :",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.appBarGradientDarkGreen,
                              fontWeight: FontWeight.bold)),
                      Text(bag,
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

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<SuppliKilloProvider>(context, listen: false)
          .AddSupplieKilos(
              selectedCusomer!.id,
              selecDateTime as DateTime,
              selecDateTime as DateTime,
              double.parse(anmountOfKilos.text),
              double.parse(numberOfBages.text));
    } catch (error) {
      var errorMessage = 'Could not save the data.' + error.toString();
      _showErrorDialog(errorMessage);
    }
    _showSaveSuccessDialog(
        selecDateTime!, anmountOfKilos.text, numberOfBages.text);
    _clear();
    setState(() {
      _isLoading = false;
    });
  }

  void _clear() async {
    anmountOfKilos.clear();
    numberOfBages.clear();
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
        title: const Text('Add Supplied Amount Of Kilos'),
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
                            : FileImage(selectedCusomer!.image),
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
                          : Text(selectedCusomer!.name,
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
                          : Text(selectedCusomer!.id,
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
                          setSelectedDate: setSelectedDate,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Amount Of Kilos'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Value';
                            }
                          },
                          onSaved: (value) {},
                          controller: anmountOfKilos,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Number Of Bages'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Value';
                            }
                          },
                          onSaved: (value) {},
                          controller: numberOfBages,
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
// class DataSearch extends SearchDelegate<Customer> {
//  final Function _selectedCustomer;
//   List<Customer> listOfCustomer;
//   DataSearch(this.listOfCustomer,this._selectedCustomer);
//   final List<Customer> recentCustomer = [];
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.clear))
//     ];
//   }
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ));
//   }
//  late List<Customer> selectedcustomer;
//   @override
//   Widget buildResults(BuildContext context) {
//    selectedcustomer=listOfCustomer.where((element) => element.name==query).toList();
//    _selectedCustomer(selectedcustomer[0]);
//    return SingleChildScrollView(
//      child: Card(
//               elevation: 10,
//               child: Row(
//                 children: <Widget>[
//                   Center(
//                     child: CircleAvatar(
//                       radius: 60,
//                       backgroundImage:FileImage(selectedcustomer[0].image),
//               // Image.asset('assets/images/propic.png').image,0
//                     ),
//                   ),
//                   Column(
//                     children: <Widget>[
//                       Text(selectedcustomer[0].name),
//                       Text(selectedcustomer[0].id),

//                     ],
//                   )
//                 ],
//               ),
//             ),
//    );
//   }
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? listOfCustomer
//         : listOfCustomer
//             .where((element) => element.name.startsWith(query))
//             .toList();
//     return ListView.builder(
//         itemBuilder: (context, index) => ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: FileImage(suggestionList[index].image),
//               ),
//               title:RichText(text: TextSpan(
//                 text: suggestionList[index].name.substring(0,query.length),
//                 style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
//                 children:[
//                   TextSpan(
//                 text: suggestionList[index].name.substring(query.length),
//                 style:const TextStyle(color: Colors.grey),)
//                 ]
//               ),)
//             ),
//             itemCount: suggestionList.length,);
//   }
// }
