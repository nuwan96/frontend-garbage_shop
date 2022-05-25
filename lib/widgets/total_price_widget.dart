import 'package:flutter/material.dart';
import '../widgets/button_widget.dart';

// ignore: must_be_immutable
class TotalPrice extends StatefulWidget {
  double totalPrice;
  double unitePrice;
  double amountOfKilos;
  Function setTotalPrice;
  TotalPrice(
      {Key? key,
      required this.setTotalPrice,
      required this.unitePrice,
      this.amountOfKilos = 0,
      required this.totalPrice})
      : super(key: key);
  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  void calculate() {
    setState(() {
      widget.totalPrice = widget.unitePrice * widget.amountOfKilos;
    });
    widget.setTotalPrice(widget.totalPrice);
  }

  String getText() {
    if (widget.totalPrice == 0) {
      return 'Calculate';
    } else {
      return "RS : ${widget.totalPrice.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonHeaderWidget(
      title: 'TotalPrice',
      text: getText(),
      onClicked: () => calculate(),
    );
  }
}
