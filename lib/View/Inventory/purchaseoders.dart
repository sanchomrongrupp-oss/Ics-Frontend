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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 800;

          // Responsive sizing
          final titleFontSize = isDesktop ? 18.0 : (isTablet ? 16.0 : 14.0);
          final padding = isDesktop ? 28.0 : (isTablet ? 20.0 : 16.0);
          final spacing = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
          final dividerHeight = isDesktop ? 32.0 : (isTablet ? 24.0 : 20.0);
          final inputFieldWidth = isDesktop
              ? 300.0
              : (isTablet ? 260.0 : 220.0);
          final inputFieldSpacing = isDesktop ? 80.0 : (isTablet ? 60.0 : 30.0);
          final inputFieldRowSpacing = isDesktop
              ? 40.0
              : (isTablet ? 32.0 : 24.0);
          final qtyFieldWidth = isDesktop ? 200.0 : (isTablet ? 160.0 : 140.0);
          final buttonWidth = isDesktop ? 140.0 : (isTablet ? 120.0 : 100.0);
          final buttonHeight = isDesktop ? 48.0 : (isTablet ? 44.0 : 40.0);
          final tableHeight = isDesktop ? 560.0 : (isTablet ? 480.0 : 420.0);

          return Padding(
            padding: EdgeInsets.all(padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Purchase Orders",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(height: dividerHeight),

                  /// HEADER INPUTS
                  isMobile
                      ? Column(
                          children: [
                            CustomInputField(
                              label: "PO Number",
                              width: double.infinity,
                              readOnly: true,
                            ),
                            SizedBox(height: inputFieldRowSpacing),
                            CustomInputField(
                              label: "Supplier ID",
                              width: double.infinity,
                            ),
                            SizedBox(height: inputFieldRowSpacing),
                            CustomInputField(
                              label: "Supplier Name",
                              width: double.infinity,
                              readOnly: true,
                            ),
                            SizedBox(height: inputFieldRowSpacing),
                            CustomInputField(
                              label: "Order Date",
                              width: double.infinity,
                              readOnly: true,
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: inputFieldSpacing,
                          runSpacing: inputFieldRowSpacing,
                          children: [
                            CustomInputField(
                              label: "PO Number",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Supplier ID",
                              width: inputFieldWidth,
                            ),
                            CustomInputField(
                              label: "Supplier Name",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Order Date",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                          ],
                        ),

                  SizedBox(height: dividerHeight),

                  Text(
                    "Purchase Order Items",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(height: dividerHeight),

                  /// ITEM INPUT + BUTTONS
                  isMobile
                      ? Column(
                          children: [
                            CustomInputField(
                              label: "Item",
                              width: double.infinity,
                              controller: itemController,
                            ),
                            SizedBox(height: spacing),
                            CustomInputField(
                              label: "Qty",
                              width: double.infinity,
                              controller: qtyController,
                            ),
                            SizedBox(height: spacing),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    label: "Add Item",
                                    width: double.infinity,
                                    height: buttonHeight,
                                    color: Colors.blue,
                                    textcolor: Colors.white,
                                    onTap: _addItem,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    label: "Delete Item",
                                    width: double.infinity,
                                    height: buttonHeight,
                                    color: Colors.red,
                                    textcolor: Colors.white,
                                    onTap: _deleteItem,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    label: "Update Item",
                                    width: double.infinity,
                                    height: buttonHeight,
                                    color: Colors.orange,
                                    textcolor: Colors.white,
                                    onTap: _updateItem,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    label: "Send PO",
                                    width: double.infinity,
                                    height: buttonHeight,
                                    color: Colors.green,
                                    textcolor: Colors.white,
                                    onTap: () => debugPrint("Send PO"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            CustomInputField(
                              label: "Item",
                              width: inputFieldWidth,
                              controller: itemController,
                            ),
                            CustomInputField(
                              label: "Qty",
                              width: qtyFieldWidth,
                              controller: qtyController,
                            ),
                            CustomButton(
                              label: "Add Item",
                              width: buttonWidth,
                              height: buttonHeight,
                              color: Colors.blue,
                              textcolor: Colors.white,
                              onTap: _addItem,
                            ),
                            CustomButton(
                              label: "Delete Item",
                              width: buttonWidth,
                              height: buttonHeight,
                              color: Colors.red,
                              textcolor: Colors.white,
                              onTap: _deleteItem,
                            ),
                            CustomButton(
                              label: "Update Item",
                              width: buttonWidth,
                              height: buttonHeight,
                              color: Colors.orange,
                              textcolor: Colors.white,
                              onTap: _updateItem,
                            ),
                            CustomButton(
                              label: "Send PO",
                              width: buttonWidth,
                              height: buttonHeight,
                              color: Colors.green,
                              textcolor: Colors.white,
                              onTap: () => debugPrint("Send PO"),
                            ),
                          ],
                        ),

                  SizedBox(height: spacing * 2),

                  /// TABLE
                  SizedBox(
                    height: tableHeight,
                    width: double.infinity,
                    child: _tableItems(isDesktop, isTablet),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tableItems(bool isDesktop, bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        // Responsive table sizing
        final headingRowHeight = isDesktop ? 52.0 : (isTablet ? 48.0 : 44.0);
        final dataRowHeight = isDesktop ? 50.0 : (isTablet ? 46.0 : 42.0);
        final columnSpacing = isDesktop ? 40.0 : (isTablet ? 28.0 : 16.0);
        final horizontalMargin = isDesktop ? 20.0 : (isTablet ? 16.0 : 12.0);
        final columnFontSize = isDesktop ? 14.0 : (isTablet ? 12.0 : 11.0);

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
                    horizontalMargin: horizontalMargin,
                    columnSpacing: columnSpacing,
                  ),
                  child: DataTable(
                    showCheckboxColumn: false,
                    headingRowHeight: headingRowHeight,
                    dataRowHeight: dataRowHeight,
                    columns: [
                      DataColumn(
                        label: Text(
                          "No",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Item",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Qty",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Price",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Amount",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Order Date",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Exp Date",
                          style: TextStyle(fontSize: columnFontSize),
                        ),
                      ),
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
                                DataCell(
                                  Text(
                                    row["no"].toString(),
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row["item"],
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row["name"],
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    qty.toString(),
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    price.toStringAsFixed(2),
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    amount.toStringAsFixed(2),
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row["order_date"],
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    row["exp_date"],
                                    style: TextStyle(fontSize: columnFontSize),
                                  ),
                                ),
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
