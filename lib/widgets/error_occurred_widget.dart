import 'package:flutter/material.dart';

class ErrorOccurredWidget extends StatelessWidget {
  final String errorMessage;

  ErrorOccurredWidget({
    this.errorMessage = "An Error Occurred. Try again later.",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ErrorWidget(errorMessage),
    );
  }
}
