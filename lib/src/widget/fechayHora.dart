import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/classGeneral.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  DateTimePickerWidget({
    required size,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDate;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        final DateTime newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = newDateTime;
        });
        widget.onDateChanged(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    final formattedDate = dateFormat.format(selectedDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10, left: 20, top: 10),
          width: size.width,
          height: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: General.colorApp,
              width: 0, 
            ),
            color: Color(0xffF2F2F2).withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              _selectDateTime(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 5),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
