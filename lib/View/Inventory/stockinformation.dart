import 'package:flutter/material.dart';
import 'package:ics_frontend/Class/class_inpputfield.dart';

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 800;

          // Responsive sizing
          final labelFontSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);
          final searchLabelFontSize = isDesktop
              ? 16.0
              : (isTablet ? 14.0 : 12.0);
          final detailsTitleFontSize = isDesktop
              ? 24.0
              : (isTablet ? 20.0 : 18.0);
          final padding = isDesktop ? 28.0 : (isTablet ? 20.0 : 16.0);
          final spacing = isDesktop ? 16.0 : (isTablet ? 12.0 : 8.0);
          final fieldWidth = isDesktop ? 286.0 : (isTablet ? 280.0 : 250.0);
          final fieldSpacing = isDesktop ? 120.0 : (isTablet ? 80.0 : 40.0);
          final fieldRowSpacing = isDesktop ? 64.0 : (isTablet ? 48.0 : 32.0);
          final searchFieldWidth = isDesktop
              ? 380.0
              : (isTablet ? 300.0 : 250.0);
          final buttonMinSize = isDesktop
              ? Size(140, 48)
              : (isTablet ? Size(120, 45) : Size(100, 40));
          final buttonFontSize = isDesktop ? 16.0 : (isTablet ? 14.0 : 12.0);

          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search by item or barcode",
                      style: TextStyle(
                        fontSize: searchLabelFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spacing),
                    isMobile
                        ? Column(
                            children: [
                              SizedBox(
                                height: 45,
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
                                    hintStyle: TextStyle(
                                      fontSize: labelFontSize - 2,
                                    ),
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
                              SizedBox(height: spacing),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 45),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Search",
                                  style: TextStyle(fontSize: buttonFontSize),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: searchFieldWidth,
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
                                    hintStyle: TextStyle(
                                      fontSize: labelFontSize - 2,
                                    ),
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
                              SizedBox(width: spacing),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  minimumSize: buttonMinSize,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Search",
                                  style: TextStyle(fontSize: buttonFontSize),
                                ),
                              ),
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: spacing, bottom: spacing),
                      child: Divider(color: Colors.grey[10]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Details",
                          style: TextStyle(
                            fontSize: detailsTitleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spacing * 1.5),
                        Wrap(
                          spacing: fieldSpacing,
                          runSpacing: fieldRowSpacing,
                          alignment: WrapAlignment.start,
                          children: [
                            CustomInputField(
                              label: "Product Item Code",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Barcode",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Name",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Status",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Color",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Size",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Brand",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Unit",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Cost Price",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Selling Price",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Stock Quantity",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Expiry Date",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Supplier ID",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Supplier Name",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                            CustomInputField(
                              label: "Product Reorder",
                              width: fieldWidth,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
