import 'package:flutter/material.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  late List<Transaction> transactions;
  late List<BudgetCategory> budgetCategories;
  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    transactions = [
      Transaction(
        id: 'TXN001',
        description: 'Office Supplies Purchase',
        category: 'Supplies',
        amount: 250.50,
        date: 'Jan 25, 2026',
        type: TransactionType.expense,
      ),
      Transaction(
        id: 'TXN002',
        description: 'Sales Revenue',
        category: 'Revenue',
        amount: 5000.00,
        date: 'Jan 24, 2026',
        type: TransactionType.income,
      ),
      Transaction(
        id: 'TXN003',
        description: 'Utility Bill',
        category: 'Utilities',
        amount: 450.00,
        date: 'Jan 23, 2026',
        type: TransactionType.expense,
      ),
      Transaction(
        id: 'TXN004',
        description: 'Employee Salaries',
        category: 'Payroll',
        amount: 12000.00,
        date: 'Jan 22, 2026',
        type: TransactionType.expense,
      ),
      Transaction(
        id: 'TXN005',
        description: 'Equipment Purchase',
        category: 'Equipment',
        amount: 3500.00,
        date: 'Jan 21, 2026',
        type: TransactionType.expense,
      ),
      Transaction(
        id: 'TXN006',
        description: 'Service Income',
        category: 'Revenue',
        amount: 2500.00,
        date: 'Jan 20, 2026',
        type: TransactionType.income,
      ),
    ];

    budgetCategories = [
      BudgetCategory(
        name: 'Payroll',
        allocated: 15000,
        spent: 12000,
        icon: Icons.people,
        color: Colors.blue,
      ),
      BudgetCategory(
        name: 'Supplies',
        allocated: 2000,
        spent: 1250,
        icon: Icons.shopping_bag,
        color: Colors.orange,
      ),
      BudgetCategory(
        name: 'Utilities',
        allocated: 1500,
        spent: 950,
        icon: Icons.bolt,
        color: Colors.green,
      ),
      BudgetCategory(
        name: 'Equipment',
        allocated: 5000,
        spent: 3500,
        icon: Icons.devices,
        color: Colors.purple,
      ),
      BudgetCategory(
        name: 'Marketing',
        allocated: 3000,
        spent: 2100,
        icon: Icons.campaign,
        color: Colors.red,
      ),
    ];
  }

  List<Transaction> get _filteredTransactions {
    return transactions.where((txn) {
      final matchesSearch =
          txn.description.toLowerCase().contains(_searchQuery) ||
          txn.category.toLowerCase().contains(_searchQuery);
      final matchesFilter =
          _selectedFilter == 'All' ||
          (_selectedFilter == 'Income' && txn.type == TransactionType.income) ||
          (_selectedFilter == 'Expense' && txn.type == TransactionType.expense);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  double get _totalIncome => transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (sum, t) => sum + t.amount);

  double get _totalExpense => transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  double get _netBalance => _totalIncome - _totalExpense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          // Financial Summary Cards
          _buildFinancialSummary(theme),

          // Search and Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search transactions...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.colorScheme.outline),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.colorScheme.outline),
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
                // Filter Chips
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedFilter == 'All',
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = 'All';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Income'),
                        selected: _selectedFilter == 'Income',
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = 'Income';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Expense'),
                        selected: _selectedFilter == 'Expense',
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = 'Expense';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tabs for Transactions and Budget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(icon: Icon(Icons.history), text: 'Transactions'),
                      Tab(icon: Icon(Icons.pie_chart), text: 'Budget'),
                    ],
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: theme.colorScheme.outline,
                  ),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        // Transactions Tab
                        _buildTransactionsList(theme),
                        // Budget Tab
                        _buildBudgetView(theme),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary(ThemeData theme) {
    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  label: 'Total Income',
                  amount: _totalIncome,
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  theme,
                  label: 'Total Expenses',
                  amount: _totalExpense,
                  icon: Icons.trending_down,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryCard(
            theme,
            label: 'Net Balance',
            amount: _netBalance,
            icon: Icons.account_balance_wallet,
            color: _netBalance >= 0 ? Colors.blue : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    ThemeData theme, {
    required String label,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: theme.textTheme.bodyMedium),
                Icon(icon, color: color, size: 24),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(ThemeData theme) {
    return _filteredTransactions.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 64,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No transactions found',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _filteredTransactions.length,
            itemBuilder: (context, index) {
              final txn = _filteredTransactions[index];
              return _buildTransactionTile(txn, theme);
            },
          );
  }

  Widget _buildTransactionTile(Transaction txn, ThemeData theme) {
    final isIncome = txn.type == TransactionType.income;
    final color = isIncome ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${txn.category} • ${txn.date}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : '-'}\$${txn.amount.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetView(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemCount: budgetCategories.length,
      itemBuilder: (context, index) {
        final budget = budgetCategories[index];
        return _buildBudgetCard(budget, theme);
      },
    );
  }

  Widget _buildBudgetCard(BudgetCategory budget, ThemeData theme) {
    final spentPercentage = (budget.spent / budget.allocated).clamp(0.0, 1.0);
    final remaining = budget.allocated - budget.spent;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: budget.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(budget.icon, color: budget.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${budget.spent.toStringAsFixed(2)} of \$${budget.allocated.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(spentPercentage * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: spentPercentage > 0.8 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: spentPercentage,
                minHeight: 8,
                backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  spentPercentage > 0.8 ? Colors.red : budget.color,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Remaining: \$${remaining.toStringAsFixed(2)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: remaining < 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String description;
  final String category;
  final double amount;
  final String date;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
  });
}

class BudgetCategory {
  final String name;
  final double allocated;
  final double spent;
  final IconData icon;
  final Color color;

  BudgetCategory({
    required this.name,
    required this.allocated,
    required this.spent,
    required this.icon,
    required this.color,
  });
}
