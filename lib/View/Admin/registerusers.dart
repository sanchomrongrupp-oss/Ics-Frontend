import 'package:flutter/material.dart';

class RegisterUsersScreen extends StatefulWidget {
  const RegisterUsersScreen({super.key});

  @override
  State<RegisterUsersScreen> createState() => _RegisterUsersScreenState();
}

class _RegisterUsersScreenState extends State<RegisterUsersScreen> {
  int _selectedUserIndex = -1;
  bool _showPassword = false;

  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedPosition = 'admin';
  String _selectedStatus = 'active';

  List<Map<String, String>> users = [
    {
      'fullname': 'John Doe',
      'username': 'johndoe',
      'email': 'john@example.com',
      'password': '••••••••',
      'position': 'super',
      'status': 'active',
    },
    {
      'fullname': 'Jane Smith',
      'username': 'janesmith',
      'email': 'jane@example.com',
      'password': '••••••••',
      'position': 'admin',
      'status': 'active',
    },
  ];

  void _clearFields() {
    _fullnameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _selectedUserIndex = -1;
      _selectedPosition = 'admin';
      _selectedStatus = 'active';
      _showPassword = false;
    });
  }

  bool _validateEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  void _addOrUpdateUser() {
    if (_fullnameController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
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

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters long'),
        ),
      );
      return;
    }

    setState(() {
      if (_selectedUserIndex == -1) {
        users.add({
          'fullname': _fullnameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'position': _selectedPosition,
          'status': _selectedStatus,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully')),
        );
      } else {
        users[_selectedUserIndex] = {
          'fullname': _fullnameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'position': _selectedPosition,
          'status': _selectedStatus,
        };
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User updated successfully')),
        );
      }
      _clearFields();
    });
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
                _clearFields();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User deleted successfully')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editUser(int index) {
    setState(() {
      _selectedUserIndex = index;
      _fullnameController.text = users[index]['fullname'] ?? '';
      _usernameController.text = users[index]['username'] ?? '';
      _emailController.text = users[index]['email'] ?? '';
      _passwordController.text = users[index]['password'] ?? '';
      _selectedPosition = users[index]['position'] ?? 'admin';
      _selectedStatus = users[index]['status'] ?? 'active';
    });
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Registration',
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
                            _selectedUserIndex == -1
                                ? 'Register New User'
                                : 'Edit User',
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
                            hint: 'Enter full name',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 15),
                          // Username
                          _buildTextField(
                            controller: _usernameController,
                            label: 'Username *',
                            hint: 'Enter username',
                            icon: Icons.account_circle,
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
                          // Password
                          TextField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: 'Password *',
                              hintText: 'Enter password (min 6 characters)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0A84FF),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Position Dropdown
                          _buildDropdown(
                            label: 'Position *',
                            value: _selectedPosition,
                            items: ['admin', 'super'],
                            onChanged: (value) {
                              setState(() {
                                _selectedPosition = value!;
                              });
                            },
                            icon: Icons.security,
                          ),
                          const SizedBox(height: 20),
                          // Status Dropdown
                          _buildDropdown(
                            label: 'Status *',
                            value: _selectedStatus,
                            items: ['active', 'deleted'],
                            onChanged: (value) {
                              setState(() {
                                _selectedStatus = value!;
                              });
                            },
                            icon: Icons.toggle_on,
                          ),
                          const SizedBox(height: 30),
                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _addOrUpdateUser,
                                  icon: Icon(
                                    _selectedUserIndex == -1
                                        ? Icons.person_add
                                        : Icons.edit,
                                  ),
                                  label: Text(
                                    _selectedUserIndex == -1
                                        ? 'Register User'
                                        : 'Update User',
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
                              if (_selectedUserIndex != -1)
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
              // Right side - User List
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered Users (${users.length})',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A84FF),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final isSelected = _selectedUserIndex == index;
                        final isDeleted = user['status'] == 'deleted';
                        final isSuper = user['position'] == 'super';

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
                              : isDeleted
                              ? Colors.grey.withOpacity(0.1)
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
                                          Text(
                                            user['fullname'] ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isDeleted
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '@${user['username'] ?? 'N/A'}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
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
                                            color: isSuper
                                                ? Colors.purple.withOpacity(0.2)
                                                : const Color(
                                                    0xFF0A84FF,
                                                  ).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            user['position']?.toUpperCase() ??
                                                'N/A',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: isSuper
                                                  ? Colors.purple
                                                  : const Color(0xFF0A84FF),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDeleted
                                                ? Colors.red.withOpacity(0.2)
                                                : Colors.green.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            user['status']?.toUpperCase() ??
                                                'N/A',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: isDeleted
                                                  ? Colors.red
                                                  : Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                _UserInfoRow(
                                  icon: Icons.email,
                                  value: user['email'] ?? 'N/A',
                                ),
                                const SizedBox(height: 8),
                                _UserInfoRow(
                                  icon: Icons.lock,
                                  value: user['password'] ?? 'N/A',
                                  isMasked: true,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: const Color(0xFF0A84FF),
                                      onPressed: () => _editUser(index),
                                      tooltip: 'Edit User',
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () => _deleteUser(index),
                                      tooltip: 'Delete User',
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          underline: const SizedBox(),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(icon, size: 20, color: const Color(0xFF0A84FF)),
                  const SizedBox(width: 10),
                  Text(
                    '${label.split(' ')[0]}: ${item.toUpperCase()}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final bool isMasked;

  const _UserInfoRow({
    required this.icon,
    required this.value,
    this.isMasked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF0A84FF)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            isMasked && value != 'N/A' ? '••••••••' : value,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
