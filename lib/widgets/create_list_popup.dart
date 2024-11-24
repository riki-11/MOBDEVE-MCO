import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';

class CreateListPopup extends StatefulWidget {
  const CreateListPopup({super.key});

  @override
  State<CreateListPopup> createState() => _CreateListPopupState();
}

class _CreateListPopupState extends State<CreateListPopup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text('Create a list', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center)
            ),
            Form(
              key: _formKey,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('List Title', style: Theme.of(context).textTheme.bodyLarge),
                  TextFormField(
                    // TODO: Insert controller
                      controller: titleController,
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your list.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Add a title'
                    )
                  ),
                  const SizedBox(height: 16),
                  Text('List Description', style: Theme.of(context).textTheme.bodyLarge),
                  TextFormField(
                    // TODO: Insert controller
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description for your list.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Add a description'
                    )
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary
                        )
                      ),
                      onPressed: () async {
                       if (_formKey.currentState!.validate()) {
                         // Retrieve title and description
                         String listTitle = titleController.text.trim();
                         String listDescription = descriptionController.text.trim();

                         try {
                           // Call the ListController to create the list
                           await ListController.instance.createListForCurrentUser(listTitle, listDescription);

                           // Close the popup after success
                           Navigator.of(context).pop();
                           titleController.clear();
                           descriptionController.clear();
                           // Optionally show a success message
                           Get.snackbar('Success', 'List created successfully!',
                               snackPosition: SnackPosition.BOTTOM,
                               backgroundColor: Colors.green,
                               colorText: Colors.white);
                         } catch (e) {
                           // Handle errors gracefully
                           Get.snackbar('Error', e.toString(),
                               snackPosition: SnackPosition.BOTTOM,
                               backgroundColor: Colors.red,
                               colorText: Colors.white);
                         }
                       }
                      },
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 16.0)
                ]
              ),
            ),
          ]
        ),
      ),
      );
  }
}
