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
    if (itemController.text.isEmpty || _currentReason == "Select Reason")
      return;
    final now = DateTime.now();

    setState(() {
      orderItems.add({
        "no": orderItems.length + 1,
        "item": itemController.text,
        "name": "", // Mock name
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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // Removed fixed SizedBox height to allow scrolling
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inventory Adjustment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 32),
            Wrap(
              spacing: 80,
              runSpacing: 40,
              children: const [
                CustomInputField(
                  label: "Adjust Number",
                  width: 300,
                  readOnly: true,
                ),
                CustomInputField(
                  label: "Adjust By",
                  width: 300,
                  readOnly: true,
                ),
                CustomInputField(
                  label: "Adjust Date",
                  width: 300,
                  readOnly: true,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Adjustment Items",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 32),
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
                  width: 150,
                  controller: qtyController,
                ),

                Builder(
                  builder: (buttonContext) => GestureDetector(
                    onTap: () => _toggleDropdown(buttonContext),
                    child: Container(
                      height: 40,
                      width: 250,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark ? Colors.white38 : Colors.grey.shade400,
                        ),
                        color: isDark ? Colors.black26 : Colors.grey[100],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _currentReason,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down, size: 20),
                        ],
                      ),
                    ),
                  ),
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
                  label: "Done",
                  width: 140,
                  height: 40,
                  color: Colors.green,
                  textcolor: Colors.white,
                  onTap: _done,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Table Integrated Here
            SizedBox(
              height: 529,
              width: double.infinity,
              child: _datatableItems(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datatableItems() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTableTheme(
                data: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(
                    isDark ? Colors.grey.shade900 : Colors.blue[300],
                  ),
                ),
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Item")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Qty")),
                    DataColumn(label: Text("Reason")),
                    DataColumn(label: Text("Adjust Date")),
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
                        DataCell(Text(row["no"].toString())),
                        DataCell(Text(row["item"])),
                        DataCell(Text(row["qty"].toString())),
                        DataCell(Text(row["reason"])),
                        DataCell(Text(row["adjust_date"])),
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
