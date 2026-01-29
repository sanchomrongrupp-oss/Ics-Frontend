import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late List<SalesOrder> salesOrders;
  String _searchQuery = '';
  String _selectedStatus = 'All';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    salesOrders = [
      SalesOrder(
        id: 'SO001',
        customerName: 'John Smith',
        product: 'Laptop Pro',
        category: 'Electronics',
        quantity: 2,
        unitPrice: 999.99,
        totalAmount: 1999.98,
        status: SalesStatus.completed,
        date: 'Jan 25, 2026',
        paymentStatus: 'Paid',
      ),
      SalesOrder(
        id: 'SO002',
        customerName: 'Sarah Johnson',
        product: 'Office Chair',
        category: 'Furniture',
        quantity: 5,
        unitPrice: 149.99,
        totalAmount: 749.95,
        status: SalesStatus.pending,
        date: 'Jan 26, 2026',
        paymentStatus: 'Pending',
      ),
      SalesOrder(
        id: 'SO003',
        customerName: 'Mike Davis',
        product: 'Monitor 27"',
        category: 'Electronics',
        quantity: 3,
        unitPrice: 299.99,
        totalAmount: 899.97,
        status: SalesStatus.shipped,
        date: 'Jan 24, 2026',
        paymentStatus: 'Paid',
      ),
      SalesOrder(
        id: 'SO004',
        customerName: 'Emily Brown',
        product: 'Desk Lamp',
        category: 'Accessories',
        quantity: 10,
        unitPrice: 45.99,
        totalAmount: 459.90,
        status: SalesStatus.completed,
        date: 'Jan 23, 2026',
        paymentStatus: 'Paid',
      ),
      SalesOrder(
        id: 'SO005',
        customerName: 'Robert Wilson',
        product: 'Keyboard Mechanical',
        category: 'Accessories',
        quantity: 8,
        unitPrice: 129.99,
        totalAmount: 1039.92,
        status: SalesStatus.processing,
        date: 'Jan 22, 2026',
        paymentStatus: 'Paid',
      ),
      SalesOrder(
        id: 'SO006',
        customerName: 'Lisa Anderson',
        product: 'Wireless Mouse',
        category: 'Accessories',
        quantity: 15,
        unitPrice: 29.99,
        totalAmount: 449.85,
        status: SalesStatus.cancelled,
        date: 'Jan 21, 2026',
        paymentStatus: 'Refunded',
      ),
    ];
  }

  List<SalesOrder> get _filteredOrders {
    return salesOrders.where((order) {
      final matchesSearch =
          order.customerName.toLowerCase().contains(_searchQuery) ||
          order.product.toLowerCase().contains(_searchQuery) ||
          order.id.toLowerCase().contains(_searchQuery);
      final matchesStatus =
          _selectedStatus == 'All' ||
          order.status.toString().split('.').last == _selectedStatus;
      final matchesCategory =
          _selectedCategory == 'All' || order.category == _selectedCategory;
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  List<String> get _categories {
    final cats = salesOrders.map((o) => o.category).toSet().toList();
    return ['All', ...cats];
  }

  double get _totalRevenue =>
      _filteredOrders.fold(0, (sum, order) => sum + order.totalAmount);

  int get _totalOrders => _filteredOrders.length;

  int get _completedOrders =>
      _filteredOrders.where((o) => o.status == SalesStatus.completed).length;

  int get _pendingOrders =>
      _filteredOrders.where((o) => o.status == SalesStatus.pending).length;

  void _showOrderDialog({SalesOrder? order}) {
    showDialog(
      context: context,
      builder: (context) => SalesOrderDialog(
        order: order,
        onSave: (updatedOrder) {
          setState(() {
            if (order != null) {
              final index = salesOrders.indexOf(order);
              salesOrders[index] = updatedOrder;
            } else {
              salesOrders.add(updatedOrder);
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteOrder(SalesOrder order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: Text('Are you sure you want to delete order ${order.id}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                salesOrders.remove(order);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order ${order.id} deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Card(
        child: Column(
          children: [
            // Sales Summary Cards
            _buildSalesSummary(theme),

            // Search and Filters
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by order ID, customer, or product...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  // Status and Category Filters
                  Row(
                    children: [
                      Expanded(
                        child: _buildFilterDropdown(
                          theme,
                          label: 'Status',
                          value: _selectedStatus,
                          items: [
                            'All',
                            'pending',
                            'processing',
                            'shipped',
                            'completed',
                            'cancelled',
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFilterDropdown(
                          theme,
                          label: 'Category',
                          value: _selectedCategory,
                          items: _categories,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sales Orders List
            Expanded(
              child: _filteredOrders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No orders found',
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = _filteredOrders[index];
                        return _buildOrderCard(order, theme);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesSummary(ThemeData theme) {
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  theme,
                  label: 'Total Revenue',
                  value: '\$${_totalRevenue.toStringAsFixed(2)}',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  theme,
                  label: 'Total Orders',
                  value: _totalOrders.toString(),
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  theme,
                  label: 'Completed',
                  value: _completedOrders.toString(),
                  icon: Icons.check_circle,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  theme,
                  label: 'Pending',
                  value: _pendingOrders.toString(),
                  icon: Icons.schedule,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    ThemeData theme, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: theme.textTheme.bodySmall),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    ThemeData theme, {
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (selected) {
        if (selected != null) onChanged(selected);
      },
    );
  }

  Widget _buildOrderCard(SalesOrder order, ThemeData theme) {
    final statusColor = _getStatusColor(order.status);
    final statusLabel = order.status.toString().split('.').last;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ${order.id}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.customerName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Product Details
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: 'Product',
                    value: order.product,
                    icon: Icons.shopping_bag,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    label: 'Category',
                    value: order.category,
                    icon: Icons.category,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quantity and Price Details
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: 'Quantity',
                    value: '${order.quantity} units',
                    icon: Icons.numbers,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    label: 'Unit Price',
                    value: '\$${order.unitPrice.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Total and Payment Status
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    label: 'Total Amount',
                    value: '\$${order.totalAmount.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    label: 'Payment',
                    value: order.paymentStatus,
                    icon: Icons.credit_card,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date
            _buildDetailItem(
              label: 'Order Date',
              value: order.date,
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showOrderDialog(order: order);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _deleteOrder(order);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(SalesStatus status) {
    switch (status) {
      case SalesStatus.pending:
        return Colors.orange;
      case SalesStatus.processing:
        return Colors.blue;
      case SalesStatus.shipped:
        return Colors.purple;
      case SalesStatus.completed:
        return Colors.green;
      case SalesStatus.cancelled:
        return Colors.red;
    }
  }
}

enum SalesStatus { pending, processing, shipped, completed, cancelled }

class SalesOrder {
  final String id;
  final String customerName;
  final String product;
  final String category;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final SalesStatus status;
  final String date;
  final String paymentStatus;

  SalesOrder({
    required this.id,
    required this.customerName,
    required this.product,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.status,
    required this.date,
    required this.paymentStatus,
  });

  SalesOrder copyWith({
    String? id,
    String? customerName,
    String? product,
    String? category,
    int? quantity,
    double? unitPrice,
    double? totalAmount,
    SalesStatus? status,
    String? date,
    String? paymentStatus,
  }) {
    return SalesOrder(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      product: product ?? this.product,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      date: date ?? this.date,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}

class SalesOrderDialog extends StatefulWidget {
  final SalesOrder? order;
  final Function(SalesOrder) onSave;

  const SalesOrderDialog({super.key, this.order, required this.onSave});

  @override
  State<SalesOrderDialog> createState() => _SalesOrderDialogState();
}

class _SalesOrderDialogState extends State<SalesOrderDialog> {
  late TextEditingController _idController;
  late TextEditingController _customerController;
  late TextEditingController _productController;
  late TextEditingController _categoryController;
  late TextEditingController _quantityController;
  late TextEditingController _unitPriceController;
  late TextEditingController _dateController;
  late String _status;
  late String _paymentStatus;

  @override
  void initState() {
    super.initState();
    final order = widget.order;
    _idController = TextEditingController(text: order?.id ?? '');
    _customerController = TextEditingController(
      text: order?.customerName ?? '',
    );
    _productController = TextEditingController(text: order?.product ?? '');
    _categoryController = TextEditingController(text: order?.category ?? '');
    _quantityController = TextEditingController(
      text: order?.quantity.toString() ?? '',
    );
    _unitPriceController = TextEditingController(
      text: order?.unitPrice.toString() ?? '',
    );
    _dateController = TextEditingController(text: order?.date ?? '');
    _status = order?.status.toString().split('.').last ?? 'pending';
    _paymentStatus = order?.paymentStatus ?? 'Pending';
  }

  @override
  void dispose() {
    _idController.dispose();
    _customerController.dispose();
    _productController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.order == null ? 'Add Sales Order' : 'Edit Sales Order',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_idController, 'Order ID', Icons.numbers),
            _buildTextField(_customerController, 'Customer Name', Icons.person),
            _buildTextField(_productController, 'Product', Icons.shopping_bag),
            _buildTextField(_categoryController, 'Category', Icons.category),
            _buildTextField(
              _quantityController,
              'Quantity',
              Icons.numbers,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              _unitPriceController,
              'Unit Price',
              Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(_dateController, 'Date', Icons.calendar_today),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.info),
              ),
              items: [
                'pending',
                'processing',
                'shipped',
                'completed',
                'cancelled',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _paymentStatus,
              decoration: InputDecoration(
                labelText: 'Payment Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.credit_card),
              ),
              items: [
                'Pending',
                'Paid',
                'Refunded',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _paymentStatus = value);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_idController.text.isEmpty ||
                _customerController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all required fields'),
                ),
              );
              return;
            }

            final quantity = int.tryParse(_quantityController.text) ?? 0;
            final unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
            final totalAmount = quantity * unitPrice;
            final statusEnum = SalesStatus.values.firstWhere(
              (e) => e.toString().split('.').last == _status,
            );

            final order = SalesOrder(
              id: _idController.text,
              customerName: _customerController.text,
              product: _productController.text,
              category: _categoryController.text,
              quantity: quantity,
              unitPrice: unitPrice,
              totalAmount: totalAmount,
              status: statusEnum,
              date: _dateController.text,
              paymentStatus: _paymentStatus,
            );

            widget.onSave(order);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
