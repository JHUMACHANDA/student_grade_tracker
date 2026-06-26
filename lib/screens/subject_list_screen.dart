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
            child: Text(
              'No subjects added yet.\nGo to "Add Subject" to get started.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final Subject subject = subjects[index];

            return Dismissible(
              key: ValueKey(subject),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
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
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                color: theme.cardColor,
                child: ListTile(
                  title: Text(
                    subject.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    'Mark: ${subject.mark.toStringAsFixed(1)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: _gradeColor(context, subject.grade),
                    child: Text(
                      subject.grade,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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