import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_exchange_app/controllers/exchange_controller.dart';
import 'package:currency_exchange_app/views/widgets/home/currency_dropdown.dart';
import 'package:currency_exchange_app/views/widgets/home/date_picker.dart';
import 'package:currency_exchange_app/views/widgets/home/exchange_rate_table.dart';

class HomePage extends StatelessWidget {
  final ExchangeController controller = Get.put(ExchangeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Currency Exchange Rates')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Select Currency & Date Range',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            _buildDateSelection(context),
            const SizedBox(height: 10),
            _buildCurrencySelection(),
            const SizedBox(height: 8),
            _buildSearchButton(),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.hasError.value) {
                  return Center(
                    child: Text(
                      'Error: ${controller.errorMessage.value}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (controller.exchangeRateRecords.isEmpty) {
                  return const Center(
                    child: Text(
                        'No data available. Please search for exchange rates.'),
                  );
                }

                return ExchangeRateTable(controller: controller);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Start Date:'),
              const SizedBox(height: 4),
              CustomDatePicker(date: controller.startDate),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('End Date:'),
              const SizedBox(height: 4),
              CustomDatePicker(date: controller.endDate),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencySelection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('From Currency:'),
              const SizedBox(height: 4),
              CurrencyDropdown(
                selectedCurrency: controller.selectedSourceCurrency,
                currencies: controller.availableCurrencies,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Target Currency:'),
              const SizedBox(height: 4),
              CurrencyDropdown(
                selectedCurrency: controller.selectedTargetCurrency,
                currencies: controller.availableCurrencies,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return Container(
      color: Colors.blue.shade100,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.fetchExchangeRates,
        child: const Text('Search Exchange Rates'),
      ),
    );
  }
}
