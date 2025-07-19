import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_router.dart';

/// Displays when navigation fails or routes are not found.
class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
              const SizedBox(height: 16),
              Text('Oops!', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(message, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => AppRouter.goHome(context), child: const Text('Go Home')),
            ],
          ),
        ),
      ),
    );
  }
}
