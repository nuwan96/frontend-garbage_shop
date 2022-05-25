import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../providers/customer_provider.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AddCustomers extends StatefulWidget {
  static const routName = '/add-customer';
  const AddCustomers({Key? key}) : super(key: key);
  @override
  _AddCustomersState createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  final Map<String, dynamic> _customerRegistrationData = {
    'name': '',
    'id': '',
    'address': '',
    'date_of_birth': '2002.02.01',
    'contact': '',
    'account_number': '',
    'email': ''
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  File? _pickedProfilePic;
  DateTime? selecDateTime;
  void _selectedProfilePic(File profilePic) {
    _pickedProfilePic = profilePic;
  }

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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save SuccessFull!'),
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
    // print(_customerRegistrationData.toString());
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CustomerProvider>(context, listen: false).addCustomer(
          _customerRegistrationData['name'] as String,
          _customerRegistrationData['id'] as String,
          _customerRegistrationData['address'] as String,
          _customerRegistrationData['contact'] as String,
          selecDateTime.toString(),
          _customerRegistrationData['account_number'] as String,
          _customerRegistrationData['email'] as String,
          _pickedProfilePic as File);

      _showSuccessDialog("save successfully");
      Navigator.of(context).pop();
    } catch (error) {
      var errorMessage = 'Could not save the data.' + error.toString();
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55), //width and height
          child: SafeArea(
              child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 20,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.buttonColorDarkGrey,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            height: 800,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageInput(_selectedProfilePic, 'Profile PIC'),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Name';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['name'] =
                                  value as String;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'ID'),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Id';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['id'] = value as String;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Address';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['address'] =
                                  value as String;
                            },
                          ),
                          DatePickerWidget(selecDateTime),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Contact Number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Number';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['contact'] =
                                  value as String;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Account Number'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Account Number';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['account_number'] =
                                  value as String;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Invalid Email Address';
                              }
                            },
                            onSaved: (value) {
                              _customerRegistrationData['email'] =
                                  value as String;
                            },
                          ),
                          const SizedBox(height: 10),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ElevatedButton(
                                onPressed: _submit,
                                child: const Text(
                                  'SAVE',
                                ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
