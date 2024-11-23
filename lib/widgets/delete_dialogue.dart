import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/pages/homepage.dart';

class DeleteDialogue extends StatelessWidget {
  final Function deleteFunction;

  const DeleteDialogue({super.key, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text("Are you sure you want to delete this item? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            deleteFunction(); // Execute the delete function
            Get.to(() => HomePage(controller: ArticleController.instance));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Set button color to red
          ),
          child: const Text("Delete",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

