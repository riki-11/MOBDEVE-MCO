import 'package:flutter/material.dart';

class CreateListPopup extends StatefulWidget {
  const CreateListPopup({super.key});

  @override
  State<CreateListPopup> createState() => _CreateListPopupState();
}

class _CreateListPopupState extends State<CreateListPopup> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  Text('List Description (optional)', style: Theme.of(context).textTheme.bodyLarge),
                  TextFormField(
                    // TODO: Insert controller
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
                      onPressed: () {
                        // TODO: Handle creating new list
                      },
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary
                        )
                      )
                    ),
                  )
                ]
              ),
            )
          ]
        ),
        )
      );
  }
}