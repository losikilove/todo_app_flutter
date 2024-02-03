import 'package:flutter/material.dart';
import 'package:todo_list/utils/my_style.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateTimeChanged;

  const DateTimePicker(
      {super.key, required this.initialDate, required this.onDateTimeChanged});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: _selectedDateTime,
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDateTime) {
      setState(() {
        _selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
        widget.onDateTimeChanged(_selectedDateTime);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          picked.hour,
          picked.minute,
        );
        widget.onDateTimeChanged(_selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            "${_selectedDateTime.year}/${_selectedDateTime.month.toString().padLeft(2, '0')}/${_selectedDateTime.day.toString().padLeft(2, '0')}",
            style: const TextStyle(color: myBlack),
          ),
        ),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text(
            "${_selectedDateTime.hour.toString().padLeft(2, '0')}:${_selectedDateTime.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(color: myBlack),
          ),
        ),
      ],
    );
  }
}
