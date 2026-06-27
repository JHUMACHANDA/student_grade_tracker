import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../models/subject.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  Color _gradeColor(BuildContext context, String grade) {
    final theme = Theme.of(context);
    switch (grade) {
      case 'A':
        return theme.colorScheme.primary;
      case 'B':
        return theme.colorScheme.secondary;
      case 'C':
        return theme.colorScheme.tertiary;
      default:
        return theme.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<SubjectProvider>(
      builder: (context, subjectProvider, child) {
        final subjects = subjectProvider.subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 56,
                  color: theme.colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 12),
                Text(
                  'No subjects added yet.\nGo to "Add" to get started.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final Subject subject = subjects[index];
            final gradeColor = _gradeColor(context, subject.grade);

            return Dismissible(
              key: ValueKey(subject),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.onError,
                ),
              ),
              onDismissed: (direction) {
                final name = subject.name;
                subjectProvider.removeSubject(subject);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$name removed'),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border(
                    left: BorderSide(color: gradeColor, width: 5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onSurface.withOpacity(0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subject.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 10,
                              runSpacing: 4,
                              children: [
                                _InfoChip(
                                  icon: Icons.score,
                                  label: 'Mark: ${subject.mark.toStringAsFixed(1)}',
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                                _InfoChip(
                                  icon: Icons.grade,
                                  label: 'Grade: ${subject.grade}',
                                  color: gradeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: gradeColor,
                        child: Text(
                          subject.grade,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}