import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';
import 'package:mobdeve_mco/models/list.dart';

class AddArticleToList extends StatefulWidget {
  final String articleId;
  const AddArticleToList({super.key, required this.articleId});

  @override
  State<AddArticleToList> createState() => _AddArticleToListState();
}

class _AddArticleToListState extends State<AddArticleToList> {
  late String articleId;

  final MultiSelectController<ListModel> _controller = MultiSelectController();


  // Key: List object, Value: List Name
  late Map<ListModel, String> listOptions;

  @override
  void initState() {
    super.initState();
    articleId = widget.articleId;
    listOptions = {for(ListModel list in ListController.instance.currentUserLists.value)
      list: list.title};
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Add Article to List",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          MultiSelectContainer(
            controller: _controller,
            maxSelectableCount: 3, // Adjust as per requirements
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(20),
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            items: listOptions.entries.map((entry) {
              return MultiSelectCard(
                value: entry.key,
                label: entry.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.value),
                  ],
                ),
              );
            }).toList(),
            onChange: (allSelectedItems, selectedItem) {
              print("Selected Lists: $allSelectedItems");
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
            ),
            onPressed: ()  async {
              // TODO: Save to all the articles.
              // Lists that were previously selected that were deselected will be removed from the array
              // Lists that were selected
            },
            child: Text(
              "Confirm",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
