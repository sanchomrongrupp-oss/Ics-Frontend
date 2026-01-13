import 'package:flutter/material.dart';

class StockInformation extends StatefulWidget {
  const StockInformation({super.key});

  @override
  State<StockInformation> createState() => _StockInformationState();
}

class _StockInformationState extends State<StockInformation> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isDark ? Colors.white10 : Colors.grey[200]!),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 873,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search by item or barcorde",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 350,
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDark
                                ? Colors.black26
                                : Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search Product",
                            hintStyle: const TextStyle(fontSize: 14),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Image.asset(
                                'icons/search.png',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(120, 45),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Search"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Divider(color: Colors.grey[10]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  Wrap(
                    spacing: 114,
                    runSpacing: 60,
                    alignment: WrapAlignment.start,
                    children: [
                      _FieldProduct(context, "Product Item Code", 300),
                      _FieldProduct(context, "Product Barcode", 300),
                      _FieldProduct(context, "Product Name", 300),
                      _FieldProduct(context, "Product Status", 300),
                      _FieldProduct(context, "Product Color", 300),
                      _FieldProduct(context, "Product Size", 300),
                      _FieldProduct(context, "Product Brand", 300),
                      _FieldProduct(context, "Product Unit", 300),
                      _FieldProduct(context, "Product Cost_Price", 300),
                      _FieldProduct(context, "Product Selling_Price", 300),
                      _FieldProduct(context, "Product Stock_Quantity", 300),
                      _FieldProduct(context, "Product Reoder", 300),
                      _FieldProduct(context, "Product Supplier", 300),
                      _FieldProduct(context, "Product Expiry_Date", 300),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _FieldProduct(BuildContext context, String label, double width) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 6), // Space between label and field
        SizedBox(
          height: 40,
          width: width,
          child: TextField(
            readOnly: true,
            style: textStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? Colors.white10 : Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark ? Colors.white24 : Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark ? Colors.white24 : Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              hintStyle: textStyle.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
