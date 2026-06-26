import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectProvider>(
      builder: (context, subjectProvider, child) {
        final total = subjectProvider.totalSubjects;
        final average = subjectProvider.averageMark;
        final overallGrade = subjectProvider.overallGrade;
        final passingCount = subjectProvider.passingSubjects.length;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SummaryCard(
                  icon: Icons.book,
                  label: 'Total Subjects',
                  value: '$total',
                ),
                const SizedBox(height: 16),
                _SummaryCard(
                  icon: Icons.percent,
                  label: 'Average Mark',
                  value: average.toStringAsFixed(2),
                ),
                const SizedBox(height: 16),
                _SummaryCard(
                  icon: Icons.check_circle,
                  label: 'Passing Subjects',
                  value: '$passingCount / $total',
                ),
                const SizedBox(height: 16),
                _SummaryCard(
                  icon: Icons.grade,
                  label: 'Overall Grade',
                  value: overallGrade,
                  highlight: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlight;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: highlight ? theme.colorScheme.primary : theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: highlight
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: highlight
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: highlight
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}