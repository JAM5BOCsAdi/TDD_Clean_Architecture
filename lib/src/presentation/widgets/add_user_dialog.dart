import 'package:flutter/material.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
  const AddUserDialog({Key? key, required this.nameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
