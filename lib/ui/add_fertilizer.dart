import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../providers/fertilizer_provider.dart';
import '../widgets/image_input.dart';

class AddFertilizer extends StatefulWidget {
  static const routName = '/add-fertilizer';
  const AddFertilizer({Key? key}) : super(key: key);
  @override
  _AddFertilizerState createState() => _AddFertilizerState();
}

class _AddFertilizerState extends State<AddFertilizer> {
  TextEditingController unitPrice = TextEditingController();
  TextEditingController storedAmount = TextEditingController();
  final Map<String, dynamic> _fertilzerAddDataMap = {
    'name': '',
    'type': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  File? _fertilizerImage;
  void _selectFerilizerImae(File image) {
    _fertilizerImage = image;
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
      await Provider.of<FertilizerProvider>(context, listen: false)
          .AddFertilizer(
        _fertilzerAddDataMap['name'],
        _fertilzerAddDataMap['type'],
        double.parse(unitPrice.text),
        double.parse(storedAmount.text),
        _fertilizerImage as File,
      );
      _showSuccessDialog('save succussfully!');
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
                  ImageInput(_selectFerilizerImae, 'Product Pic'),
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
                              _fertilzerAddDataMap['name'] = value as String;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Type'),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid type';
                              }
                            },
                            onSaved: (value) {
                              _fertilzerAddDataMap['type'] = value as String;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Unite Price'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Unite Price';
                              }
                            },
                            controller: unitPrice,
                            onSaved: (value) {},
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Amount of Kilos'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid number';
                              }
                            },
                            controller: storedAmount,
                            onSaved: (value) {},
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
