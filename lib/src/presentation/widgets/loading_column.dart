import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  final String message;
  const LoadingColumn({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text('$message...'),
        ],
      ),
    );
  }
}
