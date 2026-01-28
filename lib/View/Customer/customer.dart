import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _selectedCustomerIndex = -1;
  String _searchQuery = '';

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _companyController = TextEditingController();
  final _searchController = TextEditingController();

  List<Map<String, String>> customers = [
    {
      'id': '001',
      'fullname': 'Alice Johnson',
      'email': 'alice@example.com',
      'phone': '(555) 123-4567',
      'address': '123 Main St',
      'city': 'New York',
      'postalcode': '10001',
      'company': 'Tech Corp',
      'status': 'active',
      'joindate': '2023-01-15',
    },
    {
      'id': '002',
      'fullname': 'Bob Williams',
      'email': 'bob@example.com',
      'phone': '(555) 987-6543',
      'address': '456 Oak Ave',
      'city': 'Los Angeles',
      'postalcode': '90001',
      'company': 'Business Inc',
      'status': 'active',
      'joindate': '2023-03-20',
    },
    {
      'id': '003',
      'fullname': 'Carol Davis',
      'email': 'carol@example.com',
      'phone': '(555) 456-7890',
      'address': '789 Pine Rd',
      'city': 'Chicago',
      'postalcode': '60601',
      'company': 'Global Solutions',
      'status': 'inactive',
      'joindate': '2023-02-10',
    },
  ];

  List<Map<String, String>> get filteredCustomers {
    if (_searchQuery.isEmpty) {
      return customers;
    }
    return customers
        .where(
          (customer) =>
              customer['fullname']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              customer['email']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              customer['phone']!.contains(_searchQuery) ||
              customer['company']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  void _clearFields() {
    _fullnameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _cityController.clear();
    _postalCodeController.clear();
    _companyController.clear();
    setState(() {
      _selectedCustomerIndex = -1;
    });
  }

  bool _validateEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _validatePhone(String phone) {
    return RegExp(r'^\(\d{3}\)\s\d{3}-\d{4}$').hasMatch(phone) ||
        phone.replaceAll(RegExp(r'[^\d]'), '').length >= 10;
  }

  void _addOrUpdateCustomer() {
    if (_fullnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (!_validateEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    if (!_validatePhone(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    setState(() {
      if (_selectedCustomerIndex == -1) {
        final newId = (int.parse(customers.last['id'] ?? '0') + 1)
            .toString()
            .padLeft(3, '0');
        customers.add({
          'id': newId,
          'fullname': _fullnameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'city': _cityController.text,
          'postalcode': _postalCodeController.text,
          'company': _companyController.text,
          'status': 'active',
          'joindate': DateTime.now().toString().split(' ')[0],
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer added successfully')),
        );
      } else {
        customers[_selectedCustomerIndex] = {
          'id': customers[_selectedCustomerIndex]['id'] ?? '',
          'fullname': _fullnameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'city': _cityController.text,
          'postalcode': _postalCodeController.text,
          'company': _companyController.text,
          'status': customers[_selectedCustomerIndex]['status'] ?? 'active',
          'joindate': customers[_selectedCustomerIndex]['joindate'] ?? '',
        };
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer updated successfully')),
        );
      }
      _clearFields();
    });
  }

  void _deleteCustomer(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Customer'),
        content: Text(
          'Are you sure you want to delete ${customers[index]['fullname']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                customers.removeAt(index);
                _clearFields();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Customer deleted successfully')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editCustomer(int index) {
    setState(() {
      _selectedCustomerIndex = index;
      _fullnameController.text = customers[index]['fullname'] ?? '';
      _emailController.text = customers[index]['email'] ?? '';
      _phoneController.text = customers[index]['phone'] ?? '';
      _addressController.text = customers[index]['address'] ?? '';
      _cityController.text = customers[index]['city'] ?? '';
      _postalCodeController.text = customers[index]['postalcode'] ?? '';
      _companyController.text = customers[index]['company'] ?? '';
    });
  }

  void _toggleCustomerStatus(int index) {
    setState(() {
      customers[index]['status'] = customers[index]['status'] == 'active'
          ? 'inactive'
          : 'active';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Customer status updated to ${customers[index]['status']}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _companyController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF0A84FF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Form
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedCustomerIndex == -1
                                ? 'Add New Customer'
                                : 'Edit Customer',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0A84FF),
                            ),
                          ),
                          const SizedBox(height: 25),
                          // Full Name
                          _buildTextField(
                            controller: _fullnameController,
                            label: 'Full Name *',
                            hint: 'Enter customer full name',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 15),
                          // Email
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email Address *',
                            hint: 'Enter email address',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          // Phone
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone Number *',
                            hint: 'Enter phone number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 15),
                          // Company
                          _buildTextField(
                            controller: _companyController,
                            label: 'Company',
                            hint: 'Enter company name',
                            icon: Icons.business,
                          ),
                          const SizedBox(height: 15),
                          // Address
                          _buildTextField(
                            controller: _addressController,
                            label: 'Address *',
                            hint: 'Enter street address',
                            icon: Icons.location_on,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 15),
                          // City
                          _buildTextField(
                            controller: _cityController,
                            label: 'City *',
                            hint: 'Enter city',
                            icon: Icons.location_city,
                          ),
                          const SizedBox(height: 15),
                          // Postal Code
                          _buildTextField(
                            controller: _postalCodeController,
                            label: 'Postal Code',
                            hint: 'Enter postal code',
                            icon: Icons.pin,
                          ),
                          const SizedBox(height: 30),
                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _addOrUpdateCustomer,
                                  icon: Icon(
                                    _selectedCustomerIndex == -1
                                        ? Icons.person_add
                                        : Icons.edit,
                                  ),
                                  label: Text(
                                    _selectedCustomerIndex == -1
                                        ? 'Add Customer'
                                        : 'Update Customer',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0A84FF),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (_selectedCustomerIndex != -1)
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _clearFields,
                                    icon: const Icon(Icons.close),
                                    label: const Text('Cancel'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Right side - Customer List
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customers (${filteredCustomers.length})',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A84FF),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A84FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Total: ${customers.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0A84FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by name, email, phone, or company...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF0A84FF),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Customer List
                    if (filteredCustomers.isEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_off,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No customers found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCustomers.length,
                        itemBuilder: (context, index) {
                          final actualIndex = customers.indexOf(
                            filteredCustomers[index],
                          );
                          final customer = filteredCustomers[index];
                          final isSelected =
                              _selectedCustomerIndex == actualIndex;
                          final isInactive = customer['status'] == 'inactive';

                          return Card(
                            elevation: isSelected ? 4 : 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: isSelected
                                  ? const BorderSide(
                                      color: Color(0xFF0A84FF),
                                      width: 2,
                                    )
                                  : BorderSide.none,
                            ),
                            color: isSelected
                                ? const Color(0xFF0A84FF).withOpacity(0.1)
                                : isInactive
                                ? Colors.grey.withOpacity(0.05)
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFF0A84FF,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    'ID: ${customer['id']}',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    customer['fullname'] ??
                                                        'N/A',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isInactive
                                                          ? Colors.grey
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            if (customer['company'] != null &&
                                                customer['company']!.isNotEmpty)
                                              Text(
                                                customer['company'] ?? 'N/A',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isInactive
                                                  ? Colors.red.withOpacity(0.2)
                                                  : Colors.green.withOpacity(
                                                      0.2,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              customer['status']
                                                      ?.toUpperCase() ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                color: isInactive
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Joined: ${customer['joindate']}',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  _CustomerInfoRow(
                                    icon: Icons.email,
                                    label: 'Email',
                                    value: customer['email'] ?? 'N/A',
                                  ),
                                  const SizedBox(height: 6),
                                  _CustomerInfoRow(
                                    icon: Icons.phone,
                                    label: 'Phone',
                                    value: customer['phone'] ?? 'N/A',
                                  ),
                                  const SizedBox(height: 6),
                                  _CustomerInfoRow(
                                    icon: Icons.location_on,
                                    label: 'Address',
                                    value:
                                        '${customer['address']}, ${customer['city']}',
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: const Color(0xFF0A84FF),
                                        onPressed: () =>
                                            _editCustomer(actualIndex),
                                        tooltip: 'Edit Customer',
                                        iconSize: 20,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isInactive
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                        ),
                                        color: isInactive
                                            ? Colors.green
                                            : Colors.orange,
                                        onPressed: () =>
                                            _toggleCustomerStatus(actualIndex),
                                        tooltip: isInactive
                                            ? 'Activate'
                                            : 'Deactivate',
                                        iconSize: 20,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () =>
                                            _deleteCustomer(actualIndex),
                                        tooltip: 'Delete Customer',
                                        iconSize: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0A84FF), width: 2),
        ),
      ),
    );
  }
}

class _CustomerInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CustomerInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF0A84FF)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 11, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
