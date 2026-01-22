import 'package:flutter/material.dart';
import 'package:ics_frontend/Class/class_button.dart';
import 'package:ics_frontend/Class/class_inpputfield.dart';

class PurchaseOders extends StatefulWidget {
  const PurchaseOders({super.key});

  @override
  State<PurchaseOders> createState() => _PurchaseOdersState();
}

class _PurchaseOdersState extends State<PurchaseOders> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  int? selectedRow;

  final List<Map<String, dynamic>> orderItems = [];

  void _addItem() {
    if (itemController.text.isEmpty) return;

    final now = DateTime.now();

    setState(() {
      orderItems.add({
        "no": orderItems.length + 1,
        "item": itemController.text,
        "name": "Supplier A",
        "qty": int.tryParse(qtyController.text) ?? 1,
        "price": 10.0,
        "order_date": now.toString().split(" ").first,
        "exp_date": now
            .add(const Duration(days: 7))
            .toString()
            .split(" ")
            .first,
      });
    });

    itemController.clear();
    qtyController.clear();
  }

  void _deleteItem() {
    if (selectedRow == null) return;

    setState(() {
      orderItems.removeAt(selectedRow!);

      // Re-number rows
      for (int i = 0; i < orderItems.length; i++) {
        orderItems[i]["no"] = i + 1;
      }

      selectedRow = null;
      itemController.clear();
      qtyController.clear();
    });
  }

  void _updateItem() {
    if (selectedRow == null) return;

    setState(() {
      orderItems[selectedRow!]["item"] = itemController.text;
      orderItems[selectedRow!]["qty"] = int.tryParse(qtyController.text) ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Purchase Orders",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 32),

            /// HEADER INPUTS
            Wrap(
              spacing: 80,
              runSpacing: 40,
              children: const [
                CustomInputField(
                  label: "PO Number",
                  width: 300,
                  readOnly: true,
                ),
                CustomInputField(label: "Supplier ID", width: 300),
                CustomInputField(
                  label: "Supplier Name",
                  width: 300,
                  readOnly: true,
                ),
                CustomInputField(
                  label: "Order Date",
                  width: 300,
                  readOnly: true,
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              "Purchase Order Items",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 32),

            /// ITEM INPUT + BUTTONS
            Wrap(
              spacing: 40,
              runSpacing: 40,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                CustomInputField(
                  label: "Item",
                  width: 300,
                  controller: itemController,
                ),
                CustomInputField(
                  label: "Qty",
                  width: 200,
                  controller: qtyController,
                ),
                CustomButton(
                  label: "Add Item",
                  width: 140,
                  height: 40,
                  color: Colors.blue,
                  textcolor: Colors.white,
                  onTap: _addItem,
                ),
                CustomButton(
                  label: "Delete Item",
                  width: 140,
                  height: 40,
                  color: Colors.red,
                  textcolor: Colors.white,
                  onTap: _deleteItem,
                ),
                CustomButton(
                  label: "Update Item",
                  width: 140,
                  height: 40,
                  color: Colors.orange,
                  textcolor: Colors.white,
                  onTap: _updateItem,
                ),
                CustomButton(
                  label: "Send PO",
                  width: 140,
                  height: 40,
                  color: Colors.green,
                  textcolor: Colors.white,
                  onTap: () => debugPrint("Send PO"),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// TABLE
            SizedBox(height: 521, width: double.infinity, child: _tableItems()),
          ],
        ),
      ),
    );
  }

  Widget _tableItems() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTableTheme(
                  data: DataTableThemeData(
                    dividerThickness: 1,
                    headingRowColor: WidgetStateProperty.all(
                      isDark ? Colors.grey.shade900 : Colors.blue[300],
                    ),
                    horizontalMargin: 16,
                    columnSpacing: 40,
                  ),
                  child: DataTable(
                    showCheckboxColumn: false,
                    headingRowHeight: 48,
                    dataRowHeight: 46,
                    columns: const [
                      DataColumn(label: Text("No")),
                      DataColumn(label: Text("Item")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Qty")),
                      DataColumn(label: Text("Price")),
                      DataColumn(label: Text("Amount")),
                      DataColumn(label: Text("Order Date")),
                      DataColumn(label: Text("Exp Date")),
                    ],

                    rows: orderItems.isEmpty
                        ? []
                        : List.generate(orderItems.length, (index) {
                            final row = orderItems[index];
                            final qty = row["qty"] ?? 0;
                            final price = row["price"] ?? 0.0;
                            final amount = qty * price;

                            return DataRow(
                              selected: selectedRow == index,
                              onSelectChanged: (_) {
                                setState(() {
                                  selectedRow = index;
                                  itemController.text = row["item"];
                                  qtyController.text = row["qty"].toString();
                                });
                              },
                              cells: [
                                DataCell(Text(row["no"].toString())),
                                DataCell(Text(row["item"])),
                                DataCell(Text(row["name"])),
                                DataCell(Text(qty.toString())),
                                DataCell(Text(price.toStringAsFixed(2))),
                                DataCell(Text(amount.toStringAsFixed(2))),
                                DataCell(Text(row["order_date"])),
                                DataCell(Text(row["exp_date"])),
                              ],
                            );
                          }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
