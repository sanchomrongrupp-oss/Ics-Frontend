import 'package:flutter/material.dart';
import 'package:ics_frontend/Class/class_button.dart';
import 'package:ics_frontend/Class/class_inpputfield.dart';

class Adjustment extends StatefulWidget {
  const Adjustment({super.key});

  @override
  State<Adjustment> createState() => _AdjustmentState();
}

class _AdjustmentState extends State<Adjustment> {
  // --- Form State ---
  String _currentReason = "Select Reason";
  final List<String> _reasons = [
    "(-10) Damaged Goods",
    "(+11) Damaged Goods Back",
    "(-20) Expired Products",
    "(+21) Expired Products Back",
    "(-30) Theft or Loss",
    "(+31) Theft or Loss Back",
    "(-40) Stock Count Error",
    "(+41) Stock Count Error Back",
    "(-50) Returns from Customers Over",
    "(+51) Returns from Customers",
    "(-60) Promotional Samples",
  ];

  // --- Table State ---
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  int? selectedRow;
  final List<Map<String, dynamic>> orderItems = [];

  OverlayEntry? _overlayEntry;

  // --- Logic Methods ---
  void _addItem() {
    if (itemController.text.isEmpty || _currentReason == "Select Reason") {
      return;
    }
    final now = DateTime.now();

    setState(() {
      orderItems.add({
        "no": orderItems.length + 1,
        "item": itemController.text,
        "name": "Beer", // Mock name
        "qty": int.tryParse(qtyController.text) ?? 1,
        "price": 0.0, // Adjustments usually don't have a purchase price here
        "reason": _currentReason,
        "adjust_date": now.toString().split(" ").first,
      });
      _clearInputs();
    });
  }

  void _deleteItem() {
    if (selectedRow == null) return;
    setState(() {
      orderItems.removeAt(selectedRow!);
      // Re-number rows
      for (int i = 0; i < orderItems.length; i++) {
        orderItems[i]["no"] = i + 1;
      }
      _clearInputs();
    });
  }

  void _updateItem() {
    if (selectedRow == null) return;
    setState(() {
      orderItems[selectedRow!]["item"] = itemController.text;
      orderItems[selectedRow!]["qty"] = int.tryParse(qtyController.text) ?? 1;
      orderItems[selectedRow!]["reason"] = _currentReason;
      _clearInputs();
    });
  }

  void _clearInputs() {
    itemController.clear();
    qtyController.clear();
    _currentReason = "Select Reason";
    selectedRow = null;
  }

  void _done() {
    debugPrint("Adjustment Saved: ${orderItems.length} items");
  }

  // --- Dropdown Logic ---
  void _toggleDropdown(BuildContext buttonContext) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(buttonContext);
      Overlay.of(buttonContext).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext buttonContext) {
    final isDark = Theme.of(buttonContext).brightness == Brightness.dark;
    RenderBox renderBox = buttonContext.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    const double dropdownWidth = 280;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 4,
        width: dropdownWidth,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? Colors.white38 : Colors.grey.shade400,
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: _reasons.map((reason) {
                return ListTile(
                  title: Text(reason, style: const TextStyle(fontSize: 14)),
                  onTap: () {
                    setState(() => _currentReason = reason);
                    _toggleDropdown(buttonContext);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    itemController.dispose();
    qtyController.dispose();
    super.dispose();
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
          final qtyFieldWidth = isDesktop ? 150.0 : (isTablet ? 130.0 : 110.0);
          final reasonDropdownWidth = isDesktop
              ? 250.0
              : (isTablet ? 220.0 : 180.0);
          final dropdownHeight = isDesktop ? 48.0 : (isTablet ? 44.0 : 40.0);
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
                    "Inventory Adjustment",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(height: dividerHeight),
                  isMobile
                      ? Column(
                          children: [
                            CustomInputField(
                              label: "Adjust Number",
                              width: double.infinity,
                              readOnly: true,
                            ),
                            SizedBox(height: inputFieldRowSpacing),
                            CustomInputField(
                              label: "Adjust By",
                              width: double.infinity,
                              readOnly: true,
                            ),
                            SizedBox(height: inputFieldRowSpacing),
                            CustomInputField(
                              label: "Adjust Date",
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
                              label: "Adjust Number",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Adjust By",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Adjust Date",
                              width: inputFieldWidth,
                              readOnly: true,
                            ),
                          ],
                        ),
                  SizedBox(height: dividerHeight),
                  Text(
                    "Adjustment Items",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(height: dividerHeight),
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
                            Builder(
                              builder: (buttonContext) => GestureDetector(
                                onTap: () => _toggleDropdown(buttonContext),
                                child: Container(
                                  height: dropdownHeight,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.grey.shade400,
                                    ),
                                    color: isDark
                                        ? Colors.black26
                                        : Colors.grey[100],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _currentReason,
                                          style: TextStyle(
                                            fontSize: titleFontSize - 2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down, size: 20),
                                    ],
                                  ),
                                ),
                              ),
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
                                    onTap: _done,
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
                            Builder(
                              builder: (buttonContext) => GestureDetector(
                                onTap: () => _toggleDropdown(buttonContext),
                                child: Container(
                                  height: dropdownHeight,
                                  width: reasonDropdownWidth,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.grey.shade400,
                                    ),
                                    color: isDark
                                        ? Colors.black26
                                        : Colors.grey[100],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _currentReason,
                                          style: TextStyle(
                                            fontSize: titleFontSize - 2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down, size: 20),
                                    ],
                                  ),
                                ),
                              ),
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
                              onTap: _done,
                            ),
                          ],
                        ),
                  SizedBox(height: spacing * 2),
                  // Table Integrated Here
                  SizedBox(
                    height: tableHeight,
                    width: double.infinity,
                    child: _datatableItems(isDesktop, isTablet),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _datatableItems(bool isDesktop, bool isTablet) {
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
                        "Reason",
                        style: TextStyle(fontSize: columnFontSize),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Adjust Date",
                        style: TextStyle(fontSize: columnFontSize),
                      ),
                    ),
                  ],
                  rows: orderItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    var row = entry.value;

                    return DataRow(
                      selected: selectedRow == index,
                      onSelectChanged: (_) {
                        setState(() {
                          selectedRow = index;
                          itemController.text = row["item"];
                          qtyController.text = row["qty"].toString();
                          _currentReason = row["reason"];
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
                            row["qty"].toString(),
                            style: TextStyle(fontSize: columnFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            row["reason"],
                            style: TextStyle(fontSize: columnFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            row["adjust_date"],
                            style: TextStyle(fontSize: columnFontSize),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
