import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDropdown extends StatefulWidget {
  final String title;
  final ValueChanged<DateTime?> onDateSelected;

  const DateDropdown({
    super.key,
    required this.title,
    required this.onDateSelected,
  });

  @override
  _DateDropdownState createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {
  DateTime? _selectedDate;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: const TextStyle(color: Colors.black)),
                    const SizedBox(height: 4),
                    Text(
                      _selectedDate != null
                          ? DateFormat("dd/MM/yyyy").format(_selectedDate!)
                          : "dd/mm/yyyy",
                      style: TextStyle(
                          color: _selectedDate != null? Theme.of(context).colorScheme.primary : Colors.grey
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isDropdownOpen
              ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CalendarDatePicker(
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                  _isDropdownOpen = false;
                });
                widget.onDateSelected(date);
              },
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
