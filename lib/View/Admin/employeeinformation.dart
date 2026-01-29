import 'package:flutter/material.dart';

class EmployeeInformationScreen extends StatefulWidget {
  const EmployeeInformationScreen({super.key});

  @override
  State<EmployeeInformationScreen> createState() =>
      _EmployeeInformationScreenState();
}

class _EmployeeInformationScreenState extends State<EmployeeInformationScreen> {
  late List<Employee> employees;
  final bool _isDark = false;
  String _searchQuery = '';
  String _selectedDepartment = 'All';

  @override
  void initState() {
    super.initState();
    // Sample data
    employees = [
      Employee(
        id: 'EMP001',
        name: 'John Doe',
        email: 'john.doe@company.com',
        phone: '+1-234-567-8900',
        department: 'Sales',
        position: 'Sales Manager',
        joinDate: 'Jan 15, 2023',
        salary: 75000,
        status: 'Active',
      ),
      Employee(
        id: 'EMP002',
        name: 'Sarah Smith',
        email: 'sarah.smith@company.com',
        phone: '+1-234-567-8901',
        department: 'IT',
        position: 'Senior Developer',
        joinDate: 'Mar 10, 2022',
        salary: 95000,
        status: 'Active',
      ),
      Employee(
        id: 'EMP003',
        name: 'Mike Johnson',
        email: 'mike.johnson@company.com',
        phone: '+1-234-567-8902',
        department: 'HR',
        position: 'HR Specialist',
        joinDate: 'Jun 20, 2023',
        salary: 65000,
        status: 'Active',
      ),
      Employee(
        id: 'EMP004',
        name: 'Emily Brown',
        email: 'emily.brown@company.com',
        phone: '+1-234-567-8903',
        department: 'Finance',
        position: 'Financial Analyst',
        joinDate: 'Feb 05, 2023',
        salary: 70000,
        status: 'Inactive',
      ),
    ];
  }

  List<Employee> get _filteredEmployees {
    return employees.where((emp) {
      final matchesSearch =
          emp.name.toLowerCase().contains(_searchQuery) ||
          emp.id.toLowerCase().contains(_searchQuery) ||
          emp.email.toLowerCase().contains(_searchQuery);
      final matchesDepartment =
          _selectedDepartment == 'All' || emp.department == _selectedDepartment;
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  List<String> get _departments {
    final depts = _filteredEmployees.map((e) => e.department).toSet().toList();
    return ['All', ...depts];
  }

  void _showEmployeeDialog({Employee? employee}) {
    showDialog(
      context: context,
      builder: (context) => EmployeeDialog(
        employee: employee,
        onSave: (updatedEmployee) {
          setState(() {
            if (employee != null) {
              final index = employees.indexOf(employee);
              employees[index] = updatedEmployee;
            } else {
              employees.add(updatedEmployee);
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete ${employee.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                employees.remove(employee);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${employee.name} deleted')),
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
    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      cardColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A84FF),
        brightness: Brightness.light,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      cardColor: const Color(0xFF1C1C1E),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF0A84FF),
        surface: Color(0xFF1C1C1E),
        onSurface: Colors.white,
      ),
    );

    final theme = _isDark ? darkTheme : lightTheme;

    return Theme(
      data: theme,
      child: Expanded(
        child: Column(
          children: [
            // Header with Statistics
            _buildStatisticsHeader(theme),
            // Search and Filter Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by name, ID, or email...',
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
                  // Department Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _departments.length,
                      itemBuilder: (context, index) {
                        final dept = _departments[index];
                        final isSelected = _selectedDepartment == dept;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(dept),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedDepartment = dept;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Employee List
            Expanded(
              child: _filteredEmployees.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No employees found',
                            style: theme.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredEmployees.length,
                      itemBuilder: (context, index) {
                        final employee = _filteredEmployees[index];
                        return _buildEmployeeCard(employee, theme);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsHeader(ThemeData theme) {
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildStatCard(
            theme,
            icon: Icons.people,
            label: 'Total Employees',
            value: employees.length.toString(),
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            theme,
            icon: Icons.check_circle,
            label: 'Active',
            value: employees
                .where((e) => e.status == 'Active')
                .length
                .toString(),
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            theme,
            icon: Icons.cancel,
            label: 'Inactive',
            value: employees
                .where((e) => e.status == 'Inactive')
                .length
                .toString(),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(value, style: theme.textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(label, style: theme.textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(Employee employee, ThemeData theme) {
    final isActive = employee.status == 'Active';
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.name, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        '${employee.position} • ${employee.department}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    employee.status,
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.badge,
                    label: 'ID',
                    value: employee.id,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: employee.email,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: employee.phone,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.calendar_today,
                    label: 'Join Date',
                    value: employee.joinDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.attach_money,
                    label: 'Salary',
                    value: '\$${employee.salary.toString()}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showEmployeeDialog(employee: employee);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _deleteEmployee(employee);
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
    required IconData icon,
    required String label,
    required String value,
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
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
}

class Employee {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String position;
  final String joinDate;
  final int salary;
  final String status;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.position,
    required this.joinDate,
    required this.salary,
    required this.status,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? department,
    String? position,
    String? joinDate,
    int? salary,
    String? status,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      position: position ?? this.position,
      joinDate: joinDate ?? this.joinDate,
      salary: salary ?? this.salary,
      status: status ?? this.status,
    );
  }
}

class EmployeeDialog extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  const EmployeeDialog({super.key, this.employee, required this.onSave});

  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _idController;
  late TextEditingController _departmentController;
  late TextEditingController _positionController;
  late TextEditingController _joinDateController;
  late TextEditingController _salaryController;
  late String _status;

  @override
  void initState() {
    super.initState();
    final emp = widget.employee;
    _nameController = TextEditingController(text: emp?.name ?? '');
    _emailController = TextEditingController(text: emp?.email ?? '');
    _phoneController = TextEditingController(text: emp?.phone ?? '');
    _idController = TextEditingController(text: emp?.id ?? '');
    _departmentController = TextEditingController(text: emp?.department ?? '');
    _positionController = TextEditingController(text: emp?.position ?? '');
    _joinDateController = TextEditingController(text: emp?.joinDate ?? '');
    _salaryController = TextEditingController(
      text: emp?.salary.toString() ?? '',
    );
    _status = emp?.status ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    _positionController.dispose();
    _joinDateController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_idController, 'Employee ID', Icons.badge),
            _buildTextField(_nameController, 'Full Name', Icons.person),
            _buildTextField(_emailController, 'Email', Icons.email),
            _buildTextField(_phoneController, 'Phone', Icons.phone),
            _buildTextField(
              _departmentController,
              'Department',
              Icons.business,
            ),
            _buildTextField(_positionController, 'Position', Icons.work),
            _buildTextField(
              _joinDateController,
              'Join Date',
              Icons.calendar_today,
            ),
            _buildTextField(
              _salaryController,
              'Salary',
              Icons.attach_money,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.check_circle),
              ),
              items: const [
                DropdownMenuItem(value: 'Active', child: Text('Active')),
                DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _status = value;
                  });
                }
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
            if (_nameController.text.isEmpty ||
                _emailController.text.isEmpty ||
                _idController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all required fields'),
                ),
              );
              return;
            }

            final employee = Employee(
              id: _idController.text,
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              department: _departmentController.text,
              position: _positionController.text,
              joinDate: _joinDateController.text,
              salary: int.tryParse(_salaryController.text) ?? 0,
              status: _status,
            );

            widget.onSave(employee);
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
