import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPickerTableCell extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarPickerTableCell({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _CalendarPickerTableCellState createState() =>
      _CalendarPickerTableCellState();
}

class _CalendarPickerTableCellState extends State<CalendarPickerTableCell> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                  : 'Select Date',
              style: TextStyle(fontSize: 14),
            ),
            Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }
}
