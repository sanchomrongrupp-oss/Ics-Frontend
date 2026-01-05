import 'package:flutter/material.dart';

class DashContent extends StatefulWidget {
  const DashContent({super.key});

  @override
  State<DashContent> createState() => _DashContentState();
}

class _DashContentState extends State<DashContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            const Divider(),
            const Expanded(
              child: Center(
                child: Text(
                  'Your Main Content (Tables, Graphs, etc.) Goes Here',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}