import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import '../providers/selected_customer_provider.dart';

class CustomerSelectionWidget extends StatefulWidget {
  const CustomerSelectionWidget({Key? key}) : super(key: key);
  @override
  _CustomerSelectionWidgetState createState() =>
      _CustomerSelectionWidgetState();
}

class _CustomerSelectionWidgetState extends State<CustomerSelectionWidget> {
  List<Customer> customerList = [];
  // String query = '';
  // bool isExpand = false;
  // bool isCustomerInitilize = false;
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
    Customer selectedCusomer =
        Provider.of<SelectedCustomerProvider>(context).selectedCustomerGetter;
    return Column(children: [
      // !isExpand
      //     ?

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
                  backgroundImage:
                      selectedCusomer.name == 'Name of the customer'

                          // !isCustomerInitilize
                          ? Image.asset('assets/images/propic.png').image
                          : FileImage(selectedCusomer.image),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // !isCustomerInitilize
                //     ? const Text(
                //         'Name of the customer',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       )
                //     :
                Text(selectedCusomer.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                // !isCustomerInitilize
                //     ? const Text('ID',
                //         style: TextStyle(
                //           fontSize: 12,
                //           color: Colors.grey,
                //         ))
                //     :

                Text(selectedCusomer.id,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    )),
                ElevatedButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: DataSearch(customerList));
                      // setState(() {
                      //   isExpand = !isExpand;
                      // });
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
      )
      // : Card(
      //     child: Container(
      //       margin: const EdgeInsets.all(10),
      //       height: 200,
      //       child: Column(
      //         children: <Widget>[
      //           buildSearch(),
      //           Expanded(
      //             child: ListView.builder(
      //               itemCount: customerList.length,
      //               itemBuilder: (context, index) {
      //                 final customer = customerList[index];
      //                 return buildCustomer(customer);
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   )
    ]);
    // Widget buildSearch() => SearchWidget(
    //       text: query,
    //       hintText: 'Customer Id or Customer Name',
    //       onChanged: searchCustomer,
    //     );
    // Widget buildCustomer(Customer customer) => ListTile(
    //       leading: CircleAvatar(backgroundImage: FileImage(customer.image)),
    //       title: Text(customer.name),
    //       subtitle: Text(customer.id),
    //       onTap: () {
    //         setState(() {
    //           isCustomerInitilize = true;
    //           selectedCusomer = customer;
    //           isExpand = false;
    //         });
    //       },
    //     );
    // Future searchCustomer(String query) async {
    //   final customerList2 =
    //       await Provider.of<CustomerProvider>(context, listen: false)
    //           .fetchCustomerListFormDatabase();
    //   if (!mounted) return;
    //   final customerList = customerList2.where((customer) {
    //     final nameLower = customer.name.toLowerCase();
    //     final idLower = customer.id.toLowerCase();
    //     final searchLower = query.toLowerCase();
    //     return nameLower.contains(searchLower) || idLower.contains(searchLower);
    //   }).toList();
    //   setState(() {
    //     this.query = query;
    //     this.customerList = customerList;
    //   });
    // }}
  }
}

class DataSearch extends SearchDelegate<Customer> {
  List<Customer> availabelList;
  DataSearch(this.availabelList);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? availabelList
        : availabelList.where((element) {
            return (element.name.startsWith(query) ||
                element.id.startsWith(query));
          }).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Provider.of<SelectedCustomerProvider>(context, listen: false)
              .addSelectedCusotmer(suggestionList[index]);

          Navigator.of(context).pop();
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].name.substring(0, query.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].name.substring(query.length),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       !isExpand
//           ? Card(
//               elevation: 10,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: !isCustomerInitilize
//                             ? Image.asset('assets/images/propic.png').image
//                             : FileImage(selectedCusomer.image),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       !isCustomerInitilize
//                           ? const Text(
//                               'Name of the customer',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           : Text(selectedCusomer.name,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                       !isCustomerInitilize
//                           ? const Text('ID',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ))
//                           : Text(selectedCusomer.id,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               )),
//                       ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               isExpand = !isExpand;
//                             });
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: const <Widget>[
//                               Text('Serach Customer'),
//                               Icon(Icons.search),
//                             ],
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             )
//           : Card(
//               child: Container(
//                 margin: const EdgeInsets.all(10),
//                 height: 200,
//                 child: Column(
//                   children: <Widget>[
//                     buildSearch(),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: customerList.length,
//                         itemBuilder: (context, index) {
//                           final customer = customerList[index];
//                           return buildCustomer(customer);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//     ]);
//   }
//   Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Customer Id or Customer Name',
//         onChanged: searchCustomer,
//       );
//   Widget buildCustomer(Customer customer) => ListTile(
//         leading: CircleAvatar(backgroundImage: FileImage(customer.image)),
//         title: Text(customer.name),
//         subtitle: Text(customer.id),
//         onTap: () {
//           setState(() {
//             isCustomerInitilize = true;
//             selectedCusomer = customer;
//             isExpand = false;
//           });
//         },
//       );
//   Future searchCustomer(String query) async {
//     final customerList2 =
//         await Provider.of<CustomerProvider>(context, listen: false)
//             .fetchCustomerListFormDatabase();
//     if (!mounted) return;
//     final customerList = customerList2.where((customer) {
//       final nameLower = customer.name.toLowerCase();
//       final idLower = customer.id.toLowerCase();
//       final searchLower = query.toLowerCase();
//       return nameLower.contains(searchLower) || idLower.contains(searchLower);
//     }).toList();
//     setState(() {
//       this.query = query;
//       this.customerList = customerList;
//     });
//   }
// }}
  }
}
