import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../models/fertilizer.dart';
import '../providers/fertilizer_provider.dart';
import '../providers/purches_fertilizer_cost_provider.dart';
import '../ui/fertilizer_over_view.dart';
import '../widgets/fertilizer_list_tile_widger.dart';
import '../widgets/total_price_widget.dart';

// ignore: must_be_immutable
class FertilizerCostPaymentWidget extends StatefulWidget {
  String customerId;
  DateTime date;
  DateTime time;
  FertilizerCostPaymentWidget(
      {Key? key, this.customerId = '1', required this.date, required this.time})
      : super(key: key);
  @override
  _FertilizerCostPaymentWidgetState createState() =>
      _FertilizerCostPaymentWidgetState();
}

class _FertilizerCostPaymentWidgetState
    extends State<FertilizerCostPaymentWidget> {
  double unitePrice = 0;
  String fertilizerType = '';
  List<Fertilizer> fertilizerList = [];
  bool _isSelected = false;
//form date//////////////////////////////////////////////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  TextEditingController amountOfKilos = TextEditingController();
  double amountOfKilosOnChangeValue = 0;
  double totalPrice = 0;
  void setTotalPrice(double totalPrice) {
    this.totalPrice = totalPrice;
  }

  void _showSaveSuccessDialog(DateTime dateTime, String amount, String cusID) {
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
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.buttonColorDarkGreen,
                      ),
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
                      Text(cusID,
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
      await Provider.of<PurchesFertilzerCostProvider>(context, listen: false)
          .AddPurchedFertilizerCost(widget.customerId, widget.date, widget.time,
              fertilizerType, double.parse(amountOfKilos.text), totalPrice);
    } catch (error) {
      var errorMessage = 'Could not save the data.' + error.toString();
      _showErrorDialog(errorMessage);
    }
    _showSaveSuccessDialog(
        widget.date, totalPrice.toString(), widget.customerId);
    amountOfKilos.clear();

    setState(() {
      _isSelected = false;
      _isLoading = false;
    });
  }

  void _clear() async {
    amountOfKilos.clear();

    setState(() {
      _isSelected = false;
    });
  }

////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    loadFertilizerList();
    super.initState();
  }

  Future loadFertilizerList() async {
    final fertilizerList =
        await Provider.of<FertilizerProvider>(context, listen: false)
            .fetchFertilizerFromDatabase();
    setState(() {
      this.fertilizerList = fertilizerList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isSelected
        ? Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Fertilizer List',
                      style: TextStyle(
                          color: AppColors.textGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.5)),
                  InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('View All',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FertilizerOverView()));
                      })
                ],
              ),
              const SizedBox(height: 5.0),
              _fertilizerList()
            ]),
          )
        : _selectedItem();
  }

  Widget _selectedItem() {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Fertilizer Type',
                        style: TextStyle(
                            color: AppColors.textGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5)),
                    Text(fertilizerType,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Per Unite price',
                        style: TextStyle(
                            color: AppColors.textGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5)),
                    Text(
                      unitePrice.toString(),
                      style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5),
                    )
                  ],
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Amount of Kilos'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Value';
                    }
                  },
                  onSaved: (value) {},
                  onChanged: (value) {
                    setState(() {
                      amountOfKilosOnChangeValue = double.parse(value);
                    });
                  },
                  controller: amountOfKilos,
                ),
                TotalPrice(
                  unitePrice: unitePrice,
                  amountOfKilos: amountOfKilosOnChangeValue,
                  totalPrice: totalPrice,
                  setTotalPrice: setTotalPrice,
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
    );
  }

  Widget _fertilizerList() {
    return SizedBox(
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: fertilizerList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                setState(() {
                  _isSelected = true;
                  fertilizerType = fertilizerList[index].name;
                  unitePrice = fertilizerList[index].unitPrice;
                });
              },
              child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 5) / 4,
                  child: FertilizerListTileWidget(
                    price: fertilizerList[index].unitPrice,
                    name: fertilizerList[index].name,
                    imageUrl: fertilizerList[index].image,
                  )));
        },
      ),
    );
  }
}
