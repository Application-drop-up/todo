import 'package:flutter/material.dart';

class DeadlinePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DeadlinePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Deadline",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 22, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                selectedDate == null
                    ? "未選択"
                    : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
    );
  }
}
