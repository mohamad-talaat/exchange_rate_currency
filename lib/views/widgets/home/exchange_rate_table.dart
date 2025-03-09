import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:currency_exchange_app/controllers/exchange_controller.dart';

class ExchangeRateTable extends StatelessWidget {
  final ExchangeController controller;

  const ExchangeRateTable({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            _buildTableHeader(),
            _buildTableBody(),
            _buildPagination(),
          ],
        ));
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        border: const Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'From',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Target',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Rate',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.currentPageRecords.length,
        itemBuilder: (context, index) {
          final record = controller.currentPageRecords[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(record.date),
                ),
                Expanded(
                  flex: 1,
                  child: Text(record.sourceCurrency),
                ),
                Expanded(
                  flex: 1,
                  child: Text(record.targetCurrency),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    record.rate.toStringAsFixed(4),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              'Page ${controller.currentPage.value + 1} of ${controller.totalPages.value}'),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: controller.currentPage.value > 0
                    ? controller.previousPage
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: controller.currentPage.value <
                        controller.totalPages.value - 1
                    ? controller.nextPage
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
