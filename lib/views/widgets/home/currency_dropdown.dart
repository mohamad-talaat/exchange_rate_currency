import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyDropdown extends StatelessWidget {
  final Rx<String> selectedCurrency;
  final RxList<String> currencies;

  const CurrencyDropdown({
    required this.selectedCurrency,
    required this.currencies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: selectedCurrency.value,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (newValue) {
              if (newValue != null) {
                selectedCurrency.value = newValue;
              }
            },
            items: currencies.map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
          ),
        ));
  }
}
