import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/button_widget.dart';

// ignore: must_be_immutable
class DatetimePickerWidget extends StatefulWidget {
  DateTime? dateTime;
  Function setSelectedDate;
  DatetimePickerWidget(
      {Key? key, required this.dateTime, required this.setSelectedDate})
      : super(key: key);
  @override
  _DatetimePickerWidgetState createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  String getText() {
    if (widget.dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(widget.dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'DateTime',
        text: getText(),
        onClicked: () => pickDateTime(context),
      );
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date.year == 0000) return;
    final time = await pickTime(context);
    if (time.hour == 0 && time.minute == 0) return;
    setState(() {
      widget.dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      widget.setSelectedDate(widget.dateTime);
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return DateTime(0000);
    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: widget.dateTime != null
          ? TimeOfDay(
              hour: widget.dateTime!.hour, minute: widget.dateTime!.minute)
          : initialTime,
    );
    if (newTime == null) return const TimeOfDay(hour: 0, minute: 0);
    return newTime;
  }
}
