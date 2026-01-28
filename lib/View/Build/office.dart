import 'package:flutter/material.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({super.key});

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  int _selectedOfficeIndex = -1;
  final _officeNameController = TextEditingController();
  final _officeAddressController = TextEditingController();
  final _officePhoneController = TextEditingController();
  final _officeManagerController = TextEditingController();

  List<Map<String, String>> offices = [
    {
      'name': 'Main Office',
      'address': '123 Business Ave, City, State 12345',
      'phone': '(555) 123-4567',
      'manager': 'John Doe',
      'status': 'Active',
    },
    {
      'name': 'Branch Office',
      'address': '456 Corporate Blvd, City, State 67890',
      'phone': '(555) 987-6543',
      'manager': 'Jane Smith',
      'status': 'Active',
    },
  ];

  void _clearFields() {
    _officeNameController.clear();
    _officeAddressController.clear();
    _officePhoneController.clear();
    _officeManagerController.clear();
    setState(() {
      _selectedOfficeIndex = -1;
    });
  }

  void _addOrUpdateOffice() {
    if (_officeNameController.text.isEmpty ||
        _officeAddressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() {
      if (_selectedOfficeIndex == -1) {
        offices.add({
          'name': _officeNameController.text,
          'address': _officeAddressController.text,
          'phone': _officePhoneController.text,
          'manager': _officeManagerController.text,
          'status': 'Active',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Office added successfully')),
        );
      } else {
        offices[_selectedOfficeIndex] = {
          'name': _officeNameController.text,
          'address': _officeAddressController.text,
          'phone': _officePhoneController.text,
          'manager': _officeManagerController.text,
          'status': offices[_selectedOfficeIndex]['status'] ?? 'Active',
        };
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Office updated successfully')),
        );
      }
      _clearFields();
    });
  }

  void _deleteOffice(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Office'),
        content: const Text('Are you sure you want to delete this office?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                offices.removeAt(index);
                _clearFields();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Office deleted successfully')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editOffice(int index) {
    setState(() {
      _selectedOfficeIndex = index;
      _officeNameController.text = offices[index]['name'] ?? '';
      _officeAddressController.text = offices[index]['address'] ?? '';
      _officePhoneController.text = offices[index]['phone'] ?? '';
      _officeManagerController.text = offices[index]['manager'] ?? '';
    });
  }

  @override
  void dispose() {
    _officeNameController.dispose();
    _officeAddressController.dispose();
    _officePhoneController.dispose();
    _officeManagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedOfficeIndex == -1
                              ? 'Add New Office'
                              : 'Edit Office',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A84FF),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Office Name
                        TextField(
                          controller: _officeNameController,
                          decoration: InputDecoration(
                            labelText: 'Office Name *',
                            hintText: 'Enter office name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.business),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Address
                        TextField(
                          controller: _officeAddressController,
                          decoration: InputDecoration(
                            labelText: 'Address *',
                            hintText: 'Enter office address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 15),
                        // Phone
                        TextField(
                          controller: _officePhoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter phone number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Manager
                        TextField(
                          controller: _officeManagerController,
                          decoration: InputDecoration(
                            labelText: 'Office Manager',
                            hintText: 'Enter manager name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _addOrUpdateOffice,
                                icon: Icon(
                                  _selectedOfficeIndex == -1
                                      ? Icons.add
                                      : Icons.edit,
                                ),
                                label: Text(
                                  _selectedOfficeIndex == -1
                                      ? 'Add Office'
                                      : 'Update Office',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0A84FF),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (_selectedOfficeIndex != -1)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _clearFields,
                                  icon: const Icon(Icons.close),
                                  label: const Text('Cancel'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
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
              const SizedBox(width: 20),
              // Right side - List
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Offices (${offices.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A84FF),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: offices.length,
                      itemBuilder: (context, index) {
                        final office = offices[index];
                        final isSelected = _selectedOfficeIndex == index;
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
                                      child: Text(
                                        office['name'] ?? 'N/A',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF0A84FF,
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        office['status'] ?? 'Active',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF0A84FF),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                _InfoRow(
                                  icon: Icons.location_on,
                                  label: 'Address',
                                  value: office['address'] ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                _InfoRow(
                                  icon: Icons.phone,
                                  label: 'Phone',
                                  value: office['phone'] ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                _InfoRow(
                                  icon: Icons.person,
                                  label: 'Manager',
                                  value: office['manager'] ?? 'N/A',
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: const Color(0xFF0A84FF),
                                      onPressed: () => _editOffice(index),
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () => _deleteOffice(index),
                                      tooltip: 'Delete',
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
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF0A84FF)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
