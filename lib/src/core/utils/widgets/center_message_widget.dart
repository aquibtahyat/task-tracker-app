import 'package:flutter/material.dart';

class CenterMessageWidget extends StatelessWidget {
  const CenterMessageWidget({super.key, this.message = 'Nothing to show'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(message, style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
