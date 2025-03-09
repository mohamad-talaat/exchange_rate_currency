import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final Rx<DateTime> date;

  const CustomDatePicker({
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: date.value,
              firstDate: DateTime(2010),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              date.value = picked;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(date.value)),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ));
  }
}
