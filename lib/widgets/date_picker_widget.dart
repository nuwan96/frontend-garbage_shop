import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/button_widget.dart';

// ignore: must_be_immutable
class DatePickerWidget extends StatefulWidget {
  String title;
  DateTime? date;
  DatePickerWidget(this.date, {Key? key, this.title = 'Date Of Birth'})
      : super(key: key);
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  String getText() {
    if (widget.date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(widget.date as DateTime);
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: widget.title,
        text: getText(),
        onClicked: () => pickDate(context),
      );
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() => widget.date = newDate);
  }
}
