import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class AddArticleToList extends StatefulWidget {
  final String articleId;
  const AddArticleToList({super.key, required this.articleId});

  @override
  State<AddArticleToList> createState() => _AddArticleToListState();
}

class _AddArticleToListState extends State<AddArticleToList> {
  late String articleId;

  final MultiSelectController<String?> _controller = MultiSelectController();

  // TODO: Insert lists here.
  final Map<String, String> listOptions = {
    "1": "List 1: Freshman Year",
    "2": "List 2: Sophomore Year",
    "3": "List 3: Junior Year",
  };

  @override
  void initState() {
    super.initState();
    articleId = widget.articleId;
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
            onPressed: () {
              // TODO: Save to all the articles.
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
